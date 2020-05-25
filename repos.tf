resource "cobbler_repo" "my_repo" {
  name           = "test"
  
  breed          = "yum"
  arch           = "x86_64"
  mirror         = "http://@@http_server@@/centos"
  
  mirror_locally = false
  keep_updated = true
}
