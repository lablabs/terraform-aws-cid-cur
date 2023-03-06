variable "stack_name" {
  type        = string
  description = "(Default) Stack name"
  default     = "cid-cur"
}

variable "usage" {
  type        = string
  description = "(Mandatory) Usage of CID CUR template - source or destination"

  validation {
    condition     = var.usage == "source" || var.usage == "destination"
    error_message = "Valid values for usage are source or destination"
  }
}

variable "create_cur" {
  type        = bool
  description = "(Default) Enable creation of cur. Default true."
  default     = true
}

variable "resource_prefix" {
  type        = string
  description = "(Default) Prefix for CUR resources"
  default     = "cid"
}

variable "destination_account_id" {
  type        = string
  description = "(Optional) Destination account id - put current account id"
  default     = ""
}

variable "source_account_ids" {
  type        = list(string)
  description = "(Optional) List of source account ids - leave empty for source account deployment"
  default     = [""]
}

variable "cfn_template_url" {
  type        = string
  description = "(Default) CID CFN template URL to use"
  default     = "https://aws-managed-cost-intelligence-dashboards.s3.amazonaws.com/cfn/cur-aggregation.yml"
}

variable "capabilities_iam" {
  type        = list(string)
  description = "(Default) List of IAM capabilties requested for cloudformation stack execution"
  default     = ["CAPABILITY_IAM"]
}

variable "tags" {
  type        = map(string)
  description = "(Optional) Deployment specific tags"
  default     = {}
}
