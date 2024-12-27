echo "USR=$(echo $EMAIL | sed 's/@/_/')" >> $ENV

echo "PGADMIN_DEFAULT_EMAIL=\$EMAIL" >> $LOT/.env
echo "PGADMIN_DEFAULT_PASSWORD=\$PASSWORD" >> $LOT/.env

echo "postgres:5432:*:internal:$PASSWORD" > $LOT/.pgpass

wait-for-it -t 30 postgres:5432