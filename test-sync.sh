curl -X POST -H "Content-Type: application/json"  --data '{ "jsonrpc": "2.0", "method": "eth_syncing", "params": [], "id": 1}'   http://localhost:18545
echo ""

hex_value=$(curl -d '{"id":0,"jsonrpc":"2.0","method":"eth_getBlockByNumber","params":["latest",false]}' -H "Content-Type: application/json" http://localhost:18545 2> /dev/null | jq -r '.result.number')
hex_value=${hex_value#0x}
my_node_last_block=$((16#$hex_value))

hex_value=$(curl -d '{"id":0,"jsonrpc":"2.0","method":"eth_getBlockByNumber","params":["latest",false]}' -H "Content-Type: application/json" http://localhost:8545 2> /dev/null | jq -r '.result.number')
hex_value=${hex_value#0x}
last_block=$((16#$hex_value))

pct=$(echo "scale=5; (100 * $my_node_last_block) / $last_block" | bc)

echo "Current block: ${my_node_last_block}, ${pct} %"
