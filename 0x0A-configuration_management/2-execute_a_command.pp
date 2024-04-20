# Kills a process named killmenow.
exec { 'killmenow':
  command     => 'pkill killmenow',
  onlyif      => 'pgrep killmenow',
  path        => '/bin:/usr/bin',
  refreshonly => true,
}
# Notifies that the process is terminated.
notify { 'successfull':
  message => 'Terminated',
  require => Exec['killmenow'],
}
