#!/bin/sh
set -e

if [ "$1" = 'postgres' ]; then
	# SET DEFAULT VALUES IF NOT SET
	PGDATA=${PGDATA:-/var/services/data/postgres}
	PGLOG=${PGLOG:-/var/services/log/postgres}
	PGUSER=${PGUSER:-app}
	PGPASSWORD=${PGPASSWORD:-pgpass}
	PGDB=${PGDB:-app}
	PGSUPERPASSWORD=${PGSUPERPASSWORD:-none}
	mkdir -p "$PGDATA" "$PGLOG"
	chown -R postgres "$PGDATA" "$PGLOG"

	# INITIAL SETUP IF NO PGDATA FOLDER
	if [ -z "$(ls -A "$PGDATA")" ]; then
		# EDIT postgresql.conf
		gosu postgres initdb
		sed -ri "s/^#(listen_addresses\s*=\s*)\S+/\1'*'/" "$PGDATA"/postgresql.conf

		# CREATE PGUSER
		gosu postgres postgres --single -jE <<-EOSQL
			CREATE USER "$PGUSER" WITH PASSWORD '$PGPASSWORD';
		EOSQL

		# CREATE PGDB DATABASE
		gosu postgres postgres --single -jE <<-EOSQL
			CREATE DATABASE "$PGDB" OWNER "$PGUSER";
		EOSQL
		echo

		# WARNING FOR SIMPLE PGPASSWORD
		if [ "$PGPASSWORD" == 'pgpass' ]; then
			echo "*** please change to a more secure password, if this is running in production ! ***"
		fi

		# SET SUPER USER PASSWORD postgres
		if [ "$PGSUPERPASSWORD" != 'none' ]; then
			gosu postgres postgres --single -jE <<-EOSQL
				ALTER USER postgres WITH SUPERUSER PASSWORD '$PGSUPERPASSWORD';
			EOSQL
			echo
		fi

		# ALLOW ALL HOST
		{ echo; echo "host all all 0.0.0.0/0 md5"; } >> "$PGDATA"/pg_hba.conf
	fi

	# RUN POSTGRES
	exec gosu postgres "$@"
fi

# RUN OTHER COMMAND
exec "$@"
