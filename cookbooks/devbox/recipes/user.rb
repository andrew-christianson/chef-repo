#
# Cookbook Name:: devbox
# Recipe:: packages
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
$user = "andrew"

group $user do
  action :create
end

user $user do
  shell "/bin/zsh"
  gid $user
  home "/home/#{$user}"
  password "$1$xN0FU/zW$hXBoXcEN8cEaSurRkyPxp."

  action :create
end

user "root" do
  password "$1$ZBRuBFN1$J2HNU4PKeqychEBfF1clw1"
  action :manage
end


directory '/home/#{$user}' do
  user '$user'
  group '$user'
  action :create
end
directory '/home/#{$user}/.ssh' do
  user '$user'
  group '$user'
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

sudo '#{$user}' do
  user $user
end

cookbook_file '/root/.ssh/gh_rsa' do
  source "gh_rsa"
  mode '600'
  action :create
end

cookbook_file '/home/#{$user}/.ssh/gh_rsa' do
  source "gh_rsa"
  mode '600'
  action :create
end

cookbook_file '/home/#{$user}/.ssh/id_rsa' do
  source "id_rsa"
  mode '600'
  action :create
end

cookbook_file '/etc/ssh/ssh_config' do
  source 'ssh_config'
  action :create
end

file "/etc/lightdm/lightdm.conf" do
  action :delete
end
