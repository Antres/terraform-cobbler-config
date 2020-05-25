locals {
  __repos_default_values = {}
}

resource "cobbler_distro" "distros" {
  name       = "foo"
  breed      = "ubuntu"
  os_version = "trusty"
  arch       = "x86_64"
  kernel     = "/var/www/cobbler/ks_mirror/Ubuntu-14.04/install/netboot/ubuntu-installer/amd64/linux"
  initrd     = "/var/www/cobbler/ks_mirror/Ubuntu-14.04/install/netboot/ubuntu-installer/amd64/initrd.gz"
}
