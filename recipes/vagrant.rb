# TODO: Install this npmrc for other users?
template "/home/vagrant/.npmrc" do
  source "npmrc.erb"
  owner "vagrant"
  group "vagrant"
  mode "0644"
end
