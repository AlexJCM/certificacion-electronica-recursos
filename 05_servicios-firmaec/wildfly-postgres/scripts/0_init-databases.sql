CREATE USER firmadigital WITH PASSWORD 'firmadigital';
ALTER ROLE firmadigital WITH SUPERUSER;
CREATE DATABASE firmadigital WITH OWNER firmadigital;
GRANT ALL PRIVILEGES ON DATABASE firmadigital to firmadigital;
