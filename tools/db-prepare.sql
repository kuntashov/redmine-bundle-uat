CREATE EXTENSION dblink;

DO
$body$
BEGIN
   IF NOT EXISTS (
      SELECT *
      FROM   pg_catalog.pg_user
      WHERE  usename = 'redmine') 
   THEN CREATE ROLE redmine LOGIN PASSWORD 'redmine';
   ELSE Raise notice 'user redmine allready create';
   END IF;
END
$body$;

ALTER USER redmine CREATEDB;

DO
$do$
BEGIN

IF EXISTS (SELECT 1 FROM pg_database WHERE datname = 'redmine_tests') THEN
   RAISE NOTICE 'Database for tests already exists'; 
ELSE
  PERFORM dblink_exec('dbname=' || current_database(), 'CREATE DATABASE redmine_tests OWNER=redmine');
  RAISE NOTICE 'Database for redmine tests is create'; 
END IF;

END
$do$;

DO
$do$
BEGIN

IF EXISTS (SELECT 1 FROM pg_database WHERE datname = 'redmine_develop') THEN
   RAISE NOTICE 'Database for redmine develop already exists'; 
ELSE
  PERFORM dblink_exec('dbname=' || current_database(), 'CREATE DATABASE redmine_develop OWNER=redmine');
  RAISE NOTICE 'Database for redmine development is create'; 
END IF;

END
$do$;

