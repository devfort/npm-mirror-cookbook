name              "npm_mirror"
maintainer        "Steve Marshall"
maintainer_email  "steve@nascentguruism.com"
license           "Apache 2.0"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "0.1"
depends           "couchdb"
depends           "nodejs"

recipe "npm_mirror", "Configures machine as an NPM mirror"
