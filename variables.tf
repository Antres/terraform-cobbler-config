variable "repos" {
  description       = <<EOT
A Map of repositories:

{
  <NAME> = {
            link                          = null              # --mirror=LINK                         Mirror (Address of yum or rsync repo to mirror)
    
            description                   = "",               # --comment=DESCRIPTION                 Comment (Free form text description)
            arch                          = "x86_64",         # --arch=ARCH                           Arch (ex: i386, x86_64) (valid options: i386,x86_64,ia64,ppc,ppc64,ppc64le,s390,arm,noarch,src,)
            breed                         = "yum",            # --breed=BREED                         Breed (valid options: rsync,rhn,yum,apt,wget,)
    
            local                         = false,            # --mirror-locally=LOCAL                Mirror locally (Copy files or just reference the repoexternally?)
            update                        = true,             # --keep-updated=UPDATE                 Keep Updated (Update this repo on next 'cobbler reposync'?)
            environment                   = "",               # --environment=ENVIRONMENT             Environment Variables (Use these environment variables during commands (key=value, space delimited))
            flags                         = "",               # --createrepo-flags=FLAGS              Createrepo Flags (Flags to use with createrepo)
            proxy                         = "",               # --proxy=PROXY                         External proxy URL (ex: http://example.com:8080)
    
            owners                        = ["admin"],        # --owners=OWNERS                       Owners (Owners list for authz_ownership (space delimited))
    
            yum = {                                           #                                       Yum related options
              rpms                        = [],               # --rpm-list=RPMS                       RPM List (Mirror just these RPMs (yum only))
            },
    
            apt = {                                           #                                       Apt related options
              apt_components              = [],               # --apt-components=APT_COMPONENTS       Apt Components (apt only) (ex: main restricted universe)
              apt_dists                   = [],               # --apt-dists=APT_DISTS                 Apt Dist Names (apt only) (ex: precise precise-updates)
            },

  }
}
EOT
  
  validation {
    condition     = true
    error_message = ""
  }
}
