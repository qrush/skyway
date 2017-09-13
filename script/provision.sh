#!/usr/bin/env bash
# https://gist.github.com/johanneswuerbach/10785de9cc856009f6ea

sudo locale-gen en_US.UTF-8
sudo update-locale LANG=en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8

sudo apt-get update
sudo apt-get install -y build-essential gnupg2 git curl libxslt1-dev libxml2-dev libssl-dev libcurl4-openssl-dev imagemagick

# postgres
echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main " | sudo tee -a /etc/apt/sources.list.d/pgdg.list
sudo wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update
sudo apt-get install -y postgresql-9.3 libpq-dev
echo '# "local" is for Unix domain socket connections only
local   all             all                                  trust
# IPv4 local connections:
host    all             all             0.0.0.0/0            trust
# IPv6 local connections:
host    all             all             ::/0                 trust' | sudo tee /etc/postgresql/9.3/main/pg_hba.conf
sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /etc/postgresql/9.3/main/postgresql.conf
sudo /etc/init.d/postgresql restart
sudo su - postgres -c 'createuser -s vagrant'

# rvm and ruby
su - vagrant -c 'gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB'
su - vagrant -c 'curl -sSL https://get.rvm.io | bash'
su - vagrant -c 'rvm install ruby-2.4.1'
su - vagrant -c 'rvm rvmrc warning ignore allGemfiles'

# passenger
su - vagrant -c 'gem install passenger 5.1.5'
su - vagrant -c 'rvmsudo passenger-install-nginx-module --auto --auto-download'

# node
su - vagrant -c 'curl https://raw.githubusercontent.com/creationix/nvm/v0.14.0/install.sh | sh'
su - vagrant -c 'nvm install 0.10'
su - vagrant -c 'nvm alias default 0.10'

# app
su - vagrant -c 'gem install bundler'
su - vagrant -c 'mkdir -p /var/www'
su - vagrant -c 'cd /var/www/skyway && bin/setup -v'

# finish passenger
echo 'worker_processes  2;

events {
    worker_connections  1024;
}

http {
    passenger_root /home/vagrant/.rvm/gems/ruby-2.4.1/gems/passenger-5.1.5;
    passenger_ruby /home/vagrant/.rvm/gems/ruby-2.4.1/wrappers/ruby;

    include       mime.types;
    default_type  application/octet-stream;
    sendfile        on;
    keepalive_timeout  65;
    server {
        listen 80;
        root /var/www/skyway/public;
        passenger_enabled on;
        passenger_app_env development;
    }
}' | sudo tee /opt/nginx/conf/nginx.conf
sudo /opt/nginx/sbin/nginx

echo "All done installing!

Next steps: type 'vagrant ssh' to log into the machine, or visit local.aqueous.band"
