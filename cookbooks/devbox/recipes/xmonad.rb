#
# Cookbook Name:: devbox
# Recipe:: xmonad
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


# service "lightdm" do
#   action :stop
#   action :disable
# end

execute "cabal-update" do
  command "cabal update"
  cwd "/home/andrew"
  environment "HOME" => "/home/andrew"
  user "andrew"
  not_if { ::File.exists?('/home/andrew/.cabal/bin/xmobar') }
  notifies :run, 'execute[xmobar]', :immediately
end

execute "xmobar" do
  command "cabal install xmobar"
  cwd "/home/andrew"
  environment "HOME" => "/home/andrew"
  user "andrew"
  not_if { ::File.exists?('/home/andrew/.cabal/bin/xmobar') }
  action :nothing
end

execute "link" do
  command "rm -f /home/andrew/.Xsession && ln -s /home/andrew/.xinitrc /home/andrew/.xsession"
  user "andrew"
  action :run
end

cookbook_file "/usr/share/xsession/custom.desktop" do
  source "custom.desktop"
  owner "root"
  action :create
end
