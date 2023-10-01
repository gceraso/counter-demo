resource "linode_lke_cluster" "demo" {
    label       = "demo"
    k8s_version = "1.27"
    region      = "us-east"
    tags        = ["demo"]

    pool {
        type  = "g6-standard-1"
        count = 3
    }
}
