$master_script = <<SCRIPT
#!/bin/bash

apt-get install curl -y
REPOCM=${REPOCM:-cm5}
CM_REPO_HOST=${CM_REPO_HOST:-archive.cloudera.com}
CM_MAJOR_VERSION=$(echo $REPOCM | sed -e 's/cm\\([0-9]\\).*/\\1/')
CM_VERSION=$(echo $REPOCM | sed -e 's/cm\\([0-9][0-9]*\\)/\\1/')
OS_CODENAME=$(lsb_release -sc)
OS_DISTID=$(lsb_release -si | tr '[A-Z]' '[a-z]')
if [ $CM_MAJOR_VERSION -ge 4 ]; then
  cat > /etc/apt/sources.list.d/cloudera-$REPOCM.list <<EOF
deb [arch=amd64] http://$CM_REPO_HOST/cm$CM_MAJOR_VERSION/$OS_DISTID/$OS_CODENAME/amd64/cm $OS_CODENAME-$REPOCM contrib
deb-src http://$CM_REPO_HOST/cm$CM_MAJOR_VERSION/$OS_DISTID/$OS_CODENAME/amd64/cm $OS_CODENAME-$REPOCM contrib
EOF
curl -s http://$CM_REPO_HOST/cm$CM_MAJOR_VERSION/$OS_DISTID/$OS_CODENAME/amd64/cm/archive.key > key
apt-key add key
rm key
fi
apt-get update
export DEBIAN_FRONTEND=noninteractive
apt-get -q -y --force-yes install oracle-j2sdk1.7 cloudera-manager-server-db cloudera-manager-server cloudera-manager-daemons
service cloudera-scm-server-db initdb
service cloudera-scm-server-db start
service cloudera-scm-server start
SCRIPT

$hosts_script = <<SCRIPT
cat > /etc/hosts <<EOF
127.0.0.1       localhost
192.168.1.100	vm-cluster-master
192.168.1.101	vm-cluster-agent1
192.168.1.102	vm-cluster-agent2
192.168.1.103	vm-cluster-agent3
192.168.1.104	vm-cluster-agent4
192.168.1.105	vm-cluster-agent5
192.168.1.106	vm-cluster-agent6
192.168.1.107	vm-cluster-agent7

# The following lines are desirable for IPv6 capable hosts
::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters

EOF
SCRIPT

Vagrant.configure("2") do |config|

  # Define base image
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  # Manage /etc/hosts on host and VMs
  config.hostmanager.enabled = false
  config.hostmanager.manage_host = true
  config.hostmanager.include_offline = true
  config.hostmanager.ignore_private_ip = false

  config.vm.define :master do |master|
    master.vm.provider :virtualbox do |v|
      v.name = "vm-cluster-master"
      v.customize ["modifyvm", :id, "--memory", "8192"]
    end
    master.vm.network :public_network, ip: "192.168.1.100"
    master.vm.hostname = "vm-cluster-master"
	master.vm.provision :hostmanager
    master.vm.provision :shell, :inline => $hosts_script
    master.vm.provision :shell, :inline => $master_script
  end

  # config.vm.define :agent1 do |agent1|
    # agent1.vm.box = "precise64"
    # agent1.vm.provider :virtualbox do |v|
      # v.name = "vm-cluster-agent1"
      # v.customize ["modifyvm", :id, "--memory", "8192"]
    # end
    # agent1.vm.network :public_network, ip: "192.168.1.94"
    # agent1.vm.hostname = "vm-cluster-agent1"
    # agent1.vm.provision :shell, :inline => $hosts_script
    # agent1.vm.provision :hostmanager
  # end

  # config.vm.define :agent2 do |agent2|
    # agent2.vm.box = "precise64"
    # agent2.vm.provider :virtualbox do |v|
      # v.name = "vm-cluster-agent2"
      # v.customize ["modifyvm", :id, "--memory", "8192"]
    # end
    # agent2.vm.network :public_network, ip: "192.168.1.95"
    # agent2.vm.hostname = "vm-cluster-agent2"
	# agent2.vm.provision :hostmanager
    # agent2.vm.provision :shell, :inline => $hosts_script
  # end

  # config.vm.define :agent3 do |agent3|
    # agent3.vm.box = "precise64"
    # agent3.vm.provider :virtualbox do |v|
      # v.name = "vm-cluster-agent3"
      # v.customize ["modifyvm", :id, "--memory", "8192"]
    # end
    # agent3.vm.network :public_network, ip: "192.168.1.96"
    # agent3.vm.hostname = "vm-cluster-agent3"
	# agent3.vm.provision :hostmanager
    # agent3.vm.provision :shell, :inline => $hosts_script
  # end
  
 # config.vm.define :agent4 do |agent4|
   # agent4.vm.box = "precise64"
   # agent4.vm.provider :virtualbox do |v|
     # v.name = "vm-cluster-agent4"
     # v.customize ["modifyvm", :id, "--memory", "8192"]
   # end
   # agent4.vm.network :public_network, ip: "192.168.1.97"
   # agent4.vm.hostname = "vm-cluster-agent4"
   # agent4.vm.provision :hostmanager
   # agent4.vm.provision :shell, :inline => $hosts_script
 # end

  # config.vm.define :agent5 do |agent5|
    # agent5.vm.box = "precise64"
    # agent5.vm.provider :virtualbox do |v|
      # v.name = "vm-cluster-agent5"
      # v.customize ["modifyvm", :id, "--memory", "8192"]
    # end
    # agent5.vm.network :public_network, ip: "192.168.1.98"
    # agent5.vm.hostname = "vm-cluster-agent5"
	# agent5.vm.provision :hostmanager
    # agent5.vm.provision :shell, :inline => $hosts_script
  # end
  
  config.vm.define :agent6 do |agent6|
    agent6.vm.box = "precise64"
    agent6.vm.provider :virtualbox do |v|
      v.name = "vm-cluster-agent6"
      v.customize ["modifyvm", :id, "--memory", "2048"]
    end
    agent6.vm.network :public_network, ip: "192.168.1.106"
    agent6.vm.hostname = "vm-cluster-agent6"
	agent6.vm.provision :hostmanager
    agent6.vm.provision :shell, :inline => $hosts_script
  end
  
   config.vm.define :agent7 do |agent7|
    agent7.vm.box = "precise64"
    agent7.vm.provider :virtualbox do |v|
      v.name = "vm-cluster-agent7"
      v.customize ["modifyvm", :id, "--memory", "2048"]
    end
    agent7.vm.network :public_network, ip: "192.168.1.107"
    agent7.vm.hostname = "vm-cluster-agent7"
	agent7.vm.provision :hostmanager
    agent7.vm.provision :shell, :inline => $hosts_script
  end
end
