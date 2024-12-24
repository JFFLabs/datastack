echo "USER=$(echo $EMAIL | sed 's/@/_/')" >> $ENV
echo "postgres:5432:*:internal:$PASSWORD" > $LOT/.pgpass
echo "PGADMIN_DEFAULT_EMAIL=\$EMAIL" >> $LOT/.env
echo "PGADMIN_DEFAULT_PASSWORD=\$PASSWORD" >> $LOT/.env