openssl req -new -x509 -days 36500 -nodes -text \
    -subj "/CN=postgres" \
    -out $RUN/postgres/server.crt \
	-keyout $RUN/postgres/server.key &> /dev/null

chmod 600 $RUN/postgres/server.*
chown 999 $RUN/postgres/server.*
