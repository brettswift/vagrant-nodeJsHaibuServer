class haibu::packages{
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