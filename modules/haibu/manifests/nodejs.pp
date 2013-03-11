

class haibu::nodejs($nodeVer) {


  file { ["/tmp/node-install", 
          "/tmp/log"]:
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
      timeout  => 600,
      user     => root,
  }

  exec { "checkinstall node":
      command   => "checkinstall --install=yes --pkgname=nodejs --pkgversion ${nodeVer} --default",
      cwd       => "/tmp/node-install/node-v${nodeVer}",     
      unless    => "which node",
      user      => root,
  }

  # exec { "haibu":
  #     command   => "npm install haibu -g",
  #     user      => root,
  #     creates   => "/usr/local/lib/node_modules/haibu/",
  # }

  exec { "haibu-ishiki":
      command   => "npm install haibu-ishiki -g",
      user      => root,
      creates   => "/usr/local/lib/node_modules/haibu-ishiki/index.js",
  }

  # exec { "run haibu": 
  #     command   => "haibu &",
  # }

  file { "/usr/local/lib/node_modules/haibu-ishiki/config.json":
      source => "puppet:///modules/haibu/ishiki.config.json";
  }

  # file {"/tmp/log/ishiki.error.log":
  #     ensure  => present,
  #     mode    => '0666',
  # }

  # file {"/tmp/log/ishiki.log":
  #     ensure  => present,
  #     mode    => '0666',
  # }

  # install node for ishiki

  #mkdir
  file { ["/usr/local/lib/node_modules/haibu-ishiki/deployment",
          "/usr/local/lib/node_modules/haibu-ishiki/deployment/node-installs",
          "/usr/local/lib/node_modules/haibu-ishiki/deployment/node-installs/0.8.22"]:
          ensure => directory,
  }

  # TODO: wget this instead
  file { "/usr/local/lib/node_modules/haibu-ishiki/deployment/node-installs/node-v0.8.22.tar.gz":
      source => "puppet:///modules/haibu/node-v0.8.22.tar.gz",
  }

# sudo tar -xvzf node-v0.8.22.tar.gz &&  sudo mv node-v0.8.22/* 0.8.22/
  exec { "untar ishiki node 8.22":
    command   =>  "tar -xvzf node-v0.8.22.tar.gz &&  sudo mv node-v0.8.22/* 0.8.22/",
    cwd       =>  "/usr/local/lib/node_modules/haibu-ishiki/deployment/node-installs",
    user      =>  root,
  }

  exec { "configure ishiki node 8.22":
    command   =>  "python configure",
    cwd       =>  "/usr/local/lib/node_modules/haibu-ishiki/deployment/node-installs/0.8.22",
  }

  exec { "make ishiki node 8.22":
    command   => "make",
    cwd       =>  "/usr/local/lib/node_modules/haibu-ishiki/deployment/node-installs/0.8.22",
  }

      Exec['haibu-ishiki']
    ->File['/usr/local/lib/node_modules/haibu-ishiki/deployment']
    ->File['/usr/local/lib/node_modules/haibu-ishiki/deployment/node-installs']
    ->File['/usr/local/lib/node_modules/haibu-ishiki/deployment/node-installs/0.8.22']
    ->File['/usr/local/lib/node_modules/haibu-ishiki/deployment/node-installs/node-v0.8.22.tar.gz']
    ->Exec['untar ishiki node 8.22']
    ->Exec['configure ishiki node 8.22']
    ->Exec['make ishiki node 8.22']



  # Ishiki doesn't like being run in the background for some reason. 
  # exec { "run ishiki":
  #     command   => "sudo node /usr/local/lib/node_modules/haibu-ishiki/index.js & 2> /tmp/log/ishiki.error.log 1>/tmp/log/ishiki.log",
  #     cwd       => "/usr/local/lib/node_modules/haibu-ishiki",
  #     require   => [File['/tmp/log/ishiki.log'],File['/tmp/log/ishiki.error.log']],
  #     logoutput => true,
  #     user      => root,
  # }

      File['/tmp/node-install']
    ->Exec['download node']
    ->Exec['extract node']
    ->Exec['configure node']
    ->Exec['make node']
    ->Exec['checkinstall node']
    # ->Exec['haibu']
    ->Exec['haibu-ishiki']
    # ->Exec['run haibu']
    ->File['/usr/local/lib/node_modules/haibu-ishiki/config.json']
    # ->Exec['run ishiki']

}
