locals {
  defaults_repo = {
    arch = "x86_64",
    breed = "yum",
    mirrored = false,
    updated = true,
    comment = ""
  }
  
  __repos_default_item = {
    comment             = "",
    arch                = "x86_64",
    breed               = "yum",
    local               = false,
    updated             = true
  }
  
  repos = {}
}

resource "cobbler_repo" "repos" {
  for_each = toset(keys(local.repos))
  
    name                  = format("%s",
                                          each.value
                            )
    comment               = try(
                                  local.repos[each.value].comment,
                                  local.defaults_repo.comment
                            )
    arch                  = try(
                                  local.repos[each.value].arch,
                                  local.defaults_repo.arch
                            )
    
    breed                 = try(
                                  local.repos[each.value].breed,
                                  local.defaults_repo.breed
                                )
    mirror                = local.repos[each.value].mirror
  
    mirror_locally        = try(
                                  local.repos[each.value].mirrored,
                                  local.defaults_repo.mirrored
                                )
    keep_updated          = try(
                                  local.repos[each.value].updated,
                                  local.defaults_repo.updated
                            )
}
