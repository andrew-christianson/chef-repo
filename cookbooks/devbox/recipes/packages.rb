#
# Cookbook Name:: devbox
# Recipe:: packages
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
%w(wget curl build-essential git xmonad r-base r-base-dev emacs erlang zsh autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-devlibz-dev libreadline-dev libncursesw5-dev libssl-dev libgdbm-dev libsqlite3-dev libbz2-dev python ipython python3 ipython3 python-pip python3-pip).each do |pkg|
  package pkg
end
