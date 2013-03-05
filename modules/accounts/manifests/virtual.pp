# Defined type for creating virtual user accounts
# accounts module derived from:
#   -->  http://blog.scottlowe.org/2012/11/25/using-puppet-for-account-management/
define accounts::virtual ($realname, $uid) { #$pass) {
 
  user { $title:
    ensure            =>  'present',
    # uid               =>  $uid,
    gid               =>  $title,
    shell             =>  '/bin/bash',
    home              =>  "/home/${title}",
    comment           =>  $realname,
    # password          =>  $pass,
    managehome        =>  true,
    # require           =>  Group[$title],
  }
 
  group { $title:
    gid               =>  $uid,
  }
 
  file { "homeDirectoryFor_${title}":
    path              => "/home/${title}",
    ensure            =>  directory,
    owner             =>  $title,
    group             =>  $title,
    mode              =>  0750,
    require           =>  [ User[$title], Group[$title] ],
    # recurse           => true,
    # source            => [ "puppet:///modules/accounts/${title}",
    #                         "puppet:///modules/accounts/default" ],

  }


  notify {"accounts::${title}":
        message => "$title user being created.",
    }

    #if you do this recursively for the home directory, this changes permissions on native OS files. 
  file { "homeDirFilesFor_${title}":
    path              => "/home/${title}/.bashrc",
    source            => [ "puppet:///modules/accounts/home/${title}/.bashrc",
                            "puppet:///modules/accounts/home/default/.bashrc" ],
    require           => File["homeDirectoryFor_${title}"];
  } 
}