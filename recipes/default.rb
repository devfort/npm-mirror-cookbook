# Build a clone of npmjs.org, per https://github.com/isaacs/npmjs.org
include_recipe "couchdb"

couch_url = "http://localhost:#{node['couch_db']['config']['httpd']['port']}"

package "curl"
http_request "Create registry" do
  action :put
  url "#{couch_url}/registry"
  not_if "curl --fail #{couch_url}/registry"
end
http_request "Replicate npmjs.org's couchdb" do
  # Delay until couch restarts, or this won't replicate
  action :nothing
  subscribes :put, "service[couchdb]", :immediately
  url "#{couch_url}/_replicator/npm-mirror"
  message({
    :source => "https://isaacs.ic.ht/registry",
    :target => "registry",
  })
  not_if "curl --fail #{couch_url}/_replicator/npm-mirror"
end

include_recipe "npm"

include_recipe "git"
git "/srv/npmjs.org" do
  repository "https://github.com/isaacs/npmjs.org.git"
end

%w{couchapp semver}.each { |pkg|
  npm_package pkg
  npm_package pkg do
    path "/srv/npmjs.org"
    action :install_local
  end
}

execute "Sync the registry-rewriter and search UI" do
 cwd "/srv/npmjs.org"
 command <<-EOF
   couchapp push registry/app.js #{couch_url}/registry
   couchapp push www/app.js #{couch_url}/registry
 EOF
end

log "Started mirroring npm; check #{couch_url}/_utils/status.html to monitor mirroring progress."
