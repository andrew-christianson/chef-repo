#
# Cookbook Name:: devbox
# Recipe:: packages
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# cookbook_file "/etc/apt/apt.conf.d/90-apt-proxy.conf" do
#   source "90-apt-proxy.conf"
#   action :create
# end

mount "/git" do
  device "/dev/sdb1"
  fstype "ext4"
  action [:mount, :enable]
end

%w(wget curl build-essential git xmonad libghc-xmonad-dev libghc-xmonad-contrib-dev r-base r-base-dev emacs erlang zsh autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev libz-dev libreadline-dev libncursesw5-dev libssl-dev libgdbm-dev libsqlite3-dev libbz2-dev python ipython python3 ipython3 python-pip python3-pip slurm tcptrack nethogs rxvt-unicode xmobar suckless-tools xloadimage cabal-install auto-apt libxpm-dev vim libcurl4-openssl-dev feh tree graphviz).each do |pkg|
  package pkg
end

execute "auto-apt" do
  command "auto-apt update"
  action :run
  not_if {::File.exists?('/var/cache/auto-apt')}
end
