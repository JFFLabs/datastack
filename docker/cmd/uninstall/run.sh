if [[ "$INSTALLED" == "" ]]; then
	echo "WRN: $PKG_NAME is already uninstalled."
	exit 2
fi

#
# Uninstall selected services or all if none were specified
#

if [[ ! "$services" == "" ]]; then
	SERVICES=${services//,/ }
else
	SERVICES=$(ls -1 $APP/src/services)
fi

for SRV in $SERVICES; do
	ENV="$RUN/.env.$SRV"

	if [[ -f "$ENV" ]]; then
		. $ENV

		cd $SRC

		if [[ -x "uninstall.sh" ]]; then
			. uninstall.sh
		fi

		if [[ -f "compose.yml" ]]; then
			$docker compose --env-file $PKG/.env --env-file $ENV down -v
		fi

		rm -rf $LOT
		rm -f  $ENV
	fi
done

#
# Disconnect and remove the network, clear the environment, if no more services are left
#

if [[ ! -f $RUN/.env.* ]]; then
	$docker network disconnect $PKG_NAME $PKG_NAME
	$docker network connect bridge $PKG_NAME
	$docker network rm $PKG_NAME > /dev/null

	echo > $RUN/.env

	if [[ ! "$SWARM_TOKEN" == "" ]]; then
		$docker swarm leave --force
	fi
fi