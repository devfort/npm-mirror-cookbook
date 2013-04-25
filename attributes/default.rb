defaults['npm_mirror']['user'] = 'fort'

override['couch_db']['config']['httpd']['secure_rewrites'] = false
override['couch_db']['config']['httpd']['bind_address'] = "0.0.0.0"

# Allow our npm couch repo to respond to vanity URLs when on a fort
# TODO: Move these to a separate thing so we only use them when setting up a fort?
override['couch_db']['config']['vhosts']['npm.fort'] = "/registry/_design/ui/_rewrite"
override['couch_db']['config']['vhosts']['npm-registry.fort'] = "/registry/_design/scratch/_rewrite"
