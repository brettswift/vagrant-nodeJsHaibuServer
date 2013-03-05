# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions

if [ -d "/u01/app/oracle/product/11.2.0" ]
then
	. /u01/app/oracle/product/11.2.0/xe/bin/oracle_env.sh 
	export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe
	export PATH=$ORACLE_HOME/bin:/$PATH
fi


export JAVA_HOME=/usr/java/jdk1.5.0_22
export PATH=$PATH:$JAVA_HOME/bin



### aliases ###
alias ll='ls -lah'

