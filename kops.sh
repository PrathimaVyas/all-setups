#vim .bashrc
#export PATH=$PATH:/usr/local/bin/
#source .bashrc

yum install docker -y
systemctl start docker

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

curl -Lo kops https://github.com/kubernetes/kops/releases/download/$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)/kops-linux-amd64
chmod +x kops
sudo mv kops /usr/local/bin/kops

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
mv kubectl /usr/local/bin

export KOPS_STATE_STORE=s3://prathima.mpv.k8s
kops create cluster --name prathima.k8s.local --zones  us-east-1a,us-east-1b,us-east-1c --master-size t2.medium --master-count 1 --master-volume-size 30 --node-size t2.micro --node-count 2 --node-volume-size 29
kops update cluster --name prathima.k8s.local --yes --admin
