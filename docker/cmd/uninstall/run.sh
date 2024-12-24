if [[ "$INSTALLED" == "" ]]; then
	echo "Datastack is already uninstalled."
	exit 2
fi

if [[ "$SWARM_TOKEN" != "" ]]; then
	$docker swarm leave --force
fi

#
# Uninstall selected services or all if none were specified
#

if [[ ! "$services" == "" ]]; then
	SERVICES=${services//,/ }
else
	SERVICES=$(ls -1 $APP/services)
fi

for SRV in $SERVICES; do
	LOT="$RUN/$SRV"
	ENV="$RUN/.env.$SRV"
	SRC="$APP/services/$SRV"

	cd $SRC

	. $ENV

	if [[ -e "uninstall.sh" ]]; then
		. uninstall.sh
	fi

	if [[ -e "compose.yml" ]]; then
		$docker compose --env-file $APP/.env --env-file $RUN/.env --env-file $ENV down -v
	fi

	rm -rf $LOT
	rm -f  $ENV
done

#
# Disconnect and remove the network, clear the environment, if no more services are left
#

if [ ! -f $RUN/.env.* ]; then
	$docker network disconnect $PKG_NAME $PKG_NAME
	$docker network connect bridge $PKG_NAME
	$docker network rm $PKG_NAME &> /dev/null

	echo > $RUN/.env
fi