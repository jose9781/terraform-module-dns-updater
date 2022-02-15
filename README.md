# Terraform Coding Exercise

Please read the [instructions](./INSTRUCTIONS.md) file.
<!-- BEGIN_TF_DOCS -->
# Terraform

This module is capable of creating an arbitrary set of DNS entries against a DNS Server as per RFC-2136 by using
the official [DNS Terraform provider](https://registry.terraform.io/providers/hashicorp/dns/latest).
In order to create DNS records dynamically,the module reads an arbitrary number of JSON files from a local directory
included as an input that contain all the necessary attributes to create DNS records

## Usage

### Quick Example

```hcl
module "dns_updater" {
  source = "./dns-updater"

  source_files_path = "input-json/"
}
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.5 |
| <a name="requirement_dns"></a> [dns](#requirement\_dns) | >= 3.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_dns"></a> [dns](#provider\_dns) | 3.2.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [dns_a_record_set.record](https://registry.terraform.io/providers/hashicorp/dns/latest/docs/resources/a_record_set) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_source_files_path"></a> [source\_files\_path](#input\_source\_files\_path) | Path of the JSON files with the DNS records attributes | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->