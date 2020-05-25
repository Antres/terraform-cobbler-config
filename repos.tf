locals {
  defaults_repo = {
    arch = "x86_64",
    breed = "yum",
    mirrored = false,
    updated = true,
    comment = ""
  }
  
  __repos_default_values = {
    link                          = null
    
    comment                       = "",
    arch                          = "x86_64",
    breed                         = "yum",
    local                         = false,
    update                        = true
  }
  
  repos = {
    pippo = {
      link = "http://127.0.0.1/"
    }
  }
}

resource "cobbler_repo" "repos" {
  for_each                = { for k, v in local.repos: k => merge(v, local.__repos_default_values) }
  
    name                  = format("%s", each.key)
#   mirror                = local.repos[each.value].mirror
    mirror                = each.value.link
  
#   comment               = try(local.repos[each.value].comment, local.defaults_repo.comment)
    comment               = each.value.comment
#   arch                  = try(local.repos[each.value].arch,local.defaults_repo.arch)
    arch                  = each.value.arch
#   breed                 = try(local.repos[each.value].breed,local.defaults_repo.breed)
    breed                 = each.value.breed
  
#   mirror_locally        = try(local.repos[each.value].mirrored, local.defaults_repo.mirrored)
    mirror_locally        = each.value.local
#   keep_updated          = try(local.repos[each.value].updated,local.defaults_repo.updated)
    keep_updated          = each.value.update
}
