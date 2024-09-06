#!/bin/bash

# KDC default Realm
export KDC_REALM=${KDC_REALM:-'EXAMPLE.COM'}
# External KDC port.
export KDC_PORT=${KDC_PORT:-'88'}
# Default principal.
export KDC_PRIVILEGED_SUFFIX_PRINCIPAL=${KDC_PRIVILEGED_SUFFIX_PRINCIPAL:-'admin'}
# Default password.
export KDC_PASSWORD=${KDC_PASSWORD:-'password'}
# Default KDC domain
DEFAULT=$(hostname -f)
export KDC_DOMAIN=${KDC_DOMAIN:-$DEFAULT}
# Default domain REALM
KDC_DOMAIN_REALM="${KDC_REALM,,}"
export KDC_DOMAIN_REALM

envsubst < /etc/krb5.conf.template > /etc/krb5.conf
envsubst < /var/lib/krb5kdc/kdc.conf.template > /var/lib/krb5kdc/kdc.conf
envsubst < /var/lib/krb5kdc/kadm5.acl.template > /var/lib/krb5kdc/kadm5.acl

# Exit if any command fails
set -e

# Check if the Kerberos database exists, and create it if it doesn't
if [ ! -f /var/kerberos/krb5kdc/principal ]; then
    echo "Creating Kerberos database..."
    kdb5_util create -s -r "${KDC_REALM}" -P "${KDC_PASSWORD}"
    echo "Kerberos database created."
fi

# Start KDC and admin server using supervisord
exec /usr/bin/supervisord -c /etc/supervisord.conf
