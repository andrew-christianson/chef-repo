#
# Cookbook Name:: devbox
# Recipe:: packages
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

user "andrew" do
  shell "/bin/zsh"
  git "andrew"
  home "/home/andrew"
  password "$1$xN0FU/zW$hXBoXcEN8cEaSurRkyPxp."

  action :create
end
