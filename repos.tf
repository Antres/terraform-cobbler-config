locals {  
  __repos_default_values = {                          # https://cobbler.readthedocs.io/en/latest/cobbler.html#cobbler-repo
    link                          = null              # mirror
    
    description                   = "",               # comment
    arch                          = "x86_64",         # arch
    breed                         = "yum",            # breed
    
    local                         = false,            # mirror-locally
    update                        = true              # keep-updated
  }
  
  repos = {
  }
  
}

resource "cobbler_repo" "repos" {
                                                            # Override defaults with input values
  for_each                = { for k, v in local.repos: k => merge(local.__repos_default_values, v) }
  
    name                  = format("%s", each.key)
    mirror                = each.value.link
  
    comment               = each.value.comment
    arch                  = each.value.arch
    breed                 = each.value.breed
  
    mirror_locally        = each.value.local
    keep_updated          = each.value.update
}
