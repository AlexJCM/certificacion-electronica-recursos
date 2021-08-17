-- Database firmadigital
\set dbname_firma `echo $DB_NAME_FIRMA`
\set user_firma `echo $DB_USER_FIRMA`
\set password_firma `echo $DB_PASS_FIRMA`

CREATE USER :user_firma WITH PASSWORD :'password_firma';
ALTER ROLE :user_firma WITH SUPERUSER;
CREATE DATABASE :dbname_firma WITH OWNER :user_firma;
GRANT ALL PRIVILEGES ON DATABASE :dbname_firma to :user_firma;
