if ! id -u $USERNAME 2>/dev/null 1>/dev/null; then
	if [ -z "$PASSWORD" ] || [ -z "$USERNAME" ]; then
		echo "Username or password not set"
		exit 1
	fi

	adduser -D -G root -G lpadmin $USERNAME
	echo "$USERNAME:$PASSWORD" | chpasswd

	if [ -n "$HP_USB" ]; then
		echo "n" | hp-setup -i -b usb --printer=hp
		echo "\nFinished configuration of hp printer"
	fi
fi

exec /usr/sbin/cupsd -f
