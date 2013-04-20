Description
===========

This cookbook installs and configures [CouchDB](https://couchdb.apache.org) as a mirror of http://npmjs.org/.

Most of this work is based on the steps in @isaacs’s [npmjs.org README](https://github.com/isaacs/npmjs.org/blob/master/README.md)

Requirements
============

Platform
--------

* Ubuntu 12.10 (that's all we support at /dev/fort, so that's all I've tested in for now.)

Cookbooks
---------

* couchdb
* nodejs

Attributes
==========

This cookbook doesn't have any of its own configuration yet; instead, everything's configured using CouchDB attributes.

Notable, though, is the `override['couch_db']['config']['vhosts']` attribute-space. Within that, we can map Couch documents to vhosts. By default, this cookbook assumes you want `npm.fort` to serve http://npmjs.org’s web interface (at `/registry/_design/ui/_rewrite` in Couch) and `npm-registry.fort` to serve the npm registry (at `/registry/_design/scratch/_rewrite` in Couch). The code to do this looks like this:

```ruby
override['couch_db']['config']['vhosts']['npm.fort'] = "/registry/_design/ui/_rewrite"
override['couch_db']['config']['vhosts']['npm-registry.fort'] = "/registry/_design/scratch/_rewrite"
```

Recipes
=======

The main entrypoint for this cookbook is the `default` recipe.

When used with Vagrant, there's also a `vagrant` recipe to allow testing of the local npm mirror from inside the Vagrant VM.

Usage
=====

Include `npm-mirror` and it will install CouchDB and set it replicating http://npmjs.org. This will take a _very_ long time (probably a day or two), and require tens of gigabytes of storage. You have been warned.

You can keep an eye on the mirroring progress at `http://YOUR_MIRROR_HOSTNAME:5984/_utils/status.html`. Given the way Couch does replication, if you reload the VM or break the connection, it'll probably go a bit wrong and you'll need to start again. Again: you've been warned.

To use the npm mirror (which you can do even before mirroring is complete), add this to your `~/.npmrc` file:

    registry = http://YOUR_MIRROR_HOSTNAME:5984/registry/_design/app/_rewrite

You can also set the registry config property like:

    npm config set registry http://YOUR_MIRROR_HOSTNAME:5984/registry/_design/app/_rewrite

Or you can override it per-call:

    npm --registry http://localhost:5984/registry/_design/app/_rewrite install <package>

If you've configured vanity URLs (or are using the fort ones, above), you could just add this to your `~/.npmrc`:

    registry = http://npm-registry.fort:5984/