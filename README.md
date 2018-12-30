### Create PoC-3 Substrate Node

#### Create a Basic Linode Instance

Create a [Linode account](https://www.linode.com/?r=4dbc9d2dfa5ba217a93e48d74a5b230eb5810cc0)

Create Linode instance in Linode Manager
* Select Nanode 1GB instance
* Select node location - i.e. Singapore
* Click Create

Deploy an Image
* Go to "Dashboard" of Linode instance
* Click Deploy an Image
* Select Ubuntu 18.04 LTS
* Select Disk 24000 MB (note that 12 GB is insufficient)
* Select Swap Disk 512 MB

Boot Image
* Go to "Dashboard" of Linode instance
* Click "Boot"

#### Remotely Access the Linode Instance

* Clone https://github.com/ltfschoen/polkadot-linode
* Change to cloned directory
  ```
  cd ~/code/src/ltfschoen/polkadot-linode
  ```
* Go to "Remote Access" of Linode instance
* Copy the "SSH Access" command from the Linode UI. i.e. ssh root@<INSERT_IP_ADDRESS_LINODE_INSTANCE_SUBSTRATE>

#### Install Docker on the Linode Instance

Use the IP Address from the SSH Access command to run the script to install Docker on the Linode. Note that if you get warning `WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!` then remove the contents of /Users/scon/.ssh/known_hosts and try again.

```
ssh root@<INSERT_IP_ADDRESS_LINODE_INSTANCE_SUBSTRATE> 'bash -s' < setup-docker.sh;
```

#### Copy a directory from the Host Machine to the Linode Instance

Use the IP Address from the SSH Access command to copy the cloned repo (containing custom Docker files) from the host machine to the Linode using Rsync. See https://www.linode.com/docs/tools-reference/tools/introduction-to-rsync/. Note that instead we could have simply SSHed into the Linode Instance and then simply cloned the repository with `git clone https://github.com/ltfschoen/polkadot-linode;`

```
rsync -az --verbose --progress --stats --exclude='.git/' ~/code/src/ltfschoen/polkadot-linode root@<INSERT_IP_ADDRESS_LINODE_INSTANCE_SUBSTRATE>:/root;
```

#### SSH Authentication into to the Linode Instance

```
ssh root@<INSERT_IP_ADDRESS_LINODE_INSTANCE_SUBSTRATE>
```

#### Create a Docker Container in the Linode Instance

Verify that the Linode Instance has Docker installed

```
docker --version
```

Change to the Substrate directory on the Linode Instance and create a Docker container

```
cd ~/polkadot-linode/substrate/charred-cherry;
docker-compose up --force-recreate --build -d;
```

#### Access the Docker Container in the Linode Instance

Enter Docker container using Bash

```
docker exec -it $(docker ps -q) bash;
```

#### Interact with Substrate

Go to https://polkadot.js.org/apps

Go to Settings

Select "Charred Cherry" (Substrate) from drop-down

Save & Reload

#### Create Account

Go to Accounts

Select "Create Account" tab

Select "Raw Seed" from the drop-down

Enter and remember an account name and password, click the account icon to copy the account address, and remember the raw seed as we will use this value (without the prefix `0x`) for the `--key` and `--node-key` values when starting the node.

#### Start Node

Create root screen

```
screen -S root
```

Start Substrate node in root screen

```
cd /substrate;
./target/release/substrate \
  --validator \
  --base-path "/root/charred-cherry" \
  --chain "charred-cherry" \
  --execution both \
  --key "<INSERT_ACCOUNT_RAW_SEED_WITHOUT_0x_PREFIX>" \
  --keystore-path "/root/charred-cherry/keys" \
  --name "CHARRED RUMP STAKE! 🔥🔥🔥" \
  --node-key "<INSERT_ACCOUNT_RAW_SEED_WITHOUT_0x_PREFIX>" \
  --port 30333 \
  --pruning 256 \
  --rpc-port 9933 \
  --telemetry-url ws://telemetry.polkadot.io:1024 \
  --ws-port 9944
```

Create a second window (non-root) using the `screen` program by pressing CTRL + A + C so that when you close it, it does not close the original.

Close the Bash Terminal tab. Note that since a second window within the Bash Terminal tab was running it does not kill the process that was running in the root window

#### Restart Node

WARNING: This approach will require you to sync the chain DB from scratch. Backup and load the chain DB first.

If you want to restart the node, with different flags and options for example.

Go to Linode Dashboard and click "Reboot"

Access the Linode Instance with SSH

```
ssh root@<INSERT_IP_ADDRESS_LINODE_INSTANCE_SUBSTRATE>
```

Restart the Docker Container in the Linode Instance

```
docker-compose up --force-recreate --build -d;
```

Access a Bash session in the the Docker Container

```
docker exec -it $(docker ps -q) bash;
```

Start the node

#### View Node Information

Open a Bash Terminal tab and SSH into Linode
```
ssh root@<INSERT_IP_ADDRESS_LINODE_INSTANCE_SUBSTRATE>
```

Access Docker container with Bash prompt
```
docker exec -it $(docker ps -q) bash;
```

View Disk Usage of Substrate chain DB. Note that 60,000 blocks used up 750 MB
```
du -hs /root/charred-cherry
```

### Create PoC-3 Polkadot Node

#### Create a Basic Linode Instance

Repeat steps from "Create PoC-3 Polkadot Node"

#### Remotely Access the Linode Instance

Repeat steps from "Create PoC-3 Polkadot Node"

#### Install Docker on the Linode Instance

Repeat steps from "Create PoC-3 Polkadot Node"

#### Copy a directory from the Host Machine to the Linode Instance

Repeat steps from "Create PoC-3 Polkadot Node"

#### SSH Authentication into to the Linode Instance

Repeat steps from "Create PoC-3 Polkadot Node"

#### Create a Docker Container in the Linode Instance

Verify that the Linode Instance has Docker installed

```
docker --version
```

Change to the Polkadot directory on the Linode Instance and create a Docker container

```
cd ~/polkadot-linode/polkadot/alexander;
docker-compose up --force-recreate --build -d;
```

#### Access the Docker Container in the Linode Instance

Repeat steps from "Create PoC-3 Polkadot Node"

#### Start Node

Create root screen

```
screen -S root
```

Start Polkadot node in root screen

```
polkadot \
  --validator \
  --base-path "/root/alex" \
  --chain "alex" \
  --execution both \
  --key "<INSERT_ACCOUNT_RAW_SEED_WITHOUT_0x_PREFIX>" \
  --keystore-path "/root/alex/keys" \
  --name "SCON'S STAKE! 🔥🔥🔥" \
  --node-key "<INSERT_ACCOUNT_RAW_SEED_WITHOUT_0x_PREFIX>" \
  --port 30333 \
  --pruning 256 \
  --rpc-port 9933 \
  --telemetry-url ws://telemetry.polkadot.io:1024 \
  --ws-port 9944
```

Create a second window (non-root) using the `screen` program by pressing CTRL + A + C so that when you close it, it does not close the original.

Close the Bash Terminal tab. Note that since a second window within the Bash Terminal tab was running it does not kill the process that was running in the root window

#### View Node Information

Open a Bash Terminal tab and SSH into Linode
```
ssh root@<INSERT_IP_ADDRESS_LINODE_INSTANCE_POLKADOT>
```

Access Docker container with Bash prompt
```
docker exec -it $(docker ps -q) bash;
```

View Disk Usage of Substrate chain DB
```
du -hs /root/alexander
```

#### Interact with Polkadot

Go to https://polkadot.js.org/apps

Go to Settings

Select "Alexander" (Polkadot) from drop-down

Save & Reload

### Miscellaneous

#### Share Chain Database

Zip latest chain

```
tar -cvzf 2018-08-01-db-krummelanke.tar.gz "/Users/Ls/Library/Application Support/Polkadot/chains/krummelanke/db"
```

Copy latest chain to Linode

```
rsync -avz "/Users/Ls/Library/Application Support/Polkadot/chains/krummelanke/db/2018-08-01-db-krummelanke.tar.gz" root@<INSERT_IP_ADDRESS_LINODE_INSTANCE_SUBSTRATE_OR_POLKADOT>:/root
```

#### Show System Information of Linode Instance

```
cd ~/polkadot-linode;
bash system-info.sh
```

#### Show Docker Information of Linode Instance

```
cd ~/polkadot-linode;
bash docker-info.sh
```

#### Destroy all Docker Images and Containers on the Linode Instance

```
cd ~/polkadot-linode;
bash destroy.sh
```

#### Creation of Additional Nodes

Creation of additional Substrate or Polkadot Nodes should use a different `--base-path`, have a different name, run on a different port `--port` (i.e. initial node `30333`, second node `30334`, etc), and the `--bootnodes` should include details of other initial nodes shown in Bash Terminal (i.e. `--bootnodes 'enode://QmPLDpxxhYL7dBiaHH26YqzXjLaaADoa4ShJSDnufgPpm1@127.0.0.1:30333'`)

### Troubleshooting

* https://manager.linode.com/linodes/remote_access/linode9256436
* https://www.linode.com/docs/troubleshooting/troubleshooting/