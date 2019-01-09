terragrunt = {
  include {
    path = "${find_in_parent_folders()}"
  }

  terraform {
    source = "git::ssh://git@github.com/RitualCo/terragrunt-infrastructure-modules.git//gcp/gke-ribot"
  }
}

project                             = "eng-tools-ritual"

// kubernetes_network_name name will be appended with -env
kubernetes_network_name             = "ribot-kubernetes-network"
env                                 = "prod"

// Since only one hubot will be running at a time (other than when rolling) we don't want a node spun up in multiple zones so we override the additional_zones from the module variable defaults from all the us zones to none of them.
master_zone                         = "us-east1-b"
additional_zones                    = []

// cluster_name name will be appended with -env
cluster_name                        = "ribot-gke"

// Can get a current list by running gcloud container get-server-config --zone us-east1-b.  Be mindful that not all zones roll out at the same time so the latest may not be available everywhere as soon as us-east1-*
min_master_version                  = "1.11.5-gke.5"

// We only have one type of node so it's the default
initial_default_pool_name           = "unused-default-pool"

// Used when connecting to the master api endpoint
admin_username                      = "admin"
admin_password                      = "H56m1xuqyuI2W2jD"

// If kubernetes needs to update this will keep it out of the hours we're likely to have users expecting it to work without interruptions.
daily_maintenance_window_start_time = "03:00"

// Only one node type so only the default pool
default_pool_name                   = "default-pool"
