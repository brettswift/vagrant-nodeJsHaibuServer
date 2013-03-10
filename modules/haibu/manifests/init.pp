# import "*.pp"

  # exec {
  #   "/usr/bin/yum -y update":
  #     alias => "yumUpdate",
  #     user => root,
  #     timeout => 3600; 
  # }

  # # simplified haibu install once nodejs puppet forge lib supports node 0.8.x
  # # package { 'haibu':
  # #     ensure      => '0.9.x',
  # #     provider    => 'npm'
  # # }

  # package {"autoconf":
  #     ensure => installed;
  # }
  # package {"flex":
  #     ensure => installed;
  # }
  # package {"bison":
  #     ensure => installed;
  # }
 
  # package { "openssl-devel":
  #     ensure => installed;
  # }
  # package { "mongo-10gen":
  #     provider => 'yum',
  #     require  => File['/etc/yum.repos.d/10gen.repo'],
  #     ensure   => installed;
  #   }
  # package { "mongo-10gen-server":
  #     provider => 'yum',
  #     require  => File['/etc/yum.repos.d/10gen.repo'],
  #     ensure   => installed;
  # }

  # service {  "mongod":
  #     require => [Package['mongo-10gen-server'],Package['mongo-10gen']],
  #     enable  => true,
  #     ensure  => running;
  # }

  # service {  "iptables":
  #     enable => false,
  #     ensure => stopped;
  # }

  # file { "/etc/yum.repos.d/10gen.repo":
  #     source => "puppet:///modules/haibu/10gen.repo";
  # }

  # file { "/usr/local/lib/node_modules/haibu-ishiki/config.json":
  #     require => Exec['install ishiki'],
  #     source => "puppet:///modules/haibu/ishiki.config.json";
  # }

  # exec {
  #   "download node": 
  #     command => "/usr/bin/wget http://nodejs.org/dist/v0.8.15/node-v0.8.15.tar.gz",
  #     cwd     => '/usr/local/src',    
  #     creates => "/usr/local/src/node-v0.8.15.tar.gz",
  #     user    => root;

  #   "extract node":
  #    command =>  "/bin/tar zxvf node-v0.8.15.tar.gz",
  #    require => Exec['download node'],
  #    cwd     => '/usr/local/src',    
  #    creates => "/usr/local/src/node-v0.8.15",
  #    user    => root;

  #   "configure node":
  #     command => "/usr/bin/python configure",
  #     path    => "/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/home/vagrant/bin",
  #     require => Exec['extract node'],
  #     cwd     => "/usr/local/src/node-v0.8.15",
  #     creates => "/usr/local/src/node-v0.8.15/config.mk",
  #     user    => root;

  #   "compile node":
  #     command => "/usr/bin/make",
  #     require => Exec['configure node'],
  #     cwd     => "/usr/local/src/node-v0.8.15",
  #     creates => "/usr/local/src/node-v0.8.15/out/Release/node",
  #     user    => root;
 
  #   "install node":
  #     command => "/usr/bin/make install",
  #     require => Exec['compile node'],
  #     cwd     => "/usr/local/src/node-v0.8.15",
  #     unless  => "/usr/bin/test `which node`",
  #     user    => root;

  #   "install haibu":
  #     command => "/usr/local/bin/npm install haibu -g",
  #     require => Exec['install node'],
  #     cwd     => "/home/vagrant",
  #     creates => "/usr/local/lib/node_modules/haibu",
  #     user    => root;

  #   # "run haibu":
  #   #   command => "/usr/local/bin/haibu &",
  #   #   require => [Exec['install haibu'],Service['iptables']],
  #   #   cwd     => "/home/vagrant",
  #   #   user    => root;

  #   # sudo chmod -R 0777 /usr/local/lib/node_modules/

  #   "install ishiki":
  #     command => "/usr/local/bin/npm install haibu-ishiki -g",
  #     require => Exec['install node'],
  #     cwd     => "/home/vagrant",
  #     creates => "/usr/local/lib/node_modules/haibu-ishiki",
  #     user    => root;

  #   "run ishiki":
  #     command => "/usr/local/bin/node /usr/local/lib/node_modules/haibu-ishiki/index.js & > /tmp/log/ishiki.log",
  #     cwd     => "/usr/local/lib/node_modules/haibu-ishiki",
  #     require => File['/usr/local/lib/node_modules/haibu-ishiki/config.json'],
  #     user    => root;

  # }

  #   Service['mongod'] -> Exec['install ishiki'] -> File['/usr/local/lib/node_modules/haibu-ishiki/config.json'] -> Exec['run ishiki']

