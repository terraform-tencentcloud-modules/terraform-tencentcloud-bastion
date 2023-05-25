
# security_group begin
variable "create_security_group" {
  type        = bool
  description = "Whether to create default Security Group for bastion host."
  default     = true
}

variable "security_group_description" {
  type        = string
  default     = "Bastion host security group"
  description = "The Security Group description."
}

variable "security_group_name" {
  type        = string
  default     = ""
  description = "The Security Group name."
}

variable "ingress_with_cidr_blocks" {
  type        = list(map(string))
  default     = [
          {
            port        = "8080-9090"
            protocol    = "TCP"
            cidr_block  = "10.4.0.0/16"
            policy      = "accept"
            description = "test-security-group1"
          },
  ]
  description = "List of ingress rules to create where `cidr_block` is used."
}

variable "egress_with_cidr_blocks" {
  type        = list(map(string))
  default     = [
            {
              port        = "8080-9090"
              protocol    = "TCP"
              cidr_block  = "10.4.0.0/16"
              policy      = "accept"
              description = "test-security-group2"
            }
    ]
  description = "List of egress rules to create where `cidr_block` is used."
}
# security_group end
# cvm instance begin
variable "create_instance" {
  type        = bool
  description = "Whether to create cvm instance."
  default     = true
}

variable "instance_name" {
  description = "the name of instance to create."
  type        = string
  default     = null
}

variable "availability_zone" {
  description = "The available zone for the instance.  "
  type        = string
  default     = null
}

variable "image_id" {
  description = "The image to use for the instance. Changing image_id will cause the instance reset."
  type        = string
  default     = null
}

variable "instance_type" {
  description = "instance type of instance."
  default     = ""
}

variable "system_disk_type" {
  description = "System disk type. For more information on limits of system disk types, see Storage Overview. Valid values: LOCAL_BASIC: local disk, LOCAL_SSD: local SSD disk, CLOUD_SSD: SSD, CLOUD_PREMIUM: Premium Cloud"
  type        = string
  default     = "CLOUD_PREMIUM"
}

variable "system_disk_size" {
  type        = number
  description = "Size of the system disk. unit is GB, Default is 50GB. If modified, the instance may force stop."
  default     = 50
}

variable "allocate_public_ip" {
  description = "Associate a public IP address with an instance in a VPC or Classic. Boolean value, Default is false."
  default     = false
  type        = bool
}

variable "internet_max_bandwidth_out" {
  type        = number
  default     = 10
  description = "Maximum outgoing bandwidth to the public network, measured in Mbps (Mega bits per second). This value does not need to be set when allocate_public_ip is false."
}

variable "vpc_id" {
  description = "The ID of a VPC network. If you want to create instances in a VPC network, this parameter must be set or the default vpc will be used."
  type        = string
  default     = null
}

variable "subnet_id" {
  type        = string
  default     = null
  description = "The ID of a VPC subnet. If you want to create instances in a VPC network, this parameter must be set or the default subnet will be used."
}

variable "key_ids" {
  description = "Key ids of the Key Pair to use for the instance; which can be managed using the `tencentcloud_key_pair` resource"
  type        = list(string)
  default     = null
}

variable "password" {
  description = "Login password of the instance. For Linux instances, the password must include 8-30 characters, and contain at least two of the following character sets: [a-z], [A-Z], [0-9] and [()`~!@#$%^&*-+="
  type        = string
  default     = null
}

variable "security_group_ids" {
  type        = list(string)
  default     = []
  description = "A list of orderly security group IDs to associate with."
}

variable "cbs_block_devices" {
  description = "Additional CBS block devices to attach to the instance. see resource tencentcloud_cbs_storage."
  type        = list(map(string))
  default     = []
}

variable "cbs_block_device_ids" {
  description = "Attach exist CBS block devices to the instance by id.  see resource tencentcloud_cbs_storage."
  type        = list(string)
  default     = []
}

variable "cbs_tags" {
  description = "Additional tags to assign to cbs resource."
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

variable "monitoring" {
  description = "If true, the launched CVM instance will have detailed monitoring enabled"
  type        = bool
  default     = true
}


variable "user_data_raw" {
  description = "The user data to provide when launching the instance. Do not pass gzip-compressed data via this argument; see user_data_base64 instead."
  type        = string
  default     = null
}

variable "user_data_base64" {
  description = "Can be used instead of user_data_raw to pass base64-encoded binary data directly. Use this instead of user_data_raw whenever the value is not a valid UTF-8 string. For example, gzip-encoded user data must be base64-encoded and passed via this argument to avoid corruption."
  type        = string
  default     = null
}

variable "cam_role_name" {
  description = "CAM role name authorized to access."
  type        = string
  default     = null
}

variable "eni_ids" {
  description = "A list of eni_id to bind with the instance. see resource tencentcloud_eni."
  type        = list(string)
  default     = []
}

variable "disable_api_termination" {
  type        = bool
  description = "Whether the termination protection is enabled. Default is false. If set true, which means that this instance can not be deleted by an API action."
  default     = false
}
# cvm instance end
# dns config begin
variable "host_name" {
  type        = string
  default     = "bastion"
  description = "The Bastion hostname, which can be used as a domain name to access the Bastion host"
}
variable "dns_type" {
  type        = string
  default     = "private"
  description = "The value can be public or private. If the value is public, the dns can be resolved on the public network. Otherwise, the DNS can be resolved only on the private network. "
}
# dns config end
# eip config begin
variable "create_eip" {
  type        = bool
  description = "Whether to create eip for bastion host."
  default     = true
}
variable "eip_name" {
  type        = string
  default     = ""
  description = "The Name of the eip ."
}
# eip config end
variable "region" {
  description = "The region of instance"
  type        = string
  default     = "ap-guangzhou"
}
