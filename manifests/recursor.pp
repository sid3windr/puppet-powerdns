class powerdns::recursor (
  # PowerDNS Recursor config variables
  $aaa_additional_processing = undef, # on/off
  $allow_from = undef, # array
  $auth_can_lower_ttl = undef, # on/off
  $auth_zones = undef, # array
  $chroot = undef, # ?
  $client_tcp_timeout = undef, # int
  $config_dir = undef, # string
  $daemon = undef, # yes/no
  $delegation_only = undef, # string
  $export_etc_hosts = undef, # on/off
  $fork = undef, # yes/no
  $forward_zones = undef, # array
  $hint_file = undef, # string
  $local_address = undef, # array
  $local_port = undef, # int
  $log_common_errors = undef, # yes/no
  $max_cache_entries = undef, # int
  $max_negative_ttl = undef, # int
  $max_tcp_clients = undef, # int
  $max_tcp_per_client = undef, # int
  $no_shuffle = undef, # on/off
  $query_local_address = undef, # string
  $query_local_address6 = undef, # string
  $quiet = undef, # yes/no
  $remotes_ringbuffer_entries = undef, # int
  $serve_rfc1918 = undef, # yes/no
  $server_id = undef, # string
  $setgid = undef, # int
  $setuid = undef, # int
  $single_socket = undef, # on/off
  $soa_minimum_ttl = undef, # int
  $soa_serial_offset = undef, # int
  $socket_dir = undef, # string
  $spoof_nearmiss_max = undef, # int
  $trace = undef, # on/off
  $version_string = undef, # string
  
  # Puppet module configuration
  $observium_script = 'yes', # yes/no
) {
  # FIXME check for debian? otherwise paths may be different.

  if $observium_script == 'yes'
  {
    # Observium check_mk script
    file { "/usr/lib/check_mk_agent/local/powerdns":
      owner   => root,
      group   => root,
      mode    => 550,
      require => Package["check-mk-agent"],
      source => "puppet:///modules/powerdns/check-mk-pdns-recursor",
    }
  }

  # should come from powerdns.com!
  package { "pdns-recursor":
    ensure => latest;
  }

  service { "pdns-recursor":
    enable => true,
    ensure => running,
    hasstatus => true,
    hasrestart => true,
    status => "ps faux|grep /usr/sbin/pdns_recursor|grep -v grep",
    subscribe => [ Package["pdns-recursor"] ],
  }

  file { "/etc/powerdns/recursor.conf":
    mode => "644",
    content => template("powerdns/recursor.conf.erb"),
    notify => Service["pdns-recursor"],
    require => Package['pdns-recursor']
  }
}

