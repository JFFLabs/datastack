

touch .env.postgres
echo "PGADMIN_DEFAULT_EMAIL=\$STACK_LOGIN_EMAIL" >> .env.postgres
echo "PGADMIN_DEFAULT_PASSWORD=\$STACK_LOGIN_PASSWORD" >> .env.postgres

touch .env.baserow
echo "DATABASE_HOST=postgres" >> .env.baserow
echo "DATABASE_PORT=5432" >> .env.baserow
echo "DATABASE_USER=postgres" >> .env.baserow
echo "DATABASE_PASSWORD=\$STACK_PASSWORD" >> .env.baserow
echo "DATABASE_NAME=_ds_baserow" >> .env.baserow
echo "BASEROW_PUBLIC_URL=https://baserow.\$STACK_DOMAIN" >> .env.baserow

touch .env.superset
echo "DATABASE_DIALECT=postgresql" >> .env.superset
echo "DATABASE_HOST=postgres" >> .env.superset
echo "DATABASE_PORT=5432" >> .env.superset
echo "DATABASE_USER=postgres" >> .env.superset
echo "DATABASE_PASSWORD=\$STACK_PASSWORD" >> .env.superset
echo "DATABASE_DB=_ds_superset" >> .env.superset
echo "SUPERSET_SECRET_KEY=\$STACK_SECRET" >> .env.superset
echo "ALLOW_EMBED_FROM=\"*\"" >> .env.superset

touch .env
echo "STACK_EMAIL=$email" >> .env
echo "STACK_DOMAIN=$domain" >> .env
echo "STACK_SECRET=$secret" >> .env
echo "STACK_PASSWORD=$password" >> .env
echo "STACK_LOGIN_EMAIL=$login" >> .env
echo "STACK_LOGIN_PASSWORD=$login_password" >> .env
