output "cur_cloudformation_stack" {
  description = "CUR Cloudformation stack attributes"
  value       = aws_cloudformation_stack.cur
}

output "cur_cloudformation_stack_name" {
  description = "CUR Clouformation stack name"
  value       = local.stack_name
}
