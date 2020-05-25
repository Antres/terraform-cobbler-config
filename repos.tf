locals {
  defaults_repo = {
    arch = "x86_64",
    breed = "yum",
    mirrored = false,
    updated = true,
    comment = ""
  }
  
  repos = {
    test = {
      mirror = "http://@@http_server@@/centos",
    }
  }
}

resource "cobbler_repo" "my_repo" {
  for_each = toset(keys(local.repos))
  
  name           = each.value
  
  breed          = try(local.repos[each.value].breed, local.defaults_repo.breed)
  arch           = try(local.repos[each.value].arch, local.defaults_repo.arch)
  mirror         = local.repos[each.value].mirror
  
  mirror_locally = try(local.repos[each.value].mirrored, local.defaults_repo.mirrored)
  keep_updated = try(local.repos[each.value].updated, local.defaults_repo.updated)
  
  comment = try(local.repos[each.value].comment, local.defaults_repo.comment)
}
