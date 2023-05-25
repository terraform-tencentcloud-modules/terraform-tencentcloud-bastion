locals {
  eip_enabled              = !var.allocate_public_ip && var.create_eip
  public_dns               = local.eip_enabled ? local.public_dns_rendered : join("", module.cvm.*.public_ip)
  public_dns_rendered      = local.eip_enabled ? join("", tencentcloud_eip.default.*.public_ip): null
  #user_data_templated = templatefile("${path.module}/${var.user_data_template}", {
    #user_data   = join("\n", var.user_data)
    #ssm_enabled = var.ssm_enabled
    #ssh_user    = var.ssh_user
  #})
}

# Query mirrors based on conditions
#data "tencentcloud_image" "default" {
  #count =  var.image == null ? 1 : 0
  #dynamic "filter" {
    #for_each = var.image_filter
    #content {
      #name   = filter.key
      #values = filter.value
    #}
  #}
#}

data "tencentcloud_images" "os" {
  instance_type    = var.instance_type
  os_name          = var.os_name
  image_name_regex = var.image_name_regex
  image_type       = var.image_type
  image_id         = var.image_id
}

# Creating a Security Group
module "security_group" {
  source                   = "terraform-tencentcloud-modules/security-group/tencentcloud"
  version                  = "1.1.1"
  count                    = var.create_security_group ? 1 : 0
  name                     = var.security_group_name
  ingress_with_cidr_blocks = var.ingress_with_cidr_blocks
  egress_with_cidr_blocks  = var.egress_with_cidr_blocks
  description              = var.security_group_description
}

module "cvm" {
    source                     = "terraform-tencentcloud-modules/cvm/tencentcloud"
    version                    = "1.0.0"

    instance_name              = var.instance_name
    # The Bastion hostname, which can be used as a domain name to access the Bastion host
    #hostname                  = var.host_name
    availability_zone          = var.availability_zone
    instance_type              = var.instance_type
    image_id                   = data.tencentcloud_images.os.images[0].image_id

    system_disk_type           = var.system_disk_type
    system_disk_size           = var.system_disk_size

    allocate_public_ip         = var.allocate_public_ip
    vpc_id                     = var.vpc_id
    subnet_id                  = var.subnet_id
    internet_max_bandwidth_out = var.internet_max_bandwidth_out
    key_ids                    = var.key_ids
    password                   = var.password
    security_group_ids         = compact(concat(module.security_group.*.security_group_id, var.security_group_ids))
    monitoring                 = var.monitoring
    user_data_raw              = var.user_data_raw
    user_data_base64           = var.user_data_base64
    cam_role_name              = var.cam_role_name
    cbs_block_devices          = var.cbs_block_devices
    cbs_block_device_ids       = var.cbs_block_device_ids
    tags                       = var.tags
}

# Bind the eip to the cvm instance
resource "tencentcloud_eip" "default" {
  count                = local.eip_enabled ? 1 : 0
  name                 = var.eip_name
  tags                 = var.tags
}

resource "tencentcloud_eip_association" "default" {
  count                = local.eip_enabled ? 1 : 0
  eip_id               = tencentcloud_eip.default[0].id
  instance_id          = module.cvm.instance_id
}

## public dns config
resource "tencentcloud_dnspod_domain_instance" "foo" {
   count  = var.dns_type == "public" ? 1 : 0
   domain = var.host_name
   remark = "this is demo"
}

resource "tencentcloud_dnspod_record" "demo" {
  count       = var.dns_type == "public" ? 1 : 0
  domain      = var.host_name
  record_type = "A"
  record_line = "默认"
  value       = local.public_dns
}

## private dns config
resource "tencentcloud_private_dns_zone" "foo" {
  count              = var.dns_type == "private" ? 1 : 0
  domain             = var.host_name
  vpc_set {
    region           = var.region
    uniq_vpc_id      = var.vpc_id
  }
  remark             = "test"
  dns_forward_status = "DISABLED"
  tags               = var.tags
}

resource "tencentcloud_private_dns_record" "foo" {
  count        = var.dns_type == "private" ? 1 : 0
  zone_id      = tencentcloud_private_dns_zone.foo[0].id
  record_type  = "A"
  record_value = local.public_dns
  sub_domain   = "@"
  ttl          = 60
  weight       = 1
}