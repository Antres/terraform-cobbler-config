locals {
  repos = [
    "test" = {
      mirror = "http://@@http_server@@/centos",
      arch = "x86_64",
      comment = "pippo"
    }
  ]
}

resource "cobbler_repo" "my_repo" {
  for_each = toset(local.repos)
  
  name           = each.value
  
  breed          = try(local.repos[each.value].breed, "yum")
  arch           = try(local.repos[each.value].arch, "x86_64")
  mirror         = local.repos[each.value].mirror
  
  mirror_locally = try(local.repos[each.value].mirrored, false)
  keep_updated = try(local.repos[each.value].updated, true)
  
  comment = try(local.repos[each.value].comment, "")
}
