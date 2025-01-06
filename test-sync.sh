curl -X POST \
	     -H "Content-Type: application/json" \
	          --data '{
       "jsonrpc": "2.0",
              "method": "eth_syncing",
	             "params": [],
		            "id": 1
			         }' \
					      http://127.0.0.1:18545

curl -d '{"id":0,"jsonrpc":"2.0","method":"eth_getBlockByNumber","params":["latest",false]}' -H "Content-Type: application/json" http://localhost:18545 | jq '.result.number'
