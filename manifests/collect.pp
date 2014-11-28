# == Class: hosts::collect
#
# Manage /etc/hosts
#
class hosts::collect (
  fqdn_ensure          = 'present',
  my_fqdn_host_aliases = $::hostname,
  fqdn_ip              = $::ipaddress,
  collect_all_real     = false,
)
{
    @@host { $::fqdn:
      ensure       => $fqdn_ensure,
      host_aliases => $my_fqdn_host_aliases,
      ip           => $fqdn_ip,
    }
    
    case $collect_all_real {
      # collect all the exported Host resources
      true:  {
        Host <<| |>>
      }
      # only collect the exported entry above
      default: {
        Host <<| title == $::fqdn |>>
      }
    }


}
