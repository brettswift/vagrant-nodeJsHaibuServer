Vagrant::Config.run do |config|

  config.vm.define :haibu do |config|
    config.vm.box = "CentOS-6.3-x86_64"
    config.vm.box_url = "http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.3-x86_64-v20130101.box"
    config.vm.host_name = "haibu"  #matches node name in site.pp or nodes/*.pp
    config.vm.network :hostonly, "33.33.33.20", :adapter => 2
    config.ssh.forward_x11 = true

    #recompile vbox additions to prevent error on re-up.
    # config.vm.provision :shell do |shell|
    #   shell.inline = "sudo lsmod | grep vboxsf  && echo 'vbox files are up to date' || '`sudo /etc/init.d/vboxadd setup`'"
    # end

    config.vm.provision :puppet, :module_path => "modules", :options => "--detailed-exitcodes --verbose --trace" do |puppet|
      puppet.manifests_path = "manifests"
      puppet.manifest_file  = "site.pp"
    end
    config.vm.customize [ "modifyvm", :id, "--name", "dev_env_haibu" ,"--memory", "1024"]
    config.vm.boot_mode = :gui
  end

end