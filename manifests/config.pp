#
# @summary
#   This class handles the zot configuration file.
#
# @api private
#
class zot::config {
  assert_private()

  if $zot::manage_group {
    group { $zot::group:
      ensure     => present,
      gid        => $zot::gid,
      forcelocal => true,
    }
  }

  if $zot::manage_user {
    user { $zot::user:
      ensure     => present,
      comment    => 'Zot OCI Distribution Registry',
      home       => $zot::data_dir,
      uid        => $zot::uid,
      gid        => $zot::gid,
      forcelocal => true,
    }
  }

  if $zot::manage_config_dir {
    file { $zot::config_dir:
      ensure => directory,
      owner  => $zot::user,
      group  => $zot::group,
      mode   => '0755',
    }
  }

  if $zot::manage_data_dir {
    file { $zot::data_dir:
      ensure => directory,
      owner  => $zot::user,
      group  => $zot::group,
      mode   => '0755',
    }
  }

  if $zot::manage_log_dir {
    file { $zot::log_dir:
      ensure => directory,
      owner  => $zot::user,
      group  => $zot::group,
      mode   => '0755',
    }
  }

  if $zot::manage_sync_credentials_file {
    file { $zot::sync_credentials_file:
      ensure  => file,
      owner   => $zot::user,
      group   => $zot::group,
      mode    => '0600',
      content => to_json_pretty($zot::sync_credentials),
    }
  }

  if $zot::config_epp_template {
    $config_content = epp($zot::config_epp_template, $zot::config_epp_parameters)
  } elsif $zot::config_hash {
    $config_content = to_yaml($zot::config_hash)
  } else {
    $config_content = epp("${module_name}/config.yaml.epp", {
        'dist_spec_version'  => $zot::config_dist_spec_version,
        'http'               => $zot::config_http,
        'log'                => $zot::config_log,
        'storage'            => $zot::config_storage,
        'extensions_lint'    => $zot::config_extensions_lint,
        'extensions_metrics' => $zot::config_extensions_metrics,
        'extensions_scrub'   => $zot::config_extensions_scrub,
        'extensions_search'  => $zot::config_extensions_search,
        'extensions_sync'    => $zot::config_extensions_sync,
      }
    )
  }

  file { $zot::config_file:
    ensure  => file,
    owner   => $zot::user,
    group   => $zot::group,
    mode    => '0644',
    content => $config_content,
  }
}
