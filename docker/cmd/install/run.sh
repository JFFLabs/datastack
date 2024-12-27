if [[ "$INSTALLED" != "" ]]; then
	echo "ERR: $PKG_NAME is already installed, to initialize a service run with: init <service>"
	exit 2
fi

cp -R /app/src $APP

#
# Initialize and connect to network
#

if [[ "$swarm" != "" ]]; then
	$docker swarm init > /dev/null
	$docker network create --driver overlay --attachable $PKG_NAME > /dev/null
	tokn=$($docker swarm join-token worker -q)
	echo "SWARM_TOKEN=$tokn" >> $RUN/.env
else
	$docker network create $PKG_NAME > /dev/null
fi

$docker network disconnect bridge $PKG_NAME
$docker network connect $PKG_NAME $PKG_NAME

#
# Generate and collect basic runtime information
#

if [[ "$domain" == "" ]]; then
	read -p "Enter your domain (e.g. labs.jff.org): " domain
fi

if [[ "$email" == "" ]]; then
	read -p "Enter an administrator e-mail: " email
fi

if [[ ! "$email" =~ "@" ]]; then
	email="$email@$domain"
fi

if [[ ! "$internal" == "1" ]]; then
	internal="0"
fi

if [[ "$key" == "" ]]; then
	key="$(cat /proc/sys/kernel/random/uuid)"
fi

if [[ "$secret" == "" ]]; then
	secret="$(cat /proc/sys/kernel/random/uuid)"
fi

while true; do
	read -s -p "Please enter a password: " password
	echo
	read -s -p "Confirm your password: " password_confirmation
	echo
	[[ "$password" == "$password_confirmation" ]] && break
	echo "Please try again"
done

#
# Write and re-source our runtime environment
#

echo "KEY=$key"           >> $RUN/.env
echo "EMAIL=$email"       >> $RUN/.env
echo "DOMAIN=$domain"     >> $RUN/.env
echo "SECRET=$secret"     >> $RUN/.env
echo "PASSWORD=$password" >> $RUN/.env
echo "INTERNAL=$internal" >> $RUN/.env
echo "INSTALLED=1"        >> $RUN/.env

. $RUN/.env

#
# Install selected services, or all if none were specified
#

if [[ ! "$services" == "" ]]; then
	SERVICES=${services//,/ }
else
	SERVICES=$(ls -1 $APP/src/services)
fi

for SRV in $SERVICES; do
	$CMD init --service "$SRV" &
done

wait