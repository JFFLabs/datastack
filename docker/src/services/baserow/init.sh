echo "DATABASE_HOST=postgres" >> $LOT/.env
echo "DATABASE_PORT=5432" >> $LOT/.env
echo "DATABASE_USER=postgres" >> $LOT/.env
echo "DATABASE_PASSWORD=\$SECRET" >> $LOT/.env
echo "DATABASE_NAME=_ds_baserow" >> $LOT/.env
echo "BASEROW_PUBLIC_URL=https://baserow.\$DOMAIN" >> $LOT/.env
echo "BASEROW_EXTRA_ALLOWED_HOSTS=baserow,baserow.\$DOMAIN" >> $LOT/.env

wait-for-it -t 30 postgres:5432
wait-for-it redis:6379

PGPASSWORD=$SECRET psql -w -h postgres -U postgres \
	-c "DROP DATABASE IF EXISTS _ds_baserow"

PGPASSWORD=$SECRET psql -w -h postgres -U postgres \
	-c "CREATE DATABASE _ds_baserow"