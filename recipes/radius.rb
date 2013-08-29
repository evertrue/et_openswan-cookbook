package "freeradius"
package "radiusclient1"
package "libradius1"
gem_package "xmpp4r"

cookbook_file "/usr/bin/oauth.rb" do
  source "oauth.rb"
  owner "root"
  group "root"
  mode 00755
end

radius_secret = Chef::EncryptedDataBagItem.load("secrets","ipsec")["radius_sources"][node["openswan"]["radius_source"]["name"]]["shared_secret"]

template "/etc/radiusclient/radiusclient.conf" do
  source "radiusclient.conf.erb"
  owner "root"
  group "root"
  mode 00644
end


file "/etc/radiusclient/servers" do
  action :create
  owner "root"
  group "root"
  mode 00600
  content "#{node['openswan']['radius_source']['hostname']} #{radius_secret}\n"
end
