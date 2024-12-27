if [[ "$INSTALLED" == "" ]]; then
	echo "ERR: $PKG_NAME is no longer installed, to install it run with: install"
	exit 2
fi

SRV="$service"
LOT="$RUN/$SRV"
ENV="$RUN/.env.$SRV"
SRC="$APP/src/services/$SRV"

if [[ ! -d "$SRC" ]]; then
	echo "Could not locate service $SRV for initialization";
	exit 1
fi

if [[ ! -d "$LOT" ]]; then
	mkdir $LOT
fi

touch $ENV
echo > $ENV

touch $LOT/.env
echo > $LOT/.env

echo "SRV=$SRV" >> $ENV
echo "PKG=$PKG" >> $ENV
echo "APP=$APP" >> $ENV
echo "RUN=$RUN" >> $ENV
echo "LOT=$LOT" >> $ENV
echo "SRC=$SRC" >> $ENV

cd $SRC

if [[ -x "init.sh" ]]; then
	. init.sh
fi

if [[ -f "compose.yml" ]]; then
	$docker compose --env-file $PKG/.env --env-file $ENV up -d --quiet-pull
fi

if [[ -x "setup.sh" ]]; then
	. setup.sh
fi