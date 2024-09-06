# Alpine Kerberos Docker

![Lint Dockerfile](https://github.com/bougar/alpine-kdc/actions/workflows/lint-dockerfile.yml/badge.svg)

This is a lightweight Docker image for setting up a **Kerberos Key Distribution Center (KDC)**, built on **Alpine Linux**.

## Features
- Lightweight image based on **Alpine Linux**.
- **KDC** and **Kadmin** services for managing Kerberos principals.
- Easily configurable through environment variables.

## Environment Variables

The following environment variables can be used to modify the configuration during the initialization of the KDC and Kadmin services:

### `KDC_REALM`
- **Description**: Default Kerberos realm for the KDC.
- **Default Value**: `EXAMPLE.COM`
  
### `KDC_PORT`
- **Description**: Internal container port to initialize the KDC.
- **Default Value**: `88`

### `KDC_PRIVILEGED_SUFFIX_PRINCIPAL`
- **Description**: All principals with this suffix will have administrative access to the Kadmin service (Kerberos management operations).
- **Default Value**: `admin`

### `KDC_PASSWORD`
- **Description**: Password used to encrypt the Kerberos database.
- **Default Value**: `password`

### `KDC_ADMIN`
- **Description**: Fully Qualified Domain Name (FQDN) of the KDC server. If not provided, the container's hostname will be used. You can specify this by setting the Docker `--hostname` argument.
- **Default Value**: (Container hostname)

## Example Usage

```bash
docker run -d --name kerberos-server \
    --hostname kdc.example.com \
    -e KDC_REALM=EXAMPLE.COM \
    -e KDC_PORT=88 \
    -e KDC_PASSWORD=supersecretpassword \
    -e KDC_PRIVILEGED_SUFFIX_PRINCIPAL=admin \
    bougar/alpine-kdc
```
