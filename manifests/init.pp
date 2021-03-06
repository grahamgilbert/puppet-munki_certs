class munki_certs{

if versioncmp($::clientversion, '4') > 0 {
  $dir = '/etc/puppetlabs/puppet'
}else{
  $dir = '/etc/puppet'
}

# if $::clientversion > 4 {
  
# }
# else{
  
# }

file { '/Library/Managed Installs/':
  ensure  => directory,
}

file { '/Library/Managed Installs/certs/':
  ensure  => directory,
  owner   => 'root',
  group   => 'wheel',
  recurse => true,
}

file { '/Library/Managed Installs/certs/ca.pem':
  mode   => '0640',
  owner  => root,
  group  => wheel,
  source => "${dir}/ssl/certs/ca.pem",
  require => File['/Library/Managed Installs/certs/'],
}

file { '/Library/Managed Installs/certs/clientcert.pem':
  mode   => '0640',
  owner  => root,
  group  => wheel,
  source => "${dir}/ssl/certs/${clientcert}.pem",
  require => File['/Library/Managed Installs/certs/'],
}

file { '/Library/Managed Installs/certs/clientkey.pem':
  mode   => '0640',
  owner  => root,
  group  => wheel,
  source => "${dir}/ssl/private_keys/${clientcert}.pem",
  require => File['/Library/Managed Installs/certs/'],
}

mac_admin::osx_defaults { 'SoftwareRepoCACertificate':
  domain => '/Library/Preferences/ManagedInstalls',
  key    => 'SoftwareRepoCACertificate',
  type   => 'string',
  value  => '/Library/Managed Installs/certs/ca.pem',
}

mac_admin::osx_defaults { 'ClientCertificatePath':
  domain => '/Library/Preferences/ManagedInstalls',
  key    => 'ClientCertificatePath',
  type   => 'string',
  value  => '/Library/Managed Installs/certs/clientcert.pem',
}

mac_admin::osx_defaults { 'ClientKeyPath':
  domain => '/Library/Preferences/ManagedInstalls',
  key    => 'ClientKeyPath',
  type   => 'string',
  value  => '/Library/Managed Installs/certs/clientkey.pem',
}

mac_admin::osx_defaults { 'UseClientCertificate':
  domain => '/Library/Preferences/ManagedInstalls',
  key    => 'UseClientCertificate',
  type   => 'bool',
  value  => true,
}
}
