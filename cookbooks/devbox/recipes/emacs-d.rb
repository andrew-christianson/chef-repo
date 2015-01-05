#
# Cookbook Name:: devbox
# Recipe:: emacs-d
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
execute 'cask install' do
  command '/home/andrew/.cask/bin/cask install'
  cwd '/home/andrew/.emacs.d'
  user 'andrew'
  environment "HOME" => "/home/andrew"
end
