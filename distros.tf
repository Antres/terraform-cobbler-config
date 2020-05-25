locals {
  __distros_default_values = {
    boot = {
      kernel                  = null,
      options                 = {},
      initrd                  = null,
      others                  = [],
    },
    
    description               = "",
    
    arch                      = "x86_64",
    breed                     = "redhat",
    os_version                = "other",
    
    owners                    = ["admin"],
    
    cms = {
      roles                   = [],
      templates               = {},
    },
    
    redhat_management = {
      key                     = "",
      server                  = "",
    },
  }
  
  distros = {}
}

resource "cobbler_distro" "distros" {
  for_each                    = { for name, distro in local.distros: name => merge(local.__repos_default_values, distro) }
    
    name                      = each.key
    comment                   = each.value.description
    
    breed                     = each.value.breed
    arch                      = each.value.arch
    os_version                = each.value.os_version
    
    kernel                    = each.value.boot.kernel
    initrd                    = each.value.boot.initrd
    boot_files                = join(" ", each.value.boot.other)
    kernel_options            = join(" ", [ for name, value in each.value.boot.options: format("%s=%s", name, value) ] )
      
    mgmt_classes              = each.value.cms.roles
    template_files            = join(" ", [ for template, file in each.value.cms.templates: format("%s=%s", template, file) ] )
      
    redhat_management_key     = each.value.redhat_management.key
    redhat_management_server  = each.value.redhat_management.server
}
