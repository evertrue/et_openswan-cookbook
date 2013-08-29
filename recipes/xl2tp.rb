package "xl2tpd" do
  action :install
end

service "xl2tpd" do
  supports :restart => true
  action [ :enable, :start ]
end

template "/etc/xl2tpd/xl2tpd.conf" do
  source "xl2tpd.conf.erb"
  owner "root"
  group "root"
  mode 00644
  notifies :restart, "service[xl2tpd]"
end

cookbook_file "/etc/xl2tpd/ppp-options.xl2tpd" do
  source "ppp-options.xl2tpd"
  owner "root"
  group "root"
  mode 00644
  notifies :restart, "service[xl2tpd]"
end
