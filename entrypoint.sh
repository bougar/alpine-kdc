#!/bin/bash

# Exit if any command fails
set -e

# Check if the Kerberos database exists, and create it if it doesn't
if [ ! -f /var/kerberos/krb5kdc/principal ]; then
    echo "Creating Kerberos database..."
    kdb5_util create -s -r ${REALM} -P password
    echo "Kerberos database created."
fi

# Start KDC and admin server using supervisord
exec /usr/bin/supervisord -c /etc/supervisord.conf
