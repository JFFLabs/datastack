echo "DATABASE_HOST=postgres" >> $LOT/.env
echo "DATABASE_PORT=5432" >> $LOT/.env
echo "DATABASE_USER=postgres" >> $LOT/.env
echo "DATABASE_PASSWORD=\$SECRET" >> $LOT/.env
echo "DATABASE_NAME=_ds_baserow" >> $LOT/.env
echo "BASEROW_PUBLIC_URL=https://baserow.\$DOMAIN" >> $LOT/.env
echo "BASEROW_EXTRA_ALLOWED_HOSTS=baserow,baserow.\$DOMAIN" >> $LOT/.env