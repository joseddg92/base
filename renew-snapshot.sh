# Just clear the folder and start the node again (in snap mode)
rm -rf geth-data/*
rm -rf /big-box/nodes/base/geth-data/geth/chaindata/ancient/

mkdir -p geth-data/geth/chaindata
mkdir -p /big-box/nodes/base/geth-data/geth/chaindata/ancient/
