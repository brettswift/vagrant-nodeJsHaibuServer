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