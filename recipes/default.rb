#
# Cookbook Name:: et_openswan
# Recipe:: default
#
# Copyright (C) 2013 EverTrue, Inc.
# 
# All rights reserved - Do Not Redistribute
#

package "openswan" do
  action :install
end

include_recipe "et_openswan::ipsec"
include_recipe "et_openswan::radius"
include_recipe "et_openswan::xl2tp"