# Increasing the ULIMIT of default file
exec { 'fix--for-nginx':
  # ULIMIT value modification
  command => '/bin/sed -i "s/15/4096/" /etc/default/nginx',
  # sed command path
  path    => '/usr/local/bin/:/bin/',
}

# Restart nginx
exec { 'nginx_restart':
  command => '/etc/init.d/nginx restart',
  path    => '/etc/init.d/',
}

