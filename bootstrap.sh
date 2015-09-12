# The output of all these installation steps is noisy. With this utility
# the progress report is nice and concise.
function install {
    echo installing $1
    shift
    apt-get -y install "$@" >/dev/null 2>&1
}

echo updating package information
apt-add-repository -y ppa:brightbox/ruby-ng >/dev/null 2>&1
apt-get -y update >/dev/null 2>&1

install 'development tools' build-essential

echo installing russian locale
install language-pack-RU

# Needed for docs generation.
locale-gen ru_RU
locale-gen ru_RU.UTF-8

update-locale LANG=ru_RU.UTF-8 LANGUAGE=ru_RU.UTF-8 LC_ALL=ru_RU.UTF-8

install Ruby ruby2.2 ruby2.2-dev
update-alternatives --set ruby /usr/bin/ruby2.2 >/dev/null 2>&1
update-alternatives --set gem /usr/bin/gem2.2 >/dev/null 2>&1

echo installing Bundler
gem install bundler -N >/dev/null 2>&1

install Git git
install SQLite sqlite3 libsqlite3-dev
install memcached memcached
# install Redis redis-server
# install RabbitMQ rabbitmq-server


echo Installing additional library
install imagemagick libmagickwand-dev


install PostgreSQL postgresql postgresql-contrib libpq-dev

sudo -u postgres psql -f /vagrant/tools/db-prepare.sql

install 'Nokogiri dependencies' libxml2 libxml2-dev libxslt1-dev
install 'ExecJS runtime' nodejs



echo 'all set, rock on!'