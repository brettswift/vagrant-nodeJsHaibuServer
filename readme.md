hpsaDevCluster
==============
This 
Required Files
--------------
modules/oracle

oracle-xe-11.2.0-1.0.x86_64_rpm.zip
jdk-6u41-linux-amd64.rpm
sqldeveloper-3.2.20.09.87-1.noarch.rpm

Manual Steps
=============
Users
-------
must change passwords of users (except vagrant user).
> sudo passwd <username> 

HPSA
-----
1. must run ./ActivatorConfig.  (prefix with java home)
> JAVA_HOME=<path to jdk> ./ActivatorConfig
2. sqldeveloper install
    the file will be there - this puppet task is failing, so run it manually: 
<pre>
# --> this is failing right now. 
      #  "rpm sqldev":
      # command => "/bin/rpm -Uvh /tmp/sqldeveloper-3.0.04.34-1.noarch.rpm",
      # cwd => "/tmp",
      # require => [Exec["install jdk"]File["/tmp/sqldeveloper-3.0.04.34-1.noarch.rpm"]],
      # user => root;
</pre> 

TODO
------
**hpsa**

- Exec
 - unmount iso



TroubleShooting
================
when you see this: 
>The following SSH command responded with a non-zero exit status.
>Vagrant assumes that this means the command failed!
>
>mount -t vboxsf -o uid=`id -u vagrant`,gid=`id -g vagrant` v-root /vagrant

run this: 
>sudo /etc/init.d/vboxadd setup