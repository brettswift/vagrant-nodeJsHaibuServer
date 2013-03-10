class haibu::mongo {

  exec { "add mongo package":
    command   => "echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' >> /etc/apt/sources.list",
    unless    => "grep 10gen /etc/apt/sources.list",
    user      => root
  }

  exec { "apt-key":
    command   => "apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10",
    unless    => "apt-key list | grep 7F0CEB10",
    user      => root,
  }


  exec { "apt-get update":
    command   => "apt-get -y update",
    timeout   => 3600,
    user      => root,
  }

  exec { "install mongo":
    command   => "apt-get -y install mongodb-10gen",
    unless    => "dpkg -l | grep mongo",
    user      => root,
  }

    Exec['add mongo package']
  ->Exec['apt-key']
  ->Exec['apt-get update']
  ->Exec['install mongo']
}

class haibu::redis {

    exec { "get redis":
      command   => "wget http://download.redis.io/redis-stable.tar.gz",
      cwd       => "/tmp",
      creates   => "/tmp/redis-stable.tar.gz",
    }

    exec { "tar redis": 
      command   => "tar xvzf redis-stable.tar.gz",
      cwd       => "/tmp",
      creates   => "/tmp/redis-stable",
    }

    exec { "make redis":
      command   => "make",
      cwd       => "/tmp/redis-stable",
      user      => root,
    }

    file { "/usr/local/bin/redis-server":
      source    => "/tmp/redis-stable/src/redis-server",
    }

    file { "/usr/local/bin/redis-cli":
      source    => "/tmp/redis-stable/src/redis-cli",
    }

    notify {"redis installed":
      message     => "Redis Installation Complete",
    }

    Exec["get redis"]
  ->Exec["tar redis"]
  ->Exec["make redis"]
  ->File["/usr/local/bin/redis-server"]
  ->File["/usr/local/bin/redis-cli"]
  ->Notify["redis installed"]

}

class haibu::nodejs($nodeVer) {


  file { "/tmp/node-install":
    ensure => "directory",
  }

  exec { "download node": 
      command   => "wget http://nodejs.org/dist/v${nodeVer}/node-v${nodeVer}.tar.gz",
      cwd       => "/tmp/node-install",    
      creates   => "/tmp/node-install/node-v${nodeVer}.tar.gz",
      user      => root,
  }

  exec { "extract node":
      command  =>  "tar -zxvf node-v${nodeVer}.tar.gz",
      cwd      => "/tmp/node-install",     
      creates  => "/tmp/node-install/node-v${nodeVer}",
      user     => root,
  }

  exec { "configure node":
      command  =>  "python configure",
      cwd      => "/tmp/node-install/node-v${nodeVer}",     
      creates  => "/tmp/node-install/node-v${nodeVer}/config.mk",
      user     => root,
  }

  exec { "make node":
      command  =>  "make",
      cwd      => "/tmp/node-install/node-v${nodeVer}",     
      creates  => "/tmp/node-install/node-v${nodeVer}/node",
      user     => root,
  }

  exec { "checkinstall node":
      command   => "checkinstall --install=yes --pkgname=nodejs --pkgversion ${nodeVer} --default",
      cwd      => "/tmp/node-install/node-v${nodeVer}",     
      unless    => "which node",
      user      => root,
  }

      File['/tmp/node-install']
    ->Exec['download node']
    ->Exec['extract node']
    ->Exec['configure node']
    ->Exec['make node']
    ->Exec['checkinstall node']

}


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
 class haibu::server{
  group {
    "puppet":
      ensure => present;
  }
 
  exec { "apt update":
    command   => "apt-get -y update",
    timeout   => 3600,
    user      => root,
  }

  package { "pkg-config":
    ensure    => latest,
  }

  package { "build-essential":
    ensure    => latest,
  }

  package { "curl":
    ensure    => latest,
  }

  package { "gcc":
    ensure    => latest,
  }

  package { "g++":
    ensure    => latest,
  }

  package { "checkinstall":
    ensure    => latest,
  }
}
