# Skyway

Official stats and community site for [Aqueous](https://aqueousband.com/).

## Setup (OSX)

Clone the repo, install Vagrant. Then:

``` shell
vagrant up
```

Once it's done, visit: http://local.aqueous.band. Done.

## Ops

### Plugins

* https://github.com/dokku/dokku-postgres
* https://github.com/rlaneve/dokku-link
* https://github.com/mordred/dokku-redirects-plugin
* https://github.com/jlachowski/dokku-memcached-plugin
* https://github.com/scottatron/dokku-rebuild

### Rebuild

```
apt-get install nodejs postgresql-server-dev-all postgresql-client-9.3 unzip
cd /var/lib/dokku/plugins
dokku plugins-install
dokku postgresql:create aqueousband.com

# Push app to dokku@IP_ADDRESS:aqueousband.com
dokku postgresql:link aqueousband.com aqueousband.com
psql -d db -h DB_ADDRESS -p DB_PORT < dump.sql

dokku memcached:create aqueousband.com
dokku memcached:link aqueousband.com aqueousband.com

dokku redirects:set aqueousband.com www.aqueousband.com=aqueousband.com www.aqueousband.net=aqueousband.com aqueousband.net=aqueousband.com

dokku config:set aqueousband.com ADMIN_PASSWORD=x AWS_ACCESS_KEY_ID=x AWS_SECRET_ACCESS_KEY=x S3_BUCKET_NAME=files.aqueousband.net S3_HOST_NAME=s3-eu-west-1.amazonaws.com
```

### Tasks

Run a migration, ssh in and:

```
dokku run aqueousband.com rake db:migrate
```

Sometimes memcached gets unhappy. If so:

```
dokku memcached:delete aqueousband.com
dokku memcached:rebuild aqueousband.com
dokku memcached:link aqueousband.com aqueousband.com
```

Restarting/rebuilding container: `dokku rebuild aqueousband.com`

Backup:

```
dokku postgres:export aqueousband.com > now.sql.bak
```

Restoring:

```
pg_restore -d skyway_development now.sql.bak
```

### Updating Dokku

From http://progrium.viewdocs.io/dokku/upgrading but in case that goes away:

```
cd ~/dokku
git pull --tags origin master
sudo make install

cd ~/buildstep
git pull origin master
sudo make build
```

Might need to rebuild after that.

## Waveforms

Making some wave(form)s? Install this for Linux:

```
# install deps
sudo apt-get install make g++ libsndfile-dev lib-png++-dev libpng12-dev libboost-program-options-dev sox libsox-fmt-mp3 mp3info

# install wav2png
git clone git@github.com:beschulz/wav2png.git
cd wav2png/build
make install

# Move downloads over and wave it up
mv ~/Downloads/*.mp3 tmp/
./script/wav2png
```

For mp3 length:

```
mp3info -p "%S\n" something.mp3
```

## License

MIT. See `LICENSE`.
