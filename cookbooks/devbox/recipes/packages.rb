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



%w(staticfloat/julianightlies
 staticfloat/julia-deps
 marutter/rrutter
 webupd8team/sublime-text-3
 webupd8team/atom
 git-core/ppa).each do |repo|
  ppa repo
end

 %w(wget
curl
ubuntu-desktop
build-essential
virtualbox-guest-dkms
virtualbox-guest-utils
virtualbox-guest-x11
git
xmonad
libghc-xmonad-dev
libghc-xmonad-contrib-dev
r-base
r-base-dev
emacs
erlang
zsh
autoconf
bison
build-essential
libssl-dev
libyaml-dev
libreadline6-dev
zlib1g-dev
libncurses5-dev
libffi-dev
libgdbm3
libgdbm-dev
libz-dev
libreadline-dev
libncursesw5-dev
libssl-dev
libgdbm-dev
libsqlite3-dev
libbz2-dev
python
ipython
python3
ipython3
python-pip
python3-pip
slurm
tcptrack
nethogs
rxvt-unicode
xmobar
suckless-tools
xloadimage
cabal-install
auto-apt
libxpm-dev
vim
libcurl4-openssl-dev
feh
xcompmgr
lfm
clang
iotop
iftop
python-dev
openjdk-7-jdk
dos2unix
python-numpy
tree
graphviz
mysql-client
python-mysqldb
python-pandas
python-virtualenv
libmysqlclient-dev
libsensors4
libsensors4-dev
julia
silversearcher-ag
nfs-client
).each do |pkg|
  package pkg
end


%w(Glances
PySensors
bottle
virtualenv
pylint
pygments
).each do |pkg|
  python_pip pkg
end

execute "auto-apt" do
  command "auto-apt update"
  action :run
  not_if {::File.exists?('/var/cache/auto-apt')}
end

chef_gem "rinruby"

%w(fortunes
caret
ggplot2
dplyr
plyr
pryr
devtools
testthat
roxygen2
randomForest
xlsx
).each do |pkg|
  r_package pkg
end
