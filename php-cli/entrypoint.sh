#!/bin/bash

if [ -d "/root/.ssh" ]; then
    chmod 700 /root/.ssh
    chmod 600 /root/.ssh/id_rsa
    chmod 644 /root/.ssh/id_rsa.pub
fi

exec "$@"
