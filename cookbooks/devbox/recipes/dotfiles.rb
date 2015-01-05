#
# Cookbook Name:: devbox
# Recipe:: dotfiles
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

cookbook_file "#{Chef::Config[:file_cache_path]}/ssh4git.sh" do
  source "ssh4git.sh"
  owner "root"
  mode "700"
  action :create
end

git "#{Chef::Config[:file_cache_path]}/dotfiles" do
  repository 'git@github.com:andrew-christianson/dotfiles.git'
  user 'root'
  # checkout_branch "master"
  # mode '0755'
  enable_submodules true
  ssh_wrapper "#{Chef::Config[:file_cache_path]}/ssh4git.sh"
  # action :checkout
  action :sync
  not_if { ::File.exists?('/home/andrew/.gitconfig') }
  notifies :run, 'bash[move-dotfiles]', :immediately
end

# Dir[ "#{Chef::Config[:file_cache_path]}/dotfiles/**/*" ].each do |curr_path|
#   file "/home/andrew/#{Pathname.new(curr_path).basename}" do
#     owner 'andrew'
#     group 'andrew'
#     # mode 0755
#     content lazy { IO.read(curr_path).read }
#     action :create
#   end if File.file?(curr_path)
#   directory "/home/andrew/#{File.dirname(curr_path)}" do
#     path curr_path
#     owner 'andrew'
#     group 'andrew'
#     # mode 0755
#     action :create
#   end if File.directory?(curr_path)
# end
bash 'move-dotfiles' do
  user "root"
 
  code <<-EOH 
  shopt -s dotglob
  rsync -a /var/chef/cache/dotfiles/* /home/andrew/
  EOH
  # cwd "/var/chef/cache/dotfiles/"
  action :run
  notifies :run, 'execute[own-dotfiles]', :immediately
end

execute 'hoist-df' do
  command "cp -R -t .. ./.[^\.]*"
  cwd "/home/andrew/dotfiles"
  action :nothing
  notifies :run, 'execute[own-dotfiles]', :immediately
end


execute 'own-dotfiles' do
  command 'chown -R andrew:andrew /home/andrew'
  action :run
end
