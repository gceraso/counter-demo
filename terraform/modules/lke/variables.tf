variable "autoscaler_max" {
  description = "If the autoscaler is enabled, the maximum amount of nodes to run."
  default     = ""
}
variable "autoscaler_min" {
  description = "If the autoscaler is enabled, the minimum amount of nodes to run."
  default     = ""
}
variable "cluster_name" {
  description = "Name of the cluster"
  default     = "demo"
}
variable "enable_autoscaler" {
  description = "Enable or disable the autoscaler"
  default     = "false"
}
variable "k8s_version" {
  description = "Version of Kubernetes the cluster should run"
  default     = "1.27"
}
variable "pool_instance_count" {
  description = "Count of instances required to run"
  default     = "5"
}
variable "pool_instance_type" {
  description = "Type of instance to run in the cluster"
  default     = "us-east"
}
variable "region" {
  description = "Region to run the cluster in"
  default     = "us-east"
}
variable "tags" {
  description = "List of tags for the cluster"
  type        = list(string)
  default     = ["prod"]
}