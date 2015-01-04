#
# Cookbook Name:: devbox
# Recipe:: dotfiles
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
git "#{Chef::Config[:file_cache_path]}/dotfiles" do
  source 'git://github.com/andrew-christianson/dotfiles.git'
  user 'andrew'
  gid 'andrew'
  mode '0755'
  enable_submodules true
  action :checkout
  not_if { ::File.exists?('/home/andrew/.gitconfig') }
  notifies :run, 'execute[install dotfiles]'
end

Dir[ "#{Chef::Config[:file_cache_path]}/dotfiles/**/*" ].each do |curr_path|
  file "/home/andrew/#{Pathname.new(curr_path).basename}" do
    owner 'andrew'
    group 'andrew'
    mode 0755
    content lazy { IO.read(curr_path).read }
    action :create
  end if File.file?(curr_path)
  directory "/home/andrew/#{File.dirname(curr_path)}" do
    path curr_path
    owner 'andrew'
    group 'andrew'
    mode 0755
    action :create
  end if File.directory?(curr_path)
end
