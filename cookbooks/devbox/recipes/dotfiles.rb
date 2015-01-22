#
# Cookbook Name:: devbox
# Recipe:: dotfiles
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
$user ="andrew"

cookbook_file "#{Chef::Config[:file_cache_path]}/ssh4git.sh" do
  source "ssh4git.sh"
  owner "root"
  mode "700"
  action :create
end

git "#{Chef::Config[:file_cache_path]}/dotfiles" do
  repository 'https://github.com/andrew-christianson/dotfiles.git'
  additional_remotes["github"] = "git@github.com:andrew-christianson/dotfiles.git"
  user 'root'
  # checkout_branch "master"
  # mode '0755'
  enable_submodules true
  ssh_wrapper "#{Chef::Config[:file_cache_path]}/ssh4git.sh"
  # action :checkout
  action :sync
  not_if { ::File.exists?('/home/#{$user}/.gitconfig') }
  notifies :run, 'bash[move-dotfiles]', :immediately
end

bash 'move-dotfiles' do
  user "root"

  code <<-EOH
  shopt -s dotglob
  rsync -a /var/chef/cache/dotfiles/* /home/#{$user}/
  EOH
  # cwd "/var/chef/cache/dotfiles/"
  action :run
  notifies :run, 'execute[own-dotfiles]', :immediately
end

execute 'hoist-df' do
  command "cp -R -t .. ./.[^\.]*"
  cwd "/home/#{$user}/dotfiles"
  action :nothing
  notifies :run, 'execute[own-dotfiles]', :immediately
end


execute 'own-dotfiles' do
  command 'chown -R #{$user}:#{$user} /home/#{$user}'
  action :run
end
