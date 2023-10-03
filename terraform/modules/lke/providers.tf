terraform {
  required_version = ">= 1.5"
  required_providers {
    linode = {
      source  = "linode/linode"
      version = "1.29.4"
    }
  }
}