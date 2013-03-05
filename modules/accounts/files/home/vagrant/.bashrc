# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

#colors
# export PS1='\[\033]0;\h: \w\007\]\[\033[01;31m\]\h \[\033[01;34m\]\W \$ \[\033[00m\]'


#Oracle specific settings
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

# HPSA Alias'
if [ -e "/etc/init.d/activator" ]
then
	alias jboss_log_folder='cd /opt/HP/jboss/server/default/log'
	alias tail_jboss_startup='tail -f /opt/HP/jboss/server/default/log/server.log'
	alias hpsa_start='/etc/init.d/activator start'
	alias hpsa_stop='/etc/init.d/activator stop'
	alias hpsa_check='/etc/init.d/activator check'
	alias hpsa_solutions_dir='cd /opt/OV/ServiceActivator/solutions'
	alias hpsa_sa_dir='cd /etc/opt/OV/ServiceActivator'
	alias hpsa_exe_dir='cd /opt/OV/ServiceActivator/bin/'
	alias hpsa_log_dir='cd /var/opt/OV/ServiceActivator/log/'
fi
