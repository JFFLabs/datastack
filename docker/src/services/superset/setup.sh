#
# Update Superset credentials
#

while :; do
	TOKEN=$(curl "http://superset/api/v1/security/login" -s -X POST \
		-H 'Content-Type: application/json' \
		-d '{
			"username":"admin",
			"password":"admin",
			"provider":"db"
		}' \
	| jq -r '.access_token // empty')

	sleep 5

	if [[ "$TOKEN" != "" ]]; then
		curl "http://superset/api/v1/security/users/1" -s -X PUT \
			-H 'Content-Type: application/json' \
			-H 'Authorization: Bearer '"$TOKEN"'' \
			-d '{
				"email":"'$EMAIL'",
				"username":"'$EMAIL'",
				"password":"'$PASSWORD'"
			}' \
		> /dev/null
		break
	fi
done

$docker exec $PKG_NAME-superset superset fab import-roles --path /app/roles/public.json