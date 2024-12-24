if [[ "$INTERNAL" == "1" ]]; then
	TLS="internal"
else
	TLS="$EMAIL"
fi

echo "TLS=$TLS" >> $LOT/.env