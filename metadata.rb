name              "npm-mirror"
maintainer        "Steve Marshall"
maintainer_email  "steve@nascentguruism.com"
license           "Apache 2.0"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           IO.read(File.join(File.dirname(__FILE__), 'VERSION')) rescue "0.1.0"
depends           "couchdb"
depends           "npm"

recipe "npm-mirror", "Configures the machine as a mirror of http://npmjs.org/"
