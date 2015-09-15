#!/bin/bash

function testing {
    echo Another run for tests
	
	bundle exec rake tmp:clear
	bundle exec rake test
	
	cmd="phantomjs --webdriver 4444"
	$cmd &
	
	bundle exec rake test:ui
	
}

cd /vagrant/redmine-core/

echo Test only core
testing


for D in `find /vagrant/plugins/* -maxdepth 0 -type d`
do
	syncfrom=$D
	syncto=/vagrant/redmine-core/plugins/$(basename $D)
	echo sync from $syncfrom to $syncto
	rm -rf ./plugins/*
	
	rsync -a $syncfrom $syncto
	bundle update && bundle upgrade
	bundle exec rake db:migrate
	testing
done


cd /vagrant/

echo End the tests
