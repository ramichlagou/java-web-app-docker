#!/bin/bash


echo "[TASK 1] Mise a jour  /etc/hosts file"
cat >>/etc/hosts<<EOF
172.16.0.100 master1.alphorm.form kmaster
172.16.0.101 worker1.alphorm.form kworker1
172.16.0.102 jenkins1

EOF


echo "[TASK 2] Installation du runtime docker "
yum install -y -q yum-utils device-mapper-persistent-data lvm2 > /dev/null 2>&1
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo > /dev/null 2>&1
yum install -y -q docker-ce >/dev/null 2>&1


echo "[TASK 3] Activation et démarrage du service docker"
systemctl enable docker >/dev/null 2>&1
systemctl start docker

echo "[TASK 4] Désactivation de  SELinux"
setenforce 0
sed -i --follow-symlinks 's/^SELINUX=enforcing/SELINUX=disabled/' /etc/sysconfig/selinux

echo "[TASK 5] Arret et désactivation du service firewalld"
systemctl disable firewalld >/dev/null 2>&1
systemctl stop firewalld

echo "[TASK 6] Quelques parametres sysctl"
cat >>/etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl --system >/dev/null 2>&1

echo "[TASK 7] Désactivation et Arret du SWAP"
sed -i '/swap/d' /etc/fstab
swapoff -a

echo "[TASK 8] Ajout du repo yum pour  kubernetes"
cat >>/etc/yum.repos.d/kubernetes.repo<<EOF
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
        https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

echo "[TASK 9] Installation de Kubernetes (kubeadm, kubelet and kubectl)"
yum install -y -q kubeadm kubelet kubectl >/dev/null 2>&1


echo "[TASK 10] Activation et démarrage du service  kubelet"
systemctl enable kubelet >/dev/null 2>&1
systemctl start kubelet >/dev/null 2>&1

echo "[TASK 11] Activation du l'autentification du ssh password"
sed -i 's/^PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
systemctl reload sshd

echo "[TASK 12] Mot de passe du root"
echo "root" | passwd --stdin root >/dev/null 2>&1
