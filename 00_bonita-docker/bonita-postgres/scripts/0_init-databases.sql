CREATE ROLE bonita_db_user LOGIN PASSWORD 'Cisc2021';
CREATE DATABASE bonita_db
  WITH OWNER = bonita_db_user
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       CONNECTION LIMIT = -1;

GRANT CONNECT, TEMPORARY ON DATABASE bonita_db TO public;
GRANT ALL ON DATABASE bonita_db TO bonita_db_user;



CREATE DATABASE bonita_bdm
  WITH OWNER = bonita_db_user
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       CONNECTION LIMIT = -1;

GRANT CONNECT, TEMPORARY ON DATABASE bonita_bdm TO public;
GRANT ALL ON DATABASE bonita_bdm TO bonita_db_user;
