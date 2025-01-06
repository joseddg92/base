curl -X POST -H "Content-Type: application/json"  --data '{ "jsonrpc": "2.0", "method": "eth_syncing", "params": [], "id": 1}'   http://localhost:18545
echo ""
curl -d '{"id":0,"jsonrpc":"2.0","method":"eth_getBlockByNumber","params":["latest",false]}' -H "Content-Type: application/json" http://localhost:18545 2> /dev/null | jq '.result.number' 
echo ""
