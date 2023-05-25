output "instance_id" {
  value       = module.tencent_bastion.instance_id
  description = "Instance ID"
}

output "security_group_ids" {
  description = "IDs on the  Security Groups associated with the instance"
  value = compact(
    concat(
      formatlist("%s", module.tencent_bastion.security_group_id),
      var.security_group_ids
    )
  )
}

output "role" {
  value       = module.tencent_bastion.role
  description = "Name of CAM Role associated with the instance"
}

output "public_ip" {
  value       = module.tencent_bastion.public_ip
  description = "Public IP of the instance (or EIP)"
}

output "hostname" {
  value       = var.host_name
  description = "DNS hostname"
}

output "security_group_id" {
  value       = module.tencent_bastion.security_group_id
  description = "Bastion host Security Group ID"
}

output "security_group_name" {
  value       = module.tencent_bastion.security_group_name
  description = "Bastion host Security Group name"
}