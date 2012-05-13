# = Class: l2tp
#
# This is the main l2tp class
#
#
# == Parameters
#
# Standard class parameters
# Define the general class behaviour and customizations
#
# [*my_class*]
#   Name of a custom class to autoload to manage module's customizations
#   If defined, l2tp class will automatically "include $my_class"
#   Can be defined also by the (top scope) variable $l2tp_myclass
#
# [*source*]
#   Sets the content of source parameter for main configuration file
#   If defined, l2tp main config file will have the param: source => $source
#   Can be defined also by the (top scope) variable $l2tp_source
#
# [*source_dir*]
#   If defined, the whole l2tp configuration directory content is retrieved
#   recursively from the specified source
#   (source => $source_dir , recurse => true)
#   Can be defined also by the (top scope) variable $l2tp_source_dir
#
# [*source_dir_purge*]
#   If set to true (default false) the existing configuration directory is
#   mirrored with the content retrieved from source_dir
#   (source => $source_dir , recurse => true , purge => true)
#   Can be defined also by the (top scope) variable $l2tp_source_dir_purge
#
# [*template*]
#   Sets the path to the template to use as content for main configuration file
#   If defined, l2tp main config file has: content => content("$template")
#   Note source and template parameters are mutually exclusive: don't use both
#   Can be defined also by the (top scope) variable $l2tp_template
#
# [*options*]
#   An hash of custom options to be used in templates for arbitrary settings.
#   Can be defined also by the (top scope) variable $l2tp_options
#
# [*service_autorestart*]
#   Automatically restarts the l2tp service when there is a change in
#   configuration files. Default: true, Set to false if you don't want to
#   automatically restart the service.
#
# [*version*]
#   The package version, used in the ensure parameter of package type.
#   Default: present. Can be 'latest' or a specific version number.
#   Note that if the argument absent (see below) is set to true, the
#   package is removed, whatever the value of version parameter.
#
# [*absent*]
#   Set to 'true' to remove package(s) installed by module
#   Can be defined also by the (top scope) variable $l2tp_absent
#
# [*disable*]
#   Set to 'true' to disable service(s) managed by module
#   Can be defined also by the (top scope) variable $l2tp_disable
#
# [*disableboot*]
#   Set to 'true' to disable service(s) at boot, without checks if it's running
#   Use this when the service is managed by a tool like a cluster software
#   Can be defined also by the (top scope) variable $l2tp_disableboot
#
# [*monitor*]
#   Set to 'true' to enable monitoring of the services provided by the module
#   Can be defined also by the (top scope) variables $l2tp_monitor
#   and $monitor
#
# [*monitor_tool*]
#   Define which monitor tools (ad defined in Example42 monitor module)
#   you want to use for l2tp checks
#   Can be defined also by the (top scope) variables $l2tp_monitor_tool
#   and $monitor_tool
#
# [*monitor_target*]
#   The Ip address or hostname to use as a target for monitoring tools.
#   Default is the fact $ipaddress
#   Can be defined also by the (top scope) variables $l2tp_monitor_target
#   and $monitor_target
#
# [*puppi*]
#   Set to 'true' to enable creation of module data files that are used by puppi
#   Can be defined also by the (top scope) variables $l2tp_puppi and $puppi
#
# [*puppi_helper*]
#   Specify the helper to use for puppi commands. The default for this module
#   is specified in params.pp and is generally a good choice.
#   You can customize the output of puppi commands for this module using another
#   puppi helper. Use the define puppi::helper to create a new custom helper
#   Can be defined also by the (top scope) variables $l2tp_puppi_helper
#   and $puppi_helper
#
# [*firewall*]
#   Set to 'true' to enable firewalling of the services provided by the module
#   Can be defined also by the (top scope) variables $l2tp_firewall
#   and $firewall
#
# [*firewall_tool*]
#   Define which firewall tool(s) (ad defined in Example42 firewall module)
#   you want to use to open firewall for l2tp port(s)
#   Can be defined also by the (top scope) variables $l2tp_firewall_tool
#   and $firewall_tool
#
# [*firewall_src*]
#   Define which source ip/net allow for firewalling l2tp. Default: 0.0.0.0/0
#   Can be defined also by the (top scope) variables $l2tp_firewall_src
#   and $firewall_src
#
# [*firewall_dst*]
#   Define which destination ip to use for firewalling. Default: $ipaddress
#   Can be defined also by the (top scope) variables $l2tp_firewall_dst
#   and $firewall_dst
#
# [*debug*]
#   Set to 'true' to enable modules debugging
#   Can be defined also by the (top scope) variables $l2tp_debug and $debug
#
# [*audit_only*]
#   Set to 'true' if you don't intend to override existing configuration files
#   and want to audit the difference between existing files and the ones
#   managed by Puppet.
#   Can be defined also by the (top scope) variables $l2tp_audit_only
#   and $audit_only
#
# Default class params - As defined in l2tp::params.
# Note that these variables are mostly defined and used in the module itself,
# overriding the default values might not affected all the involved components.
# Set and override them only if you know what you're doing.
# Note also that you can't override/set them via top scope variables.
#
# [*package*]
#   The name of l2tp package
#
# [*service*]
#   The name of l2tp service
#
# [*service_status*]
#   If the l2tp service init script supports status argument
#
# [*process*]
#   The name of l2tp process
#
# [*process_args*]
#   The name of l2tp arguments. Used by puppi and monitor.
#   Used only in case the l2tp process name is generic (java, ruby...)
#
# [*process_user*]
#   The name of the user l2tp runs with. Used by puppi and monitor.
#
# [*config_dir*]
#   Main configuration directory. Used by puppi
#
# [*config_file*]
#   Main configuration file path
#
# [*config_file_mode*]
#   Main configuration file path mode
#
# [*config_file_owner*]
#   Main configuration file path owner
#
# [*config_file_group*]
#   Main configuration file path group
#
# [*config_file_init*]
#   Path of configuration file sourced by init script
#
# [*pid_file*]
#   Path of pid file. Used by monitor
#
# [*data_dir*]
#   Path of application data directory. Used by puppi
#
# [*log_dir*]
#   Base logs directory. Used by puppi
#
# [*log_file*]
#   Log file(s). Used by puppi
#
# [*port*]
#   The listening port, if any, of the service.
#   This is used by monitor, firewall and puppi (optional) components
#   Note: This doesn't necessarily affect the service configuration file
#   Can be defined also by the (top scope) variable $l2tp_port
#
# [*protocol*]
#   The protocol used by the the service.
#   This is used by monitor, firewall and puppi (optional) components
#   Can be defined also by the (top scope) variable $l2tp_protocol
#
#
# == Examples
#
# You can use this class in 2 ways:
# - Set variables (at top scope level on in a ENC) and "include l2tp"
# - Call l2tp as a parametrized class
#
# See README for details.
#
#
# == Author
#   Alessandro Franceschi <al@lab42.it/>
#
class l2tp (
  $my_class            = params_lookup( 'my_class' ),
  $source              = params_lookup( 'source' ),
  $source_dir          = params_lookup( 'source_dir' ),
  $source_dir_purge    = params_lookup( 'source_dir_purge' ),
  $template            = params_lookup( 'template' ),
  $service_autorestart = params_lookup( 'service_autorestart' , 'global' ),
  $options             = params_lookup( 'options' ),
  $version             = params_lookup( 'version' ),
  $absent              = params_lookup( 'absent' ),
  $disable             = params_lookup( 'disable' ),
  $disableboot         = params_lookup( 'disableboot' ),
  $monitor             = params_lookup( 'monitor' , 'global' ),
  $monitor_tool        = params_lookup( 'monitor_tool' , 'global' ),
  $monitor_target      = params_lookup( 'monitor_target' , 'global' ),
  $puppi               = params_lookup( 'puppi' , 'global' ),
  $puppi_helper        = params_lookup( 'puppi_helper' , 'global' ),
  $firewall            = params_lookup( 'firewall' , 'global' ),
  $firewall_tool       = params_lookup( 'firewall_tool' , 'global' ),
  $firewall_src        = params_lookup( 'firewall_src' , 'global' ),
  $firewall_dst        = params_lookup( 'firewall_dst' , 'global' ),
  $debug               = params_lookup( 'debug' , 'global' ),
  $audit_only          = params_lookup( 'audit_only' , 'global' ),
  $package             = params_lookup( 'package' ),
  $service             = params_lookup( 'service' ),
  $service_status      = params_lookup( 'service_status' ),
  $process             = params_lookup( 'process' ),
  $process_args        = params_lookup( 'process_args' ),
  $process_user        = params_lookup( 'process_user' ),
  $config_dir          = params_lookup( 'config_dir' ),
  $config_file         = params_lookup( 'config_file' ),
  $config_file_mode    = params_lookup( 'config_file_mode' ),
  $config_file_owner   = params_lookup( 'config_file_owner' ),
  $config_file_group   = params_lookup( 'config_file_group' ),
  $config_file_init    = params_lookup( 'config_file_init' ),
  $pid_file            = params_lookup( 'pid_file' ),
  $data_dir            = params_lookup( 'data_dir' ),
  $log_dir             = params_lookup( 'log_dir' ),
  $log_file            = params_lookup( 'log_file' ),
  $port                = params_lookup( 'port' ),
  $protocol            = params_lookup( 'protocol' )
  ) inherits l2tp::params {

  $bool_source_dir_purge=any2bool($source_dir_purge)
  $bool_service_autorestart=any2bool($service_autorestart)
  $bool_absent=any2bool($absent)
  $bool_disable=any2bool($disable)
  $bool_disableboot=any2bool($disableboot)
  $bool_monitor=any2bool($monitor)
  $bool_puppi=any2bool($puppi)
  $bool_firewall=any2bool($firewall)
  $bool_debug=any2bool($debug)
  $bool_audit_only=any2bool($audit_only)

  ### Definition of some variables used in the module
  $manage_package = $l2tp::bool_absent ? {
    true  => 'absent',
    false => $l2tp::version,
  }

  $manage_service_enable = $l2tp::bool_disableboot ? {
    true    => false,
    default => $l2tp::bool_disable ? {
      true    => false,
      default => $l2tp::bool_absent ? {
        true  => false,
        false => true,
      },
    },
  }

  $manage_service_ensure = $l2tp::bool_disable ? {
    true    => 'stopped',
    default =>  $l2tp::bool_absent ? {
      true    => 'stopped',
      default => 'running',
    },
  }

  $manage_service_autorestart = $l2tp::bool_service_autorestart ? {
    true    => Service[l2tp],
    false   => undef,
  }

  $manage_file = $l2tp::bool_absent ? {
    true    => 'absent',
    default => 'present',
  }

  if $l2tp::bool_absent == true
  or $l2tp::bool_disable == true
  or $l2tp::bool_disableboot == true {
    $manage_monitor = false
  } else {
    $manage_monitor = true
  }

  if $l2tp::bool_absent == true
  or $l2tp::bool_disable == true {
    $manage_firewall = false
  } else {
    $manage_firewall = true
  }

  $manage_audit = $l2tp::bool_audit_only ? {
    true  => 'all',
    false => undef,
  }

  $manage_file_replace = $l2tp::bool_audit_only ? {
    true  => false,
    false => true,
  }

  $manage_file_source = $l2tp::source ? {
    ''        => undef,
    default   => $l2tp::source,
  }

  $manage_file_content = $l2tp::template ? {
    ''        => undef,
    default   => template($l2tp::template),
  }

  ### Managed resources
  package { 'l2tp':
    ensure => $l2tp::manage_package,
    name   => $l2tp::package,
  }

  service { 'l2tp':
    ensure     => $l2tp::manage_service_ensure,
    name       => $l2tp::service,
    enable     => $l2tp::manage_service_enable,
    hasstatus  => $l2tp::service_status,
    pattern    => $l2tp::process,
    require    => Package['l2tp'],
  }

  file { 'l2tp.conf':
    ensure  => $l2tp::manage_file,
    path    => $l2tp::config_file,
    mode    => $l2tp::config_file_mode,
    owner   => $l2tp::config_file_owner,
    group   => $l2tp::config_file_group,
    require => Package['l2tp'],
    notify  => $l2tp::manage_service_autorestart,
    source  => $l2tp::manage_file_source,
    content => $l2tp::manage_file_content,
    replace => $l2tp::manage_file_replace,
    audit   => $l2tp::manage_audit,
  }

  # The whole l2tp configuration directory can be recursively overriden
  if $l2tp::source_dir {
    file { 'l2tp.dir':
      ensure  => directory,
      path    => $l2tp::config_dir,
      require => Package['l2tp'],
      notify  => $l2tp::manage_service_autorestart,
      source  => $l2tp::source_dir,
      recurse => true,
      purge   => $l2tp::source_dir_purge,
      replace => $l2tp::manage_file_replace,
      audit   => $l2tp::manage_audit,
    }
  }


  ### Include custom class if $my_class is set
  if $l2tp::my_class {
    include $l2tp::my_class
  }


  ### Provide puppi data, if enabled ( puppi => true )
  if $l2tp::bool_puppi == true {
    $classvars=get_class_args()
    puppi::ze { 'l2tp':
      ensure    => $l2tp::manage_file,
      variables => $classvars,
      helper    => $l2tp::puppi_helper,
    }
  }


  ### Service monitoring, if enabled ( monitor => true )
  if $l2tp::bool_monitor == true {
    monitor::port { "l2tp_${l2tp::protocol}_${l2tp::port}":
      protocol => $l2tp::protocol,
      port     => $l2tp::port,
      target   => $l2tp::monitor_target,
      tool     => $l2tp::monitor_tool,
      enable   => $l2tp::manage_monitor,
    }
    monitor::process { 'l2tp_process':
      process  => $l2tp::process,
      service  => $l2tp::service,
      pidfile  => $l2tp::pid_file,
      user     => $l2tp::process_user,
      argument => $l2tp::process_args,
      tool     => $l2tp::monitor_tool,
      enable   => $l2tp::manage_monitor,
    }
  }


  ### Firewall management, if enabled ( firewall => true )
  if $l2tp::bool_firewall == true {
    firewall { "l2tp_${l2tp::protocol}_${l2tp::port}":
      source      => $l2tp::firewall_src,
      destination => $l2tp::firewall_dst,
      protocol    => $l2tp::protocol,
      port        => $l2tp::port,
      action      => 'allow',
      direction   => 'input',
      tool        => $l2tp::firewall_tool,
      enable      => $l2tp::manage_firewall,
    }
  }


  ### Debugging, if enabled ( debug => true )
  if $l2tp::bool_debug == true {
    file { 'debug_l2tp':
      ensure  => $l2tp::manage_file,
      path    => "${settings::vardir}/debug-l2tp",
      mode    => '0640',
      owner   => 'root',
      group   => 'root',
      content => inline_template('<%= scope.to_hash.reject { |k,v| k.to_s =~ /(uptime.*|path|timestamp|free|.*password.*|.*psk.*|.*key)/ }.to_yaml %>'),
    }
  }

}
