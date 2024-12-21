if [[ $SWARM_TOKEN != "" ]]; then
	$dkr swarm leave --force
fi

rm $ENV