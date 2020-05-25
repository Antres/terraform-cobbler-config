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
    os_version                = "rhel7",
    
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
    pippo = {boot = {kernel="/mnt/images/pxeboot/vmlinuz", initrd="/mnt/images/pxeboot/initrd.img"}}
  }
}

resource "cobbler_distro" "distros" {
  for_each                    = local.distros
    
    name                      = each.key
    comment                   = try(each.value.description, local.__distros_default_values.description)
    
    breed                     = try(each.value.breed, local.__distros_default_values.breed)
    arch                      = try(each.value.arch, local.__distros_default_values.arch)
    os_version                = try(each.value.os_version, local.__distros_default_values.os_version)
    
    kernel                    = try(each.value.boot.kernel, local.__distros_default_values.boot.kernel)
    initrd                    = try(each.value.boot.initrd, local.__distros_default_values.boot.initrd)
    boot_files                = join(" ", try(each.value.boot.others, local.__distros_default_values.boot.others))
    kernel_options            = join(" ", [ for name, value in try(each.value.boot.options, local.__distros_default_values.boot.options): format("%s=%s", name, value) ] )
      
    mgmt_classes              = try(each.value.cms.roles, local.__distros_default_values.cms.roles)
    template_files            = join(" ", [ for template, file in try(each.value.cms.templates, local.__distros_default_values.cms.templates): format("%s=%s", template, file) ] )
      
    redhat_management_key     = try(each.value.rh.key, local.__distros_default_values.rh.key)
    redhat_management_server  = try(each.value.rh.server, local.__distros_default_values.rh.server)
}
