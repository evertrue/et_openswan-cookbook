package "libssl-dev"

patch_file="ppp-2.4.5-eaptls-mppe-0.994.patch"

execute "build-ppp" do
  command "./configure --prefix=/usr && make && make install && make install-etcppp"
  cwd "#{Chef::Config[:file_cache_path]}/ppp-src-2.4.5"
  creates "/tmp/something"
  action :run
end


execute "patch-ppp" do
  command "patch -p1 < #{Chef::Config[:file_cache_path]}/#{patch_file}"
  cwd "#{Chef::Config[:file_cache_path]}/ppp-src-2.4.5"
  action :nothing
end

cookbook_file "#{Chef::Config[:file_cache_path]}/#{patch_file}" do
  source patch_file
  owner "root"
  group "root"
  mode 00644
end

ark "ppp-src" do
  url 'http://ops.evertrue.com.s3.amazonaws.com/pkgs/ppp-2.4.5.tar.gz'
  path Chef::Config[:file_cache_path]
  version "2.4.5"
  checksum "43317afec9299f9920b96f840414c977f0385410202d48e56d2fdb8230003505"
  action :install
  notifies :run, "execute[patch-ppp]"
end

# #{Chef::Config[:file_cache_path]}/