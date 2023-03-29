# Zot

Module for installing and configuring the [Zot registry](https://zotregistry.io)

## Table of Contents

1. [Description](#description)
1. [Usage - Configuration options and additional functionality](#usage)
    * [Installation](#installation)
       * [Install with URL](#install-with-url)
       * [Install with package manager](#install-with-package-manager)
    * [Configuration](#configuration)
       * [Specifying distribution specification version](#specifying-distribution-specification-version)
       * [HTTP listening address and port](#http-listening-address-and-port)
       * [Filesystem storage](#filesystem-storage)
       * [Extensions](#extensions)
1. [Reference](#reference)
1. [License](#license)

## Description

This module installs and configures the [Zot container registry](https://zotregistry.io) on RHEL/Ubuntu/Debian, either through OS repos or a binary release from Github.

## Usage

```puppet
include zot
```

### Hiera

All referenced parameters have sensible defaults set via the [in-module Hiera](./data/common.yaml). These can be overridden by passing the parameters with the class declaration or through Hiera itself. 

### Installation
#### Install with URL

This module, by default, will attempt to download and install the `v1.4.3` binary from Zot's [releases page](https://github.com/project-zot/zot/releases) on Github.

The desired version to download can be tweaked by overriding `zot::archive_download_version`.

```puppet
class {'zot':
  archive_download_version => 'v2.0.0-rc1',
}
```

Alternatively, you can specify the full download URL instead with `zot::archive_download_url`.

```puppet
class {'zot':
  archive_download_url => 'https://github.com/project-zot/zot/releases/download/v1.4.3/zot-linux-arm64',
}
```

#### Install with package manager

Although the majority of popular distributions have yet to release a package, this module also provides support for downloading the application with the operating system's package manager.

```puppet
class {'zot':
  install_method => 'package',
}
```
Please note that the module will not manage package manager repositories.

### Configuration

This module currently provides support for tweaking the following configuration directives:

* Distribution Specification version
* Network configuration
* Storage location and configuration
* Log location and verbosity
* lint, metrics, scrub, search and/or sync extensions

The module manages the YAML config file by utilizing the `to_yaml` function - embedded into this module - to convert Hashes to their YAML equivalent.

Beware that configuration key-value pairs are not validated by the module. Please refer to [Zot's documentation](https://zotregistry.io/latest/admin-guide/admin-configuration/) for a list of supported options.

#### Specifying distribution specification version

```puppet
class {'zot':
  config_dist_spec_version => '1.0.1-dev',
}
```

#### HTTP listening address and port

Networking options can be defined by configuring the `zot::config_http` hash. An example with Hiera:

```yaml
zot::config_http:
  address: '0.0.0.0'
  port: 5000
  tls:
    cert: 'path/to/server.cert'
    key: 'path/to/server.key'
```

#### Filesystem storage

Same principle for the `storage` directive.

```yaml
zot::config_storage:
  rootDirectory: /var/lib/zot
  commit: true
  dedupe: true
  gc: true
  gcDelay: 1h
  gcInterval: 24h
```

#### Extensions

Each individual extension can be configured with the module:

```yaml
zot::config_extensions_lint:
  enable: false
zot::config_extensions_metrics:
  enable: false
zot::config_extensions_scrub:
  enable: false
zot::config_extensions_search:
  enable: false
zot::config_extensions_sync:
  enable: false
```

### Additional options

Please refer to [REFERENCE.md](./REFERENCE.md) for a complete list of configuration options. This includes, but is not limited to:

* The user to run the service
* Basic Systemd service management
* Sync credentials and file location

## Reference

See [REFERENCE.md](./REFERENCE.md)

## License

This module is licensed with [Apache 2.0](./LICENSE).
