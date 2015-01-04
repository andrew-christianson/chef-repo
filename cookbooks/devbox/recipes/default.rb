#
# Cookbook Name:: devbox
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "devbox::packages"
include_recipe "devbox::user"
include_recipe "devbox::dotfiles"
