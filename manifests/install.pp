#
# @summary
#   This class handles zot packages.
#
# @api private
#
class zot::install {
  assert_private()

  case $zot::install_method {
    'url': {
      $real_archive_download_url = pick($zot::archive_download_url, "${zot::archive_download_base}/download/${zot::archive_download_version}/zot-${zot::archive_download_os}-${zot::archive_download_arch}")

      file { $zot::binary_path:
        ensure => file,
        owner  => root,
        group  => root,
        mode   => '0555',
      }

      archive { $zot::binary_path:
        ensure          => present,
        source          => $real_archive_download_url,
        checksum_verify => false,
        before          => File[$zot::binary_path],
      }
    }
    'package': {
      package { $zot::package_name:
        ensure => $zot::package_ensure,
      }
    }
    'none': {}
    default: {}
  }
}
