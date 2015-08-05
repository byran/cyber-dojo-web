#!/bin/bash

echo gem: --no-rdoc --no-ri > ~/.gemrc
apt-get update

apt-get install -y apache2 curl git build-essential zlibc zlib1g-dev zlib1g libcurl4-openssl-dev libssl-dev apache2-prefork-dev libapr1-dev libaprutil1-dev libreadline6 libreadline6-dev
apt-get install -y build-essential libyaml-dev libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion

gem update --system
gem install rails --version 4.0.3
gem install passenger --version 4.0.53 --pre

echo #cyber-dojo >> /etc/apache2/apache2.conf
echo "<VirtualHost *:80>" >> /etc/apache2/apache2.conf
echo "	  ServerName www.yourhost.com" >> /etc/apache2/apache2.conf
echo "	  # !!! Be sure to point DocumentRoot to 'public'!" >> /etc/apache2/apache2.conf
echo "	  DocumentRoot /var/www/cyber-dojo/public " >> /etc/apache2/apache2.conf
echo "	  <Directory /var/www/cyber-dojo/public>" >> /etc/apache2/apache2.conf
echo "	     # This relaxes Apache security settings." >> /etc/apache2/apache2.conf
echo "	     AllowOverride all" >> /etc/apache2/apache2.conf
echo "	     # MultiViews must be turned off." >> /etc/apache2/apache2.conf
echo "	     Options -MultiViews" >> /etc/apache2/apache2.conf
echo "	     # Uncomment this if you're on Apache >= 2.4:" >> /etc/apache2/apache2.conf
echo "	     #Require all granted" >> /etc/apache2/apache2.conf
echo "	  </Directory>" >> /etc/apache2/apache2.conf
echo "</VirtualHost>" >> /etc/apache2/apache2.conf

echo LoadModule passenger_module /var/lib/gems/2.2.0/gems/passenger-4.0.53/buildout/apache2/mod_passenger.so > /etc/apache2/mods-available/passenger.load
echo PassengerRoot /var/lib/gems/2.2.0/gems/passenger-4.0.53 > /etc/apache2/mods-available/passenger.conf
echo PassengerDefaultRuby /usr/bin/ruby2.2 >> /etc/apache2/mods-available/passenger.conf
echo PassengerMaxPoolSize 6 >> /etc/apache2/mods-available/passenger.conf
echo PassengerPoolIdleTime 0 >> /etc/apache2/mods-available/passenger.conf
echo PassengerMaxRequests 1000 >> /etc/apache2/mods-available/passenger.conf
echo PassengerUserSwitching on >> /etc/apache2/mods-available/passenger.conf
echo PassengerDefaultUser www-data >> /etc/apache2/mods-available/passenger.conf
echo PassengerDefaultGroup www-data >> /etc/apache2/mods-available/passenger.conf

cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/cyber-dojo.conf
sed 's/www.html/www\/cyber-dojo\/public/' < /etc/apache2/sites-available/000-default.conf > /etc/apache2/sites-available/cyber-dojo.conf
cp /etc/apache2/sites-available/default-ssl.conf /etc/apache2/sites-available/cyber-dojo-ssl.conf
sed 's/www.html/www\/cyber-dojo\/public/' < /etc/apache2/sites-available/default-ssl.conf > /etc/apache2/sites-available/cyber-dojo-ssl.conf

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Install cyber-dojo

mkdir -p /var/www/
cd /var/www
git clone https://JonJagger@github.com/JonJagger/cyber-dojo

mkdir -p /var/www/cyber-dojo
chmod g+s /var/www/cyber-dojo/katas
rm /var/www/cyber-dojo/Gemfile.lock
cd /var/www/cyber-dojo && bundle install

# Build the caches
/var/www/cyber-dojo/exercises/cache.rb
/var/www/cyber-dojo/languages/cache.rb

# Set the files owner and group
cd /var/www/ && chown -R www-data cyber-dojo
cd /var/www/ && chgrp -R www-data cyber-dojo

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

sed -i '/Mutex file/d' /etc/apache2/apache2.conf
passenger-install-apache2-module --auto

a2enmod passenger
a2ensite cyber-dojo
a2dissite 000-default

# Now install docker

# Let's start with some basic stuff.
apt-get install -qqy apt-transport-https ca-certificates curl lxc iptables
    
# Install Docker from Docker Inc. repositories.
curl -sSL https://get.docker.com/ | sh

# Add the www-data user to the docker group
# so the server can run docker containers
usermod -aG docker www-data

