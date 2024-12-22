if [[ "$INSTALLED" == "" ]]; then
	echo "Datastack is already uninstalled."
	exit 2
fi

if [[ $SWARM_TOKEN != "" ]]; then
	$dkr swarm leave --force
fi

if [[ "$services" != "" ]]; then
	services=${services//,/ }
else
	services=$(ls -1 $VOL/services)
fi

for i in $services; do
	cd $VOL/services/$i

	if [[ -e "uninstall.sh" ]]; then
		. install.sh
	fi

	if [[ -e "compose.yml" ]]; then
		$dkr compose --env-file $APP/.env --env-file $RUN/.env down -v
	fi

	rm -f $RUN/.env.$i
	rm -rf $RUN/$i
done

if [ ! -f $RUN/.env.* ]; then
	$dkr network disconnect $PKG_NAME $PKG_NAME
	$dkr network connect bridge $PKG_NAME
	$dkr network rm $PKG_NAME &> /dev/null

	echo > $RUN/.env
fi