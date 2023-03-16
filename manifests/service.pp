#
# @summary
#   This class handles the zot service
#
# @api private
#
class zot::service {
  assert_private()

  if $zot::manage_service_file {
    $service_content = $zot::service_epp_template =~ String ? {
      true    => epp($zot::service_epp_template, $zot::service_epp_parameters),
      default => epp("${module_name}/zot.service.epp", {
          zot_binary => $zot::binary_path,
          zot_config => $zot::config_file,
          zot_user   => $zot::user,
          zot_group  => $zot::group,
        }
      )
    }

    systemd::unit_file { "${zot::service_name}.service":
      content => $service_content,
    }

    if $zot::manage_service {
      Systemd::Unit_file["${zot::service_name}.service"]
      ~> Service[$zot::service_name]
    }
  }

  if $zot::manage_service {
    service { $zot::service_name:
      ensure => $zot::service_ensure,
      enable => $zot::service_enable,
    }
  }
}
