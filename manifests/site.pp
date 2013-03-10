Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

node haibu {
	# realize (Accounts::Virtual['vagrant'])
	include haibu::server
	include haibu::mongo
	include haibu::redis

	# include nodejs with version
	class { 'haibu::nodejs':
		nodeVer => "0.8.21",
	}

  
}

