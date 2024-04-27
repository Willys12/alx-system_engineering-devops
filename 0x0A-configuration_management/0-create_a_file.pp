# Defines a file resource named school.
file { 'school':
  path    => '/tmp/school',
  owner   => 'www-data',
  group   => 'www-data',
  content => 'I love Puppet',
  mode    => '0744',
}
