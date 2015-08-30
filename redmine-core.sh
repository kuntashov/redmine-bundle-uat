echo enable redmine core (current master)

cd /vagrant/
git submodule update

echo starting to bundle build

cd ./redmine-core

bundle install
bundle update

cp /vagrant/config/database.yml ./config/

echo provisioning db and others

bundle exec rake generate_secret_token

bundle exec rake db:migrate

RAILS_ENV=development bundle exec rake db:migrate
