# The following configuration uses a provider which provisions [fake] resources
# to a fictitious cloud vendor called "Fake Web Services". Configuration for
# the fakewebservices provider can be found in provider.tf.
#
# After running the setup script (./scripts/setup.sh), feel free to change these
# resources and 'terraform apply' as much as you'd like! These resources are
# purely for demonstration and created in Terraform Cloud, scoped to your TFC
# user account.
#
# To review the provider and documentation for the available resources and
# schemas, see: https://registry.terraform.io/providers/hashicorp/fakewebservices
#
# If you're looking for the configuration for the remote backend, you can find that
# in backend.tf.


resource "fakewebservices_vpc" "primary_vpc_git" {
  name       = "Primary VPC"
  cidr_block = "0.0.0.0/1"
}

resource "fakewebservices_server" "servers_git" {
  count = 2

  name = "Server ${count.index + 1}"
  type = "t2.micro"
  vpc  = fakewebservices_vpc.primary_vpc_git.name
}

resource "fakewebservices_load_balancer" "primary_lb_git" {
  name    = "Primary Load Balancer"
  servers = fakewebservices_server.servers_git[*].name
}

resource "fakewebservices_database" "prod_db_git" {
  name = "Production DB"
  size = 256
}
