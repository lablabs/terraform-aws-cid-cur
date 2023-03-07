locals {
  create_cur = var.create_cur ? "True" : "False"
  stack_name = "${var.stack_name}-${var.usage}"
}

resource "aws_cloudformation_stack" "cur" {
  #checkov:skip=CKV_AWS_124:Ensure that CloudFormation stacks are sending event notifications to an SNS topic
  name = local.stack_name

  parameters = {
    DestinationAccountId = var.destination_account_id        #string
    ResourcePrefix       = var.resource_prefix               #string
    CreateCUR            = local.create_cur                  #string
    SourceAccountIds     = join(",", var.source_account_ids) #comma delimited list of account ids
  }

  capabilities = var.capabilities_iam
  template_url = var.cfn_template_url

  tags = var.tags
}
