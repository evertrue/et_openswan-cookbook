service "ipsec" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end

file "/proc/sys/net/ipv4/ip_forward" do
  action :create
  owner "root"
  group "root"
  mode 00644
  content "1\n"
end

file "/etc/sysctl.d/10-ipv4-ip_forward.conf" do
  action :create
  owner "root"
  group "root"
  mode 00644
  content "net.ipv4.ip_forward=1\n"
end

template "/etc/ipsec.conf" do
  source "ipsec.conf.erb"
  owner "root"
  group "root"
  mode 00644
  notifies :restart, "service[ipsec]"
end

template "/etc/ipsec.secrets" do
  source "ipsec.secrets.erb"
  owner "root"
  group "root"
  mode 00600
  variables(
    :psk => Chef::EncryptedDataBagItem.load("secrets", "ipsec")["psk"]
  )
  notifies :restart, "service[ipsec]"
end

# from-source version
# package "libssl-dev"
# package "libldap-dev"
# package "libselinux1-dev"
# package "bison"
# package "flex"
# ./configure --with-libldap --enable-natt --with-kernel-headers=/usr/include