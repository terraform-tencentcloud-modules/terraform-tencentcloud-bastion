
# Query mirrors based on conditions
data "tencentcloud_image" "default" {
  #count =  var.image == null ? 1 : 0
  dynamic "filter" {
    for_each = var.image_filter
    content {
      name   = filter.key
      values = filter.value
    }
  }
}

data "tencentcloud_instance_types" "c2m2" {
  exclude_sold_out  = true
  cpu_core_count    = 2
  memory_size       = 2
  availability_zone = var.availability_zone
}

data "tencentcloud_images" "tencentos" {
  instance_type    = data.tencentcloud_instance_types.c2m2.instance_types[0].instance_type
  os_name          = "tencentos"
}

module "vpc" {
  source             = "terraform-tencentcloud-modules/vpc/tencentcloud"
  vpc_cidr           = "10.0.0.0/16"
  subnet_cidrs       = ["10.0.1.0/24"]
  availability_zones = [var.availability_zone]
  vpc_name           = "cvm-test-vpc"
  tags               = var.tags
}

module "tencent_bastion" {
    source                     = "../../"
    # instance config
    instance_name              = var.instance_name
    host_name                  = var.host_name
    availability_zone          = var.availability_zone
    instance_type              = data.tencentcloud_instance_types.c2m2.instance_types[0].instance_type
    image_id                   = data.tencentcloud_images.tencentos.images[0].image_id

    system_disk_type           = var.system_disk_type
    system_disk_size           = var.system_disk_size

    allocate_public_ip         = var.allocate_public_ip
    vpc_id                     = module.vpc.vpc_id
    subnet_id                  = module.vpc.subnet_id[0]
    internet_max_bandwidth_out = var.internet_max_bandwidth_out
    key_ids                    = var.key_ids
    password                   = var.password
    #security_group
    create_security_group      = var.create_security_group
    security_group_ids         = var.security_group_ids
    security_group_name        = var.security_group_name
    ingress_with_cidr_blocks   = var.ingress_with_cidr_blocks
    egress_with_cidr_blocks    = var.egress_with_cidr_blocks
    monitoring                 = var.monitoring
    user_data_raw              = var.user_data_raw
    user_data_base64           = var.user_data_base64
    cam_role_name              = var.cam_role_name
    tags                       = var.tags
    #eip
    create_eip                 = var.create_eip
    eip_name                   = var.eip_name
    #dns
    dns_type                   = var.dns_type
    #cbs device
    cbs_block_devices          = var.cbs_block_devices
    cbs_block_device_ids       = var.cbs_block_device_ids
    region                     = var.region
}



