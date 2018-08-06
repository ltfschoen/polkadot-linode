# Host Machine;

# Zip latest PoC-2 chain
tar -cvzf 2018-08-01-db-krummelanke.tar.gz "/Users/Ls/Library/Application Support/Polkadot/chains/krummelanke/db"

# Copy latest PoC-2 chain to Linode
rsync -avz "/Users/Ls/Library/Application Support/Polkadot/chains/krummelanke/db/2018-08-01-db-krummelanke.tar.gz" root@172.104.142.185:/root

# - Copy custom Docker files over from host machine with Rsync
#   - https://www.linode.com/docs/tools-reference/tools/introduction-to-rsync/
rsync -az --verbose --progress --stats --exclude='.git/' ~/code/linode root@172.104.142.185:/root;

# Watch for latest releases published to a repo 
# https://github.com/lilydjwg/nvchecker
git clone https://github.com/lilydjwg/nvchecker;
cd nvchecker;
python setup.py install

# Issue created https://github.com/lilydjwg/nvchecker/issues/78

# Create failover with script on the backup node that watches one node for activity and, if it looks dead, issues a killall -9 on it and continues itself.

Otherwise they’ll both be sending BFT messages and you’ll end up double-signing and get slashed.

# Docker Container
cd linode;

docker-compose up --force-recreate --build -d;
docker exec -it $(docker ps -q) bash;

polkadot \
  --validator \
  --base-path "/root/polkadot" \
  --chain krummelanke \
  --execution both \
  --keystore-path /root/polkadot/keys \
  --name "MITTELGROßES STAKE! 🔥🔥🔥" \
  --node-key "INSERT_KEY" \
  --port 30333 \
  --pruning 256 \
  --rpc-port 9933 \
  --telemetry-url ws://telemetry.polkadot.io:1024 \
  --ws-port 9944

# create other Polkadot validaotors
# docker exec -it $(docker ps -q) bash

# Show all Docker containers
# docker ps -a

# Show all Docker images
# docker images

# Show Docker Machine information
# docker inspect <CONTAINER_ID>

# https://manager.linode.com/linodes/remote_access/linode9256436
# https://www.linode.com/docs/troubleshooting/troubleshooting/

# Show Docker logs @chevdor
# docker logs -f polkadot.

# detach from tty without terminating running command with escape sequence
# CTRL+P and Q (hold CTRL the whole time)
# https://stackoverflow.com/questions/25267372/correct-way-to-detach-from-a-container-without-stopping-it

