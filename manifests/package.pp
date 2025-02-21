# =Class superset::package
class superset::package inherits superset {

  if downcase($::osfamily) == 'redhat'{
    $deps = [
      'chromedriver',
      'chromium',
      'cyrus-sasl-devel',
      'gcc-c++',
      'gcc',
      'libffi-devel',
      'openldap-devel',
      'openssl-devel',
    ]
  } elsif downcase($::osfamily) == 'debian'{
    $deps = [
      'chromium',
      'ldap-utils',
      'libsasl2-dev',
      'libssl-dev',
      'policycoreutils',
      'python3-ldap',
      'libldap2-dev',
      'python3-pyldap',
    ]
  }

  package { $deps:
    ensure => present
  }

  file { '/usr/bin/google-chrome':
    ensure  => 'link',
    target  => '/usr/bin/chromium-browser',
    require => Package[$deps],
  }

  file { '/etc/conf.d':
    ensure => directory,
    owner  => 'root',
    group  => 'root'
  }
}
