#
# @summary
#   Main class, includes all other classes
#
# @param archive_download_arch
#   Archictecture for the binary archive
#
# @param archive_download_base
#   Base url for the binary archive
#
# @param archive_download_os
#   OS for the binary archive
#
# @param archive_download_url
#   Optional alternative url for downloading the archive
#
# @param archive_download_version
#   Verison for the binary archive
#
# @param binary_path
#   Path where the binary should be/is installed
#
# @param config_dir
#   Directory to place the configuration files
#
# @param config_dist_spec_version
#   Dist spec version set in the configuration file
#
# @param config_epp_parameters
#   Hash with parameters to hash to the custom epp file
#
# @param config_epp_template
#   Optional epp template for the configuration file
#
# @param config_file
#   Full path to place the configuration file
#
# @param config_hash
#   Optional config hash that will be converted to yaml for the config file
#
# @param config_http
#   Hash containing the http section in the config file
#
# @param data_dir
#   Directory where to store the zot data
#
# @param config_log
#   Hash containing the log section in the config file
#
# @param config_extensions_lint
#   Hash containing the lint extension configuration in the config file
#
# @param config_extensions_metrics
#   Hash containing the metrics extension configuration in the config file
#
# @param config_extensions_scrub
#   Hash containing the scrub extension configuration in the config file
#
# @param config_extensions_search
#   Hash containing the search extension configuration in the config file
#
# @param config_extensions_sync
#   Hash containing the sync extension configuration in the config file
#
# @param config_storage
#   Hash containing the storage section in the config file
#
# @param gid
#   GID of the zot group
#
# @param group
#   Name of the zot group
#
# @param install_method
#   Method to install zot
#   Possible values: url, package or none
#
# @param log_dir
#   Directory to store the zot logs
#
# @param manage_config_dir
#   Whether to manage the zot config_dir
#
# @param manage_data_dir
#   Whether to manage the zot data_dir
#
# @param manage_group
#   Whether to manage the zot group
#
# @param manage_log_dir
#   Whether to manage the zot log dir
#
# @param manage_service_file
#   Whether to manage the zot systemd service file
#
# @param manage_service
#   Whether to manage the zot service
#
# @param manage_sync_credentials_file
#   Whether to manage the sync credentials file
#
# @param manage_user
#   Whether to manage the zot user
#
# @param package_ensure
#   Ensure parameter of the zot package resource
#
# @param package_name
#   Name of the zot package resource
#
# @param service_enable
#   Determines if the service should be enabled
#
# @param service_ensure
#   Ensure parameter of the zot service resource
#
# @param service_epp_parameters
#   Hash with parameters to hash to the custom epp file
#
# @param service_epp_template
#   Optional epp template for the zot systemd service file
#
# @param service_name
#   Name of the zot service
#
# @param sync_credentials_file
#   Path to store the sync credentials file
#
# @param sync_credentials
#   Content of the sync credentials file
#
# @param uid
#   UID of the zot user
#
# @param user
#   Name of the zot user
#
# @example
#   include zot
#
class zot (
  String                         $archive_download_arch,
  Stdlib::HTTPUrl                $archive_download_base,
  String                         $archive_download_os,
  Optional[Stdlib::HTTPUrl]      $archive_download_url,
  String                         $archive_download_version,
  Stdlib::Unixpath               $binary_path,
  Stdlib::Unixpath               $config_dir,
  String                         $config_dist_spec_version,
  Stdlib::Unixpath               $config_file,
  Optional[Hash]                 $config_hash,
  Hash                           $config_http,
  Hash                           $config_log,
  Hash                           $config_epp_parameters,
  Optional[String]               $config_epp_template,
  Optional[Hash]                 $config_extensions_lint,
  Optional[Hash]                 $config_extensions_metrics,
  Optional[Hash]                 $config_extensions_scrub,
  Optional[Hash]                 $config_extensions_search,
  Optional[Hash]                 $config_extensions_sync,
  Hash                           $config_storage,
  Stdlib::Unixpath               $data_dir,
  Accounts::User::Uid            $gid,
  String                         $group,
  Enum['url', 'package', 'none'] $install_method,
  Stdlib::Unixpath               $log_dir,
  Boolean                        $manage_config_dir,
  Boolean                        $manage_data_dir,
  Boolean                        $manage_group,
  Boolean                        $manage_log_dir,
  Boolean                        $manage_service_file,
  Boolean                        $manage_service,
  Boolean                        $manage_sync_credentials_file,
  Boolean                        $manage_user,
  String                         $package_ensure,
  String                         $package_name,
  Boolean                        $service_enable,
  String                         $service_ensure,
  Hash                           $service_epp_parameters,
  Optional[String]               $service_epp_template,
  String                         $service_name,
  Stdlib::Unixpath               $sync_credentials_file,
  Hash                           $sync_credentials,
  Accounts::User::Uid            $uid,
  String                         $user,
) {
  contain zot::install
  contain zot::config
  contain zot::service

  Class['zot::install']
  -> Class['zot::config']
  ~> Class['zot::service']
}
