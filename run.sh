#!/usr/bin/env bash
set -euo pipefail

NETWORK="${NETWORK:-mainnet}"

(
  sleep 30
  NETWORK="$NETWORK" ./add-peer.sh
) &
ADD_PEER_PID=$!

cleanup() {
  if kill -0 "$ADD_PEER_PID" 2>/dev/null; then
    kill "$ADD_PEER_PID" 2>/dev/null || true
  fi
}

trap cleanup EXIT

docker compose up --build
