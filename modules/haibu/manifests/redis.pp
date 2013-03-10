

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