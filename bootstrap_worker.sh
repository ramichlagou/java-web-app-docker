#!/bin/bash

echo "[TASK 1] Ajout des noeud dans le Cluster"
yum install -q -y sshpass >/dev/null 2>&1
sshpass -p "root" scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no master.alphorm.form:/root/.kiube/joincluster.sh /root/joincluster.sh
bash /joincluster.sh 
