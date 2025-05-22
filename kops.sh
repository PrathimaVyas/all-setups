#vim .bashrc
#export PATH=$PATH:/usr/local/bin/
#source .bashrc

yum install docker -y
systemctl start docker

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
wget https://github.com/kubernetes/kops/releases/download/v1.25.0/kops-linux-amd64
chmod +x kops-linux-amd64 kubectl
mv kubectl /usr/local/bin/kubectl
mv kops-linux-amd64 /usr/local/bin/kops

export KOPS_STATE_STORE=s3://prathima.mpv.local
kops create cluster --name prathima.k8s.local --zones us-east-1a,us-east-2a,us-east-3a --master-count=1 --master-size t2.medium --master-volume-size 30 --node-count=2 --node-size t2.micro --node-volume-size 29
kops update cluster --name prathima.k8s.local --yes --admin
