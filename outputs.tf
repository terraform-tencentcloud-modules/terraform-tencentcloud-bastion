output "instance_id" {
  value       = module.cvm.instance_id
  description = "Instance ID"
}

output "security_group_ids" {
  description = "IDs on the  Security Groups associated with the instance"
  value = compact(
    concat(
      formatlist("%s", var.create_security_group ? module.security_group[0].security_group_id : ""),
      var.security_group_ids
    )
  )
}

output "role" {
  value       = var.cam_role_name
  description = "Name of CAM Role associated with the instance"
}

output "public_ip" {
  value       = local.public_dns
  description = "Public IP of the instance (or EIP)"
}

output "hostname" {
  value       = var.host_name
  description = "DNS hostname"
}

output "security_group_id" {
  value       = var.create_security_group ? module.security_group[0].security_group_id : ""
  description = "Bastion host Security Group ID"
}

output "security_group_name" {
  value       = var.create_security_group ? module.security_group[0].security_group_name: ""
  description = "Bastion host Security Group name"
}