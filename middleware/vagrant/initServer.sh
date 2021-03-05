#!/bin/bash
echo "entra"
echo $1
# permission 
cat /dev/zero | ssh-keygen -q -N ""
sshpass -p "123" ssh-copy-id -o StrictHostKeyChecking=no root@192.168.1.82

# restore database
sudo mkdir -m 777 /db
scp -r root@$2:/db/backups/$1 /db
mongorestore /db/$1

# download repo
git clone https://github.com/MaicolM11/lab3.git
cd lab3/server
npm install
sudo PORT=3000 IP_BACKUP=$2 URL_DB='mongodb://127.0.0.1:27017/lab3' pm2 start index.js