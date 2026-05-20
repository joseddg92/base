#!/usr/bin/env bash
set -euo pipefail

RPC_URL="${RPC_URL:-http://localhost:8545}"
NETWORK="${NETWORK:-}"

SEPOLIA_ENODES=(
    "enode://45a06f4fc806768de7615174b9c8258db64202e6443418a3d8febea9362ba694272583e2c82a9755f9d450bf3b39a2af3336da579faf37deeb5bf724d8d19f5e@3.229.122.30:30303?discport=30304"
    "enode://b307ebfb325c0ebf14e169447f426b931307e14889f1ecc0111686c28cbeaf937a2455d06cd278222edf385f1c855b0f824b2adde748efec53dd66963656aa14@44.201.35.121:30303?discport=30304"
    "enode://a4805cc020882d9b79dc394529d3287009eee5cfb0efdac17fb7a54a2f646208f6f3de2bfd3405c4884908fb7a19c41ecfa62e63318d2f7cf434f397bf48e607@34.235.124.239:30303?discport=30304"
)

MAINNET_ENODES=(
    "enode://66d5be02684ffc4d24d06369e67a4fdc243c056ef202c24090b7e7653141fcb8a0739957574179b30ac33c6c290156bb1ce18d20b5cb4b69b5a8ec7c5319164c@44.222.222.185:30303?discport=30304"
    "enode://0e0807b47ff905a19d1ede5aac22f996907f618ba767d546935845d5cb1f841208d0d8ca6b5595225ec7c8df8b38398a248246128d4c4cbb1229f6a88772e104@100.48.64.89:30303?discport=30304"
    "enode://2fa37e7f077be76411552ae928ac5aea8e56970252c07a383abac00356ad31f35442d4c952383bf06735f6ccb1f75686eea43098d5be4fddd6d76cb58abc9859@34.229.101.57:30303?discport=30304"
)

if [ -z "$NETWORK" ]; then
    echo "\$NETWORK is required"
    exit 1
fi

case "$NETWORK" in
    sepolia) ENODES=("${SEPOLIA_ENODES[@]}") ;;
    mainnet) ENODES=("${MAINNET_ENODES[@]}") ;;
    *) echo "Unknown NETWORK: $NETWORK (expected: sepolia|mainnet)" >&2; exit 1 ;;
esac

echo "Adding ${#ENODES[@]} peer(s) to $RPC_URL (network: $NETWORK)"

for i in "${!ENODES[@]}"; do
    enode="${ENODES[$i]}"
    id=$((i + 1))
    echo "Adding peer: ${enode%%@*}@..."
    curl -sS -X POST "$RPC_URL" \
        -H "Content-Type: application/json" \
        -d "$(jq -n --arg enode "$enode" --argjson id "$id" \
            '{jsonrpc:"2.0", method:"admin_addPeer", params:[$enode], id:$id}')"
    echo
done

