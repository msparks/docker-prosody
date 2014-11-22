# docker-prosody

This is a Docker image for [Prosody](http://prosody.im), a light-weight XMPP
server.

This Docker image is intended to be used a base for other Docker images that
include their own virtual hosts and SSL keys, i.e., with a `FROM
msparks/prosody` statement in your Dockerfile. You should not use this image by
itself.

This image is automatically published on the
[Docker Hub](https://hub.docker.com/) at
[msparks/prosody](https://registry.hub.docker.com/u/msparks/devbox/).

## Usage

The default configuration creates a single VirtualHost for
`example.com`. SSL/TLS is enabled, but note that the private key for the
self-signed certificate is in the published image, so you obviously should not
use this image in a production environment.

To test out the image:

    # Create the data volume container.
    # Data is stored in /var/lib/prosody in the container.
    docker run --name=prosody-data msparks/prosody:data

    # Run prosody image.
    # DO NOT USE THIS IN PRODUCTION.
    docker run --rm -ti --name=prosody \
      -p 5222:5222 \
      --volumes-from prosody-data \
      msparks/prosody

    # Create a user. This is necessary because registration is disabled.
    docker exec -ti prosody prosodyctl adduser me@example.com

Then connect on port 5222 as `me@example.com` with the password you entered in
the last step.

## Paths

Prosody cares about these paths:

* `/etc/prosody` for configuration files.
* `/var/lib/prosody` for data. Exported as a volume by
  `msparks/prosody:data`.
* `/var/log/prosody` for logs

## Deriving from this image

If you want to build your own image from this one, you just need to create a new
Dockerfile that contains

    FROM msparks/prosody
    COPY conf /etc/prosody

and create a `conf` directory with your own `prosody.cfg.lua` file.
