directory "/export" do
    action :create
end

directory "/export/git" do
    action :create
end

mount "/export/git" do
  device "/dev/sdb1"
  fstype "ext4"
  action [:mount, :enable]
end

%w(
    nfs-kernel-server
).each do |pkg|
  package pkg
end

execute "service nfs-kernel-server start" do
    user "#{$user}"
    command "sudo service nfs-kernel-server restart"
end
