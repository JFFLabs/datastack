git clone --depth 1 -b ${VER_MATATIKA} https://github.com/Matatika/matatika-ce.git $LOT/sup

echo "PERSISTENCE_CATALOG_URL=jdbc:postgresql://postgres:5432/_ds_matatika" >> $LOT/.env
echo "PERSISTENCE_CATALOG_DRIVER_CLASS_NAME=org.postgresql.Driver" >> $LOT/.env
echo "PERSISTENCE_CATALOG_PASSWORD=\$SECRET" >> $LOT/.env
echo "PERSISTENCE_CATALOG_USERNAME=postgres" >> $LOT/.env

echo "APP_SERVER_URI=https://matatika.$DOMAIN/api" >> $LOT/.env
echo "APP_URL=https://matatika.$DOMAIN" >> $LOT/.env

echo "ELASTICSEARCH_HOST=elasticsearch" >> $LOT/.env

echo "MATATIKA_AUTH_LOCAL_SECRET=\$KEY" >> $LOT/.env

wait-for-it -t 30 postgres:5432
wait-for-it -t 60 elasticsearch:9200

PGPASSWORD=$SECRET psql -w -h postgres -U postgres \
	-c "DROP DATABASE IF EXISTS _ds_matatika"

PGPASSWORD=$SECRET psql -w -h postgres -U postgres \
	-c "CREATE DATABASE _ds_matatika"

set -a
ES_PATH_CONF=/tmp
MATATIKA_ES_ELASTIC_PASSWORD=$SECRET
MATATIKA_ES_BASE_URI=http://elasticsearch:9200
set +a

$LOT/sup/orchestrate/matatika/elastic-search/config/setup.sh