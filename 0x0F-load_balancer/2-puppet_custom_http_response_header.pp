# Ensure package list is up-to-date
exec { 'update_apt':
  command => '/usr/bin/apt-get update',
  path	  => '/usr/bin',
}

# Install nginx
package { 'nginx':
  ensure  => 'installed',
  require => exec['update_apt'],
}

# Ensure nginx is running
service { 'nginx':
  ensure    => 'running',
  enable    => true,
  subscribe => File['/etc/nginx/sites-enabled/default'],
}

# Creating custom index page
file { '/var/www/html/index.html':
  ensure  => 'file',
  content => 'Hello World!',
  require => Package['nginx'],
}

# Creating custom error page
file { '/var/www/html/404.html':
  ensure  => 'file'
  content => "Ceci n'est pas une page",
  require => Package['nginx']
}

# Custom header response
file_line { 'add_custom_header':
  ensure  => 'present',
  path    => '/etc/nginx/sites-enabled/default',
  after   => 'server_name _;',
  line    => 'add_header X-Served-By $HOSTNAME;',
  require => Package['nginx'],
  notify  => Service['nginx'],
}

# Performing redirections
file_line { 'perform redirection':
  ensure  => 'present',
  path    => '/etc/nginx/sites-enabled/default',
  after   => 'server_name _;',
  line    => 'rewrite ^/redirect_me https://github.com/Willys12 permanent;',
  require => Package['nginx'],
  notify  => Service['nginx'],
}

# Ensure config file is valid
exec { 'nginx_config_test':
  command     => '/usr/sbin/nginx -t',
  refreshonly => true,
  subscribe   => File['/etc/nginx/site-enabled/default'],
  notify      => Service['nginx'],
}

# Nginx restart
service { 'nginx_restart':
  ensure    => 'running',
  enable    => true,
  subscribe => Exec['nginx_restart'],
}
