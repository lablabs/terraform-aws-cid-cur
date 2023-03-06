# AWS CID CUR Terraform module

[<img src="https://lablabs.io/static/ll-logo.png" width=350px>](https://lablabs.io/)

We help companies build, run, deploy and scale software and infrastructure by embracing the right technologies and principles. Check out our website at <https://lablabs.io/>

---

[![Terraform validate](https://github.com/lablabs/terraform-aws-cid-cur/actions/workflows/validate.yaml/badge.svg)](https://github.com/lablabs/terraform-aws-cid-cur/actions/workflows/validate.yaml)
[![pre-commit](https://github.com/lablabs/terraform-aws-cid-cur/actions/workflows/pre-commit.yml/badge.svg)](https://github.com/lablabs/terraform-aws-cid-cur/actions/workflows/pre-commit.yml)

## Description

A Terraform module to provision cost and usage report (CUR) automation. Part of [Cloud Intelligence Dashboard framework](https://github.com/aws-samples/aws-cudos-framework-deployment) (CUDOS).
Module is using cloudformation template released and maintained by *CUDOS* project.

There are two types of deployments - **source** and **destination**.

- **Source** deployment should be deployed in single AWS account or Organization management account (where consolidated billing is placed). It will setup a **Cost and Usage report** which will store usage data into source S3 bucket. This bucket is then replicated to destination S3 bucket (based on destination account id).

```bash
module "cur_source" {
  source = "github.com/lablabs/terraform-aws-cid-cur?ref=0.1.0"

  destination_account_id = "0987654321"     #aggregation account id - for s3 replication
  usage                  = "source"
  tags                   = local.tags
}
```

- **Destination** deployment should be deployed in centralized AWS Account for aggregation of CUR data single or multiple AWS accounts. It will create a shared S3 bucket where CUR data will be replicated.

```bash
data "aws_caller_identity" "current" {}

module "cur_destination" {
  source = "github.com/lablabs/terraform-aws-cid-cur?ref=0.1.0"

  destination_account_id = data.aws_caller_identity.current.account_id  #current account id
  usage                  = "destination"
  source_account_ids     = ["1234567890","2345678901"]                  #list of account ids from which data will be        replicated
  tags                   = local.tags
}
```

For more information please follow the [AWS Well-Architected Lab](https://www.wellarchitectedlabs.com/cost/200_labs/200_cloud_intelligence/cost-usage-report-dashboards/dashboards/deploy_dashboards/) which can provide you with additional information about the possible setup.

## Examples

See [Basic example](examples/basic/README.md) for further information.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudformation_stack.cur](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_usage"></a> [usage](#input\_usage) | (Mandatory) Usage of CID CUR template - source or destination | `string` | n/a | yes |
| <a name="input_capabilities_iam"></a> [capabilities\_iam](#input\_capabilities\_iam) | (Default) List of IAM capabilties requested for cloudformation stack execution | `list(string)` | <pre>[<br>  "CAPABILITY_IAM"<br>]</pre> | no |
| <a name="input_cfn_template_url"></a> [cfn\_template\_url](#input\_cfn\_template\_url) | (Default) CID CFN template URL to use | `string` | `"https://aws-managed-cost-intelligence-dashboards.s3.amazonaws.com/cfn/cur-aggregation.yml"` | no |
| <a name="input_create_cur"></a> [create\_cur](#input\_create\_cur) | (Default) Enable creation of cur. Default true. | `bool` | `true` | no |
| <a name="input_destination_account_id"></a> [destination\_account\_id](#input\_destination\_account\_id) | (Optional) Destination account id - put current account id | `string` | `""` | no |
| <a name="input_resource_prefix"></a> [resource\_prefix](#input\_resource\_prefix) | (Default) Prefix for CUR resources | `string` | `"cid"` | no |
| <a name="input_source_account_ids"></a> [source\_account\_ids](#input\_source\_account\_ids) | (Optional) List of source account ids - leave empty for source account deployment | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| <a name="input_stack_name"></a> [stack\_name](#input\_stack\_name) | (Default) Stack name | `string` | `"cid-cur"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) Deployment specific tags | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cur_cloudformation_stack"></a> [cur\_cloudformation\_stack](#output\_cur\_cloudformation\_stack) | CUR Cloudformation stack attributes |
| <a name="output_cur_cloudformation_stack_name"></a> [cur\_cloudformation\_stack\_name](#output\_cur\_cloudformation\_stack\_name) | CUR Clouformation stack name |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Contributing and reporting issues

Feel free to create an issue in this repository if you have questions, suggestions or feature requests.

### Validation, linters and pull-requests

We want to provide high quality code and modules. For this reason we are using
several [pre-commit hooks](.pre-commit-config.yaml) and
[GitHub Actions workflows](.github/workflows/). A pull-request to the
main branch will trigger these validations and lints automatically. Please
check your code before you will create pull-requests. See
[pre-commit documentation](https://pre-commit.com/) and
[GitHub Actions documentation](https://docs.github.com/en/actions) for further
details.

## License

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

See [LICENSE](LICENSE) for full details.

    Licensed to the Apache Software Foundation (ASF) under one
    or more contributor license agreements.  See the NOTICE file
    distributed with this work for additional information
    regarding copyright ownership.  The ASF licenses this file
    to you under the Apache License, Version 2.0 (the
    "License"); you may not use this file except in compliance
    with the License.  You may obtain a copy of the License at

      https://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing,
    software distributed under the License is distributed on an
    "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
    KIND, either express or implied.  See the License for the
    specific language governing permissions and limitations
    under the License.
