wait-for-it -t 30 postgres:5432

PGPASSWORD=$SECRET psql -w -h postgres -U postgres \
	-c "CREATE USER internal WITH PASSWORD '$PASSWORD'"

PGPASSWORD=$SECRET psql -w -h postgres -U postgres \
	-c "ALTER USER internal CREATEDB"

PGPASSWORD=$SECRET psql -w -h postgres -U postgres \
	-c "ALTER USER internal CREATEROLE"