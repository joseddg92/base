#!/usr/bin/env bash
set -euo pipefail

docker-compose up --build &
COMPOSE_PID=$!

sleep 30

NETWORK="mainnet" ./add-peer.sh

wait "$COMPOSE_PID"
