# Class: l2tp::xl2tpd
# 
# Installs xl2tpd package.
# Needed for xL2TP Daemon
# 
# Usage:
# include l2tp::xl2tpd
#
class l2tp::xl2tpd {

  include l2tp::params
  if ! defined(Package['xl2tpd']) {
    package { 'xl2tpd':
      ensure => $::operatingsystem ? {
        default => 'installed',
      },
      provider => $::operatingsystem ? {
        debian  => 'apt',
        ubuntu  => 'apt',
        default => undefined,
      },
  }

  service { 'l2tp_xl2tpd':
    ensure    => $l2tp::manage_service_xl2tpd_ensure,
    name      => $l2tp::service_xl2tpd,
    enable    => $l2tp::manage_service_xl2tpd_enable,
    hasstatus => $l2tp::service_status,
    pattern   => $l2tp::process_xl2tpd,
    require   => Package['xl2tpd'],
  }

  ## Ensure we have the ppp device.
  file { '/dev/ppp':
    require => Package['xl2tpd'],
    notify  => exec['create-ppp-device'],
  }

  exec { 'create-ppp-device':
    command => "mknod /dev/ppp c 108 0",
    path    => "/bin",
    unless  => "/usr/bin/test -c /dev/ppp"
  }

  ## Configuration files
  file { 'xl2tpd.conf':
    ensure  => $l2tp::manage_file,
    path    => "${l2tp::xl2tpd_config_dir}/xl2tpd.conf",
    mode    => $l2tp::config_file_mode,
    owner   => $l2tp::config_file_owner,
    group   => $l2tp::config_file_group,
    require => Package['xl2tpd'],
    notify  => $l2tp::manage_service_xl2tpd_autorestart,
    content => $l2tp::manage_file_xl2tpd_content,
    replace => $l2tp::manage_file_replace,
    audit   => $l2tp::manage_audit,
  }

  file { 'options.xl2tpd':
    ensure  => $l2tp::manage_file,
    path    => "${l2tp::ppp_config_dir}/options.xl2tpd",
    mode    => $l2tp::config_file_mode,
    owner   => $l2tp::config_file_owner,
    group   => $l2tp::config_file_group,
    require => Package['xl2tpd'],
    notify  => $l2tp::manage_service_xl2tpd_autorestart,
    content => $l2tp::manage_file_xl2tpd_content,
    replace => $l2tp::manage_file_replace,
    audit   => $l2tp::manage_audit,
  }

  ### Service monitoring, if enabled ( monitor => true )
  if $l2tp::bool_monitor == true {
    monitor::port { "xl2tpd_${l2tp::xl2tpd_protocol}_${l2tp::xl2tpd_port}":
      protocol => $l2tp::xl2tpd_procotol,
      port     => $l2tp::xl2tpd_port,
      target   => $l2tp::monitor_target,
      tool     => $l2tp::monitor_tool,
      enable   => $l2tp::manage_monitor,
    }
    monitor::process { 'l2tp_process_xl2tpd':
      process  => $l2tp::process_xl2tpd,
      service  => $l2tp::service_xl2tpd,
      pidfile  => $l2tp::pid_file_xl2tpd,
      user     => $l2tp::process_user_xl2tpd,
      argument => $l2tp::process_args_xl2tpd,
      tool     => $l2tp::monitor_tool,
      enable   => $l2tp::manage_monitor,
    }
  }

  ### Firewall management, if enabled ( firewall => true )
  if $l2tp::bool_firewall == true {
    firewall { "xl2tpd_${l2tp::xl2tpd_protocol}_${puppet::xl2tpd_port}":
      source      => $l2tp::firewall_src,
      destination => $l2tp::firewall_dst,
      protocol    => $l2tp::xl2tpd_protocol,
      port        => $l2tp::xl2tpd_port,
      action      => 'allow',
      direction   => 'input',
      tool        => $l2tp::firewall_tool,
      enable      => $l2tp::manage_firewall,
    }
  }
}
