module "lke" {
  source = "../../modules/lke"

  cluster_name = "demo"
  k8s_version  = 1.27
  region       = "us-east"
  tags         = ["demo", "counter"]

  pool_instance_type  = "g6-standard-1"
  pool_instance_count = "3"
}