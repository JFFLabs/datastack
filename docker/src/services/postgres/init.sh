echo "POSTGRES_PASSWORD=\$SECRET" >> $LOT/.env

apt-get -y install postgresql-client

openssl req -new -x509 -nodes -text \
    -days 36500 \
    -subj "/CN=postgres" \
    -out $LOT/server.crt \
	-keyout $LOT/server.key \
&> /dev/null

chmod 600 $LOT/server.*
chown 999 $LOT/server.*
