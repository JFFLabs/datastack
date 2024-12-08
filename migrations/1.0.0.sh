
read -p "Enter your domain (e.g. labs.jff.org): " domain
read -p "Enter an administrator e-mail: " email

secret="$(cat /proc/sys/kernel/random/uuid)"
password="$(cat /proc/sys/kernel/random/uuid)"

touch .env.postgres
echo "POSTGRES_PASSWORD=\$STACK_PASSWORD" > .env.postgres

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

cp support/caddy.cfg config/caddy/Caddyfile
cp support/airbyte.yml config/abctl/values.yml
cp support/superset.pip superset/docker/requirements-local.txt

sed -i -e "s/\$password/$password/g" config/abctl/values.yml

touch .env
echo "STACK_EMAIL=$email" >> .env
echo "STACK_DOMAIN=$domain" >> .env
echo "STACK_SECRET=$secret" >> .env
echo "STACK_PASSWORD=$password" >> .env
