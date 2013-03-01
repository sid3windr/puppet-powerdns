puppet-powerdns - Puppet PowerDNS module
========================================

## Description

This module provides configuration for PowerDNS recursor.

In the future, the authoritative server will also be covered.

## Examples

Recursor:

    class { 'powerdns::recursor' :
      allow_from => [ '127.0.0.1', '192.168.0.0/16' ],
      daemon => 'yes',
      local_address => [ '53.53.53.53' ],
      local_port => 53535,
      quiet => 'yes',
    }

## OS Support

This configuration is currently tested only on Debian!
