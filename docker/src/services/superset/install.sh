echo "DATABASE_DIALECT=postgresql" >> $LOT/.env
echo "DATABASE_HOST=postgres" >> $LOT/.env
echo "DATABASE_PORT=5432" >> $LOT/.env
echo "DATABASE_USER=postgres" >> $LOT/.env
echo "DATABASE_PASSWORD=\$PASSWORD" >> $LOT/.env
echo "DATABASE_DB=_ds_superset" >> $LOT/.env
echo "SUPERSET_SECRET_KEY=\$KEY" >> $LOT/.env
echo "ALLOW_EMBED_FROM=\"*\"" >> $LOT/.env