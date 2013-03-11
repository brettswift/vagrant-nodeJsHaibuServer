

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

  exec { "run ishiki":
      command => "node /usr/local/lib/node_modules/haibu-ishiki/index.js 2> /tmp/log/ishiki.error.log 1>/tmp/log/ishiki.log",
      cwd     => "/usr/local/lib/node_modules/haibu-ishiki",
      user    => root,
  }

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
    ->Exec['run ishiki']

}
