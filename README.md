# Binance Smart Chain Full Node (Mainnet and Testnet)

https://docs.binance.org/smart-chain/developer/fullnode.html
### Startup

```
# bsc mainnet
docker-compose up --build -d bsc_mainnet
# bsc testnet
docker-compose up --build -d bsc_testnet
```

## Check sync status

```
docker exec bsc_mainnet bsc attach --exec eth.syncing

docker exec bsc_mainnet bsc attach --exec admin.peers.length

docker exec bsc_mainnet bsc attach --exec '(function(){if(!eth.syncing)return"Your node isnt syncing.";var n=eth.syncing.currentBlock;if(admin.sleep(10),!eth.syncing)return"Your node stopped syncing.";var e=eth.syncing.currentBlock-n,t=60*e/10;if(0===t)return"Current block didnt change; try increasing the sample time";var c=eth.syncing.highestBlock-eth.syncing.currentBlock;return"node synced "+e+" blocks in 10 seconds ("+t+" blocks/minute.)  If these 📈 continue, node will sync the remaining "+c+" blocks in "+c/t+" minutes."})()'

```

## Check logs

```
docker logs bsc_mainnet --tail 10 --follow

docker logs bsc_testnet --tail 10 --follow
```
## SSH to container

```
docker exec -it  bsc_mainnet /bin/ash
docker exec -it  bsc_testnet /bin/ash
```



Instance: i3.2xlarge

Open ports in security group: 30311 udp and tcp

Install git, docker and docker-compose:
GIT:
`
sudo yum update -y
sudo yum install git -y
`
DOCKER:
https://docs.aws.amazon.com/AmazonECS/latest/developerguide/docker-basics.html

DOCKER-COMPOSE:
`
sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose version
`

AWS time sync service: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/set-time.html

Mount attached volume with xfs: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-using-volumes.html


hddtemp
watch -n 1 'iostat -xmd 1 1'
iostat -xmd 1 1
docker stats
sudo smartctl -a /dev/nvme0n1
iftop


ip route show
https://www.cyberciti.biz/tips/linux-send-wake-on-lan-wol-magic-packets.html