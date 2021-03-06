#
# Cookbook Name:: devbox
# Recipe:: fonts
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

$user = "andrew"

file "/etc/fonts/conf.d/70-no-bitmaps.conf" do
  action :delete
  notifies :run, 'execute[fc-cache]', :delayed
end

execute 'fc-cache' do
  command "fc-cache -fv ."
  cwd "/home/#{$user}/.fonts"
  action :run
end
