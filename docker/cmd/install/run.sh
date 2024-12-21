if [[ "$INSTALLED" != "" ]]; then
	echo "Datastack is already installed"
	exit 2
fi

if [[ "$swarm" != "" ]]; then
	$dkr swarm init > /dev/null
	tokn=$($dkr swarm join-token worker -q)
fi

echo "INSTALLED=1" >> $ENV