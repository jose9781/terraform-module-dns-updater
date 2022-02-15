/**
* # Terraform
*
* This module is capable of creating an arbitrary set of DNS entries against a DNS Server as per RFC-2136 by using
* the official [DNS Terraform provider](https://registry.terraform.io/providers/hashicorp/dns/latest).
* In order to create DNS records dynamically,the module reads an arbitrary number of JSON files from a local directory
* included as an input that contain all the necessary attributes to create DNS records 
*
* ## Usage
*
* ### Quick Example
*
* ```hcl
* module "dns_updater" {
*   source = "./dns-updater"
*   input1 = source_files_path
* } 
* ```
*
*/
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# ---------------------------------------------------------------------------------------------------------------------
# SET TERRAFORM RUNTIME REQUIREMENTS
# ---------------------------------------------------------------------------------------------------------------------

terraform {
  # This module has been updated with 0.12 syntax, which means it is no longer compatible with any versions below 0.12.
  # This module is now only being tested with Terraform 0.13.x. However, to make upgrading easier, we are setting
  # 0.12.26 as the minimum version, as that version added support for required_providers with source URLs, making it
  # forwards compatible with 0.13.x code.
  required_version = ">= 0.13.5"
  required_providers {
    dns = {
      source  = "hashicorp/dns"
      version = ">= 3.2.0"
    }
  }
}


# ------------------------------------------
# Write your local resources here
# ------------------------------------------

locals {

  valid_extension = ".json"
#  source_files_path = "${path.module}/examples/exercise/input-json/"
  source_files_path = var.source_files_path  

  ## Discarding everything but JSON files
  valid_files = fileset(local.source_files_path, "*${local.valid_extension}")

  ## Filling up a list of the domain_names from the file names but trimming the extension
  domain_names = [for file in local.valid_files : trimsuffix(file, "${local.valid_extension}")]

  ## Creating an object containing the name of every domain and a map with their attributes
  a_records = {for file in local.domain_names : file => jsondecode(file("${local.source_files_path}/${file}.json"))}

}

# ------------------------------------------
# Write your Terraform resources here
# ------------------------------------------


resource "dns_a_record_set" "record"  {

 ### It will iterate over all the a_records gathered in the local.a_records
 for_each = local.a_records

 zone = each.value.zone
 name = each.key
 addresses = each.value.addresses
 ttl = each.value.ttl

}


