resource "cobbler_repo" "my_repo" {
  name           = "test"
  breed          = "redhat"
  arch           = "x86_64"
  mirror         = "http://10.0.1.1/centos/"
  
  mirror_locally = false
}
