# Class: l2tp::spec
#
# This class is used only for rpsec-puppet tests
# Can be taken as an example on how to do custom classes but should not
# be modified.
#
# == Usage
#
# This class is not intended to be used directly.
# Use it as reference
#
class l2tp::spec inherits l2tp {

  # This just a test to override the arguments of an existing resource
  # Note that you can achieve this same result with just:
  # class { "l2tp": template => "l2tp/spec.erb" }

  File['l2tp.conf'] {
    content => template('l2tp/spec.erb'),
  }

}
