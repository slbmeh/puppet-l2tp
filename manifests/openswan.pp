# Class: l2tp::openswan
# 
# Installs openswan package.
# Needed for IPSec
# 
# Usage:
# include l2tp::openswan
#
class l2tp::openswan {

  include l2tp::params
  if ! defined(Package['openswan']) {
    package { 'openswan':
      ensure => $::operatingsystem ? {
        default => 'installed',
      },
      provider => $::operatingsystem ? {
        debian  => 'apt',
        ubuntu  => 'apt',
        default => undefined,
      },
  }

  if ! defined(Package['openswan-modules-dkms']) {
    package { 'openswan-modules-dkms':
      ensure => $::operatingsystem ? {
        default => 'installed',
      },
      provider => $::operatingsystem ? {
        debian  => 'apt',
        ubuntu  => 'apt',
        default => undefined,
      },
  }

  service { 'l2tp_ipsec':
    ensure    => $l2tp::manage_service_ipsec_ensure,
    name      => $l2tp::service_ipsec,
    enable    => $l2tp::manage_service_ipsec_enable,
    hasstatus => $l2tp::service_status,
    pattern   => $l2tp::process_ipsec,
    require   => Package['openswan', 'openswan-modules-dkms'],
  }

  file { 'ipsec.l2tp':
    ensure  => $l2tp::manage_file,
    path    => "${l2tp::ipsec_config_dir}/ipsec.l2tp",
    mode    => $l2tp::config_file_mode,
    owner   => $l2tp::config_file_owner,
    group   => $l2tp::config_file_group,
    require => Package['openswan', 'openswan-modules-dkms'],
    notify  => $l2tp::manage_service_ipsec_autorestart,
    content => $l2tp::manage_file_ipsecl2tp_content,
    replace => $l2tp::manage_file_replace,
    audit   => $l2tp::manage_audit,
  }

  file { 'ipsec.l2tp.secrets':
    ensure  => $l2tp::manage_file,
    path    => "${l2tp::ipsec_config_dir}/ipsec.l2tp.secrets",
    mode    => '0600',
    owner   => $l2tp::config_file_owner,
    group   => $l2tp::config_file_group,
    require => Package['openswan', 'openswan-modules-dkms'],
    notify  => $l2tp::manage_service_ipsec_autorestart,
    content => $l2tp::manage_file_ipsecl2tpsecrets_content,
    replace => $l2tp::manage_file_replace,
    audit   => $l2tp::manage_audit,
  }

  line { 'ipsec.conf':
    file   => "/etc/ipsec.conf",
    line   => "include ${l2tp::ipsec_config_dir}/ipsec.l2tp",
    ensure => uncoment
  }

  line { 'ipsec.secrets':
    file   => "/etc/ipsec.secrets",
    line   => "include ${l2tp::ipsec_config_dir}/ipsec.l2tp.secrets",
    ensure => uncomment,
  }

  ### Service monitoring, if enabled ( monitor => true )
  if $l2tp::bool_monitor == true {
    monitor::port { "ipsec_${l2tp::ipsec_protocol}_${l2tp::ipsec_port}":
      protocol => $l2tp::ipsec_procotol,
      port     => $l2tp::ipsec_port,
      target   => $l2tp::monitor_target,
      tool     => $l2tp::monitor_tool,
      enable   => $l2tp::manage_monitor,
    }
    monitor::process { 'l2tp_process_ipsec':
      process  => $l2tp::process_ipsec,
      service  => $l2tp::service_ipsec,
      pidfile  => $l2tp::pid_file_ipsec,
      user     => $l2tp::process_user_ipsec,
      argument => $l2tp::process_args_ipsec,
      tool     => $l2tp::monitor_tool,
      enable   => $l2tp::manage_monitor,
    }
  }

  ### Firewall management, if enabled ( firewall => true )
  if $l2tp::bool_firewall == true {
    firewall { "ipsec_${l2tp::ipsec_protocol}_${puppet::ipsec_port}":
      source      => $l2tp::firewall_src,
      destination => $l2tp::firewall_dst,
      protocol    => $l2tp::ipsec_protocol,
      port        => $l2tp::ipsec_port,
      action      => 'allow',
      direction   => 'input',
      tool        => $l2tp::firewall_tool,
      enable      => $l2tp::manage_firewall,
    }
  }
}
