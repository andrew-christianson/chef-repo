#
# Cookbook Name:: devbox
# Recipe:: packages
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
%w(wget curl build-essential git xmonad libghc-xmonad-dev libghc-xmonad-contrib-dev r-base r-base-dev emacs erlang zsh autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev libz-dev libreadline-dev libncursesw5-dev libssl-dev libgdbm-dev libsqlite3-dev libbz2-dev python ipython python3 ipython3 python-pip python3-pip slurm tcptrack nethogs rxvt-unicode xmobar suckless-tools xloadimage cabal-install).each do |pkg|
  package pkg
end

execute "xmobar" do
  command "cabal install xmobar"
  cwd "/home/andrew"
  environment "HOME" => "/home/andrew"
  user "andrew"
  if_not { ::File.exists?('/home/andrew/.cabal/bin/xmobar') }

end