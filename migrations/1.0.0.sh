
read -p "Enter your domain (e.g. labs.jff.org): " domain
read -p "Enter an administrator e-mail: " email

secret="$(cat /proc/sys/kernel/random/uuid)"
password="$(cat /proc/sys/kernel/random/uuid)"

touch .env.baserow
echo "BASEROW_PUBLIC_URL=https://app.\$STACK_DOMAIN" >> .env.baserow
echo "DATABASE_URL=postgresql://postgres:\$STACK_PASSWORD@postgres:5432/baserow" >> .env.baserow

touch .env.postgres
echo "POSTGRES_PASSWORD=\$STACK_PASSWORD" > .env.postgres

touch .env.superset
echo "DATABASE_DB=superset" >> .env.superset
echo "DATABSE_HOST=postgres" >> .env.superset
echo "DATABASE_USER=postgres" >> .env.superset
echo "DATABASE_PASSWORD=\$STACK_PASSWORD" >> .env.superset
echo "SUPERSET_SECRET_KEY=\$STACK_SECRET" >> .env.superset
echo "SUPERSET_PORT=80" >> .env.superset

cp support/caddy.cfg config/caddy/Caddyfile
cp support/values.yml config/abctl/values.yml

sed -i -e "s/__password__/$(cat /proc/sys/kernel/random/uuid)/g" config/abctl/values.yml

touch .env
echo "STACK_EMAIL=$email" >> .env
echo "STACK_DOMAIN=$domain" >> .env
echo "STACK_SECRET=$secret" >> .env
echo "STACK_PASSWORD=$password" >> .env

touch superset/docker/requirements-local.txt
echo "Pillow" >> superset/docker/requirements-local.txt
echo "psycopg2-binary" >> superset/docker/requirements-local.txt

touch config/superset/docker.py
echo "FAB_API_SWAGGER_UI = True" >> config/superset/docker.py
echo "FAB_ADD_SECURITY_API = True" >> config/superset/docker.py
echo "RATELIMIT_STORAGE_URI = \"redis://redis:6379\"" >> config/superset/docker.py
