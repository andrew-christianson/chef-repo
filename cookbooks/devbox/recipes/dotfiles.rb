#
# Cookbook Name:: devbox
# Recipe:: dotfiles
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
git "#{Chef::Config[:file_cache_path]}/dotfiles" do
  repository 'git@github.com:andrew-christianson/dotfiles.git'
  user 'root'
  checkout_branch "master"
  # mode '0755'
  enable_submodules true
  action :sync
  not_if { ::File.exists?('/home/andrew/.gitconfig') }
  notifies :run, 'execute[move-dotfiles]', :immediately
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
execute 'move-dotfiles' do
  command "rsync -a /var/chef/cache/dotfiles/.[^\.]* ."
  cwd "/home/andrew"
  action :run
  notifies :run, 'execute[own-dotfiles]', :immediately
end

execute 'own-dotfiles' do
  command 'chown -R andrew:andrew /home/andrew'
  action :run
end

service "lightdm" do
  action :stop
  action :disable
end
