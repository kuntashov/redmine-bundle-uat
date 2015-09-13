echo enable redmine core - current master

cd /vagrant/
git submodule update

rsync -a /vagrant/configs/database.yml ./redmine-core/config/

echo starting to bundle build

cd ./redmine-core

sudo -u vagrant bundle install
sudo -u vagrant bundle update

echo provisioning db and others

sudo -u vagrant bundle exec rake generate_secret_token

sudo -u vagrant bundle RAILS_ENV=development bundle exec rake db:migrate
