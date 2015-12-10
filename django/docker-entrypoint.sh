#!/bin/bash
python manage.py migrate                  # Apply database migrations
python manage.py collectstatic --noinput  # Collect static files

# Prepare log files and start outputting logs to stdout
touch /srv/logs/gunicorn.log
touch /srv/logs/access.log
tail -n 0 -f /srv/logs/*.log &

if [ -f "$CERT/cert.pem" ] && [ -f "$CERT/key.pem" ]; then

	# Start Gunicorn processes
	echo Starting HTTPS Gunicorn.
	exec gunicorn bootcamp.wsgi:application \
		--name bootcamp \
		--bind 0.0.0.0:8000 \
		--workers 3 \
		--keyfile $CERT/key.pem \
		--certfile $CERT/cert.pem \
		--ssl-version 3 \
		--do-handshake-on-connect \
		--log-level=info \
		--log-file=/srv/logs/gunicorn.log \
		--access-logfile=/srv/logs/access.log \
		"$@"
else
	echo Starting HTTP Gunicorn.

	exec gunicorn bootcamp.wsgi:application \
		--name bootcamp \
		--bind 0.0.0.0:8000 \
		--workers 3 \
		--log-level=info \
		--log-file=/srv/logs/gunicorn.log \
		--access-logfile=/srv/logs/access.log \
		"$@"
fi
