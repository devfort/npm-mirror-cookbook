override['couch_db']['config']['httpd']['secure_rewrites'] = false
override['couch_db']['config']['httpd']['bind_address'] = "0.0.0.0"

# Allow our npm couch repo to respond to vanity URLs when on a fort
override['couch_db']['config']['vhosts']['npm.fort'] = "/registry/_design/ui/_rewrite"
override['couch_db']['config']['vhosts']['npm-registry.fort'] = "/registry/_design/scratch/_rewrite"
