#!/bin/bash
set -e

chown -R prosody: /var/lib/prosody
chmod 700 /var/lib/prosody
sudo -u prosody "$@"
