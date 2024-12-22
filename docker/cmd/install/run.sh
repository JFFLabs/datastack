if [[ "$INSTALLED" != "" ]]; then
	echo "Datastack is already installed."
	exit 2
fi

cp -R /app/src/* /$VOL

echo "VOL=$VOL" >> $RUN/.env
echo "RUN=$RUN" >> $RUN/.env

if [[ "$swarm" != "" ]]; then
	$dkr swarm init > /dev/null
	$dkr network create --driver overlay --attachable $PKG_NAME > /dev/null
	tokn=$($dkr swarm join-token worker -q)
	echo "SWARM_TOKEN=$tokn" >> $RUN/.env
else
	$dkr network create $PKG_NAME > /dev/null
fi

$dkr network disconnect bridge $PKG_NAME
$dkr network connect $PKG_NAME $PKG_NAME

if [[ "$services" != "" ]]; then
	services=${services//,/ }
else
	services=$(ls -1 $VOL/services)
fi

for i in $services; do
	touch $RUN/.env.$i
	mkdir $RUN/$i

	cd $VOL/services/$i

	if [[ -e "install.sh" ]]; then
		. install.sh
	fi

	if [[ -e "compose.yml" ]]; then
		$dkr compose --env-file $APP/.env --env-file $RUN/.env up -d
	fi
done

echo "INSTALLED=1" >> $RUN/.env