#
# Cookbook Name:: devbox
# Recipe:: packages
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

group "andrew" do
  action :create
end

user "andrew" do
  shell "/bin/zsh"
  gid "andrew"
  home "/home/andrew"
  password "$1$xN0FU/zW$hXBoXcEN8cEaSurRkyPxp."

  action :create
end

user "root" do
  password "$1$ZBRuBFN1$J2HNU4PKeqychEBfF1clw1"
  action :manage
end


directory '/home/andrew' do
  user 'andrew'
  group 'andrew'
  action :create
end
directory '/home/andrew/.ssh' do
  user 'andrew'
  group 'andrew'
  mode '700'
  action :create
end
directory '/root/.ssh' do
  user 'root'
  group 'root'
  mode '700'
  action :create
end

node.default['authorization']['sudo']['include_sudoers_d'] = true

sudo 'vagrant' do
  user 'vagrant'
end

sudo 'andrew' do
  user "andrew"
end

cookbook_file '/root/.ssh/gh_rsa' do
  source "gh_rsa"
  mode '600'
  action :create
end

cookbook_file '/home/andrew/.ssh/gh_rsa' do
  source "gh_rsa"
  mode '600'
  action :create
end

cookbook_file '/home/andrew/.ssh/id_rsa' do
  source "id_rsa"
  mode '600'
  action :create
end

cookbook_file '/etc/ssh/ssh_config' do
  source 'ssh_config'
  action :create
end
