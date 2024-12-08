CREATE USER airbyte;

DROP DATABASE IF EXISTS airbyte;
CREATE DATABASE airbyte WITH OWNER airbyte;

DROP DATABASE IF EXISTS airbyte_temporal;
CREATE DATABASE airbyte_temporal WITH OWNER airbyte;

DROP DATABASE IF EXISTS airbyte_temporal_visibility;
CREATE DATABASE airbyte_temporal_visibility with OWNER airbyte;
