# Use the minimal base image (Alpine)
FROM alpine:3.20.2

# Set environment variables for the KDC realm and domain
ENV REALM=EXAMPLE.COM
ENV DOMAIN=example.com

# Install required packages: krb5 (Kerberos), bash, and any other useful tools
# hadolint ignore=DL3018
RUN apk add --no-cache krb5 krb5-server bash supervisor tini && \
    mkdir -p /var/kerberos/krb5kdc /var/log/kerberos /etc/krb5.conf.d

# Copy Kerberos configuration templates
COPY krb5.conf /etc/krb5.conf
COPY kdc.conf /var/lib/krb5kdc/kdc.conf
COPY kadm5.acl /var/lib/krb5kdc/kadm5.acl
COPY supervisord.conf /etc/supervisord.conf

# Expose necessary Kerberos ports
EXPOSE 88 749

# Initialize Kerberos KDC database and start services
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Use tini as the init system to handle child processes
ENTRYPOINT ["/sbin/tini", "--", "/entrypoint.sh"]
