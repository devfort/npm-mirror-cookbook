# Build a clone of npmjs.org, per https://github.com/isaacs/npmjs.org

include_recipe "couchdb"
include_recipe "nodejs"

package "curl"
package "npm"
# package "nodejs"
package "git"

# HACK: Node isn't called node, but everything expects it to be
# link "/usr/bin/node" do
#   to "/usr/bin/nodejs"
# end

execute "Create registry" do
  command <<-EOF
    curl -X PUT http://localhost:#{node.couch_db.config.httpd.port}/registry
  EOF
end

execute "Install couchapp and semver" do
  command <<-EOF
  npm install couchapp -g
  npm install couchapp
  npm install semver
  EOF
end

git "/srv/npmjs.org" do
  repository "https://github.com/isaacs/npmjs.org.git"
  enable_submodules true
end

execute "Sync the registry and search" do
  cwd "/srv/npmjs.org"
  command <<-EOF
  couchapp push registry/app.js http://localhost:#{node.couch_db.config.httpd.port}/registry
  couchapp push www/app.js http://localhost:#{node.couch_db.config.httpd.port}/registry
  EOF
end

# TODO: Work out how to do this without it timing out?
execute "Replicate npm's couchdb" do
  command <<-EOF
    curl -X POST -H "Content-Type:application/json" \
        http://localhost:#{node.couch_db.config.httpd.port}/_replicate -d \
        '{"source":"http://isaacs.iriscouch.com/registry/", "target":"registry"}'
  EOF
end

