file { '/etc/zot/htpasswd':
  ensure  => file,
  owner   => zot,
  group   => zot,
  mode    => '0600',
  content => 'admin:$2y$05$j5d2qAVvEERR2Dr9QTPPce6rTH/vmaHg1aypspem8hAW4BYGienDC',
  notify  => Service['zot'],
}

class { 'zot':
  config_http               => {
    address => '0.0.0.0',
    port    => 5000,
    auth    => {
      htpasswd  => {
        path => '/etc/zot/htpasswd',
      },
      faildelay => 5,
    }
  },
  config_extensions_metrics => {
    enable     => true,
    prometheus => {
      path => '/metrics',
    },
  },
  config_extensions_scrub   => {
    enable   => true,
    interval => '24h',
  },
  config_extensions_search  => {
    enable => true,
    cve    => {
      updateInterval => '2h',
  },
  config_extensions_sync    => {
    enable          => true,
    credentialsFile => '/etc/zot/sync-credentials.json',
    registries      => {
      [
        urls         => ['https://docker.io'],
        onDemand     => true,
        maxRetries   => 3,
        retryDelay   => 10,
        pollInterval => '30s',
        onlySigned   => false,
        content      => {
          [
            destination => '/dockerhub',
            prefix      => '**',
          ],
        },
      ],
    },
  },
  sync_credentials          => {
    'docker.io' => {
      username => 'username',
      password => 'password',
    },
  },
}
