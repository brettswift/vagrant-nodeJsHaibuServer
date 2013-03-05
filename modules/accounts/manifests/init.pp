# Used to define/realize users on Puppet-managed systems
#
class accounts {
 
  @accounts::virtual { 'vagrant':
    uid             =>  1001,
    realname        =>  'vagrant',
    # pass            =>  '<password hash goes here>',
  }

  @accounts::virtual { 'hpsa':
	uid             =>  1002,
	realname        =>  'hpsa',
	# pass            =>  '<password hash goes here>',
  }

}