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
    
    rh = {
      key                     = "",
      server                  = "",
    },
  }
  
  
  distros = {
    pippo = {boot = {kernel="/mnt/images/pxeboot/vmlinuz", initrd="/mnt/images/pxeboot/initrd"}}
  }
}

resource "cobbler_distro" "distros" {
  for_each                    = { for name, distro in local.distros: name => merge(local.__distros_default_values,
                                                                                   distro,
                                                                                   merge({boot=local.__distros_default_values.boot}, distro.boot),
                                                                                   merge({cms=local.__distros_default_values.cms}, distro.cms),
                                                                                   merge({rh=local.__distros_default_values.rh}, distro.rh)
                                                                             ) }
    
    name                      = each.key
    comment                   = each.value.description
    
    breed                     = each.value.breed
    arch                      = each.value.arch
    os_version                = each.value.os_version
    
    kernel                    = each.value.boot.kernel
    initrd                    = each.value.boot.initrd
    boot_files                = join(" ", each.value.boot.others)
    kernel_options            = join(" ", [ for name, value in each.value.boot.options: format("%s=%s", name, value) ] )
      
    mgmt_classes              = each.value.cms.roles
    template_files            = join(" ", [ for template, file in each.value.cms.templates: format("%s=%s", template, file) ] )
      
    redhat_management_key     = each.value.rh.key
    redhat_management_server  = each.value.rh.server
}
