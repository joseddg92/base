
sudo mount -t cifs //u437101.your-storagebox.de/backup /box -o username=u437101,password=ym7DY5paArgm9BbX,vers=3.0

cd /data/nodes/base/geth-data/geth/chaindata/ancient/chain

# Create target directory in /box
mkdir -p /box/chain

# Variables
limit_bytes=$((90 * 1024 * 1024 * 1024))  # 90 GiB in bytes
total=0

# Loop through files in order
for f in $(ls -1 bodies.*.cdat | sort); do
    size=$(stat -c%s "$f")
    if [ $((total + size)) -le $limit_bytes ]; then
        mv "$f" /box/chain/
        ln -s "/box/chain/$f" "$f"
        total=$((total + size))
    else
        break
    fi
done

echo "Moved $((total / 1024 / 1024 / 1024)) GiB worth of files."
