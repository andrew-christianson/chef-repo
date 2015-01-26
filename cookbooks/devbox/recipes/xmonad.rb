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

$user = "andrew"

execute "cabal-update" do
  command "cabal update"
  cwd "/home/#{$user}"
  environment "HOME" => "/home/#{$user}"
  user "#{$user}"
  not_if { ::File.exists?("/home/#{$user}/.cabal/bin/xmobar") }
  notifies :run, 'execute[xmobar]', :immediately
end

execute "xmobar" do
  command "cabal install xmobar"
  cwd "/home/#{$user}"
  environment "HOME" => "/home/#{$user}"
  user "#{$user}"
  not_if { ::File.exists?("/home/#{$user}/.cabal/bin/xmobar") }
  action :nothing
end

# execute "link" do
  # command "rm -f /home/#{$user}/.Xsession && ln -s /home/#{$user}/.xinitrc /home/#{$user}/.xsession"
  # user "#{$user}"
  # action :run
# end

cookbook_file "/usr/share/xsessions/custom.desktop" do
  source "custom.desktop"
  owner "root"
  mode "777"
  action :create
end
