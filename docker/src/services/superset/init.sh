echo "DATABASE_DIALECT=postgresql" >> $LOT/.env
echo "DATABASE_HOST=postgres" >> $LOT/.env
echo "DATABASE_PORT=5432" >> $LOT/.env
echo "DATABASE_USER=postgres" >> $LOT/.env
echo "DATABASE_PASSWORD=\$SECRET" >> $LOT/.env
echo "DATABASE_DB=_ds_superset" >> $LOT/.env
echo "SUPERSET_SECRET_KEY=\$KEY" >> $LOT/.env
echo "ALLOW_EMBED_FROM=\"*\"" >> $LOT/.env

git clone --depth 1 -b ${VER_SUPERSET} https://github.com/apache/superset.git $LOT/app
cp $SRC/lib/install.pip $LOT/app/docker/requirements-local.txt

wait-for-it -t 30 postgres:5432
wait-for-it redis:6379

PGPASSWORD=$SECRET psql -w -h postgres -U postgres \
	-c "DROP DATABASE IF EXISTS _ds_superset"

PGPASSWORD=$SECRET psql -w -h postgres -U postgres \
	-c "CREATE DATABASE _ds_superset"