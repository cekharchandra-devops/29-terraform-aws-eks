#!/bin/bash

echo "Running as user: $(whoami)"
# resize the disk for / and /var
lsblk
sudo growpart /dev/nvme0n1 4
sudo lvextend -l +50%FREE /dev/RootVG/rootVol
if [ $? -eq 0 ]; then
  echo "Successfully extended /dev/RootVG/rootVol"
else
  echo "Failed to extend /dev/RootVG/rootVol"
fi
sudo lvextend -l +50%FREE /dev/RootVG/varVol
sudo xfs_growfs /
sudo xfs_growfs /var

# install docker

yum install -y yum-utils
yum-config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo
yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
systemctl start docker
systemctl enable docker
usermod -aG docker ec2-user

# install kubectl

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
chmod +x kubectl
mv ./kubectl /usr/local/bin/kubectl
kubectl version --client

# install kubens and kubectx

curl -LO https://raw.githubusercontent.com/ahmetb/kubectx/master/kubens
curl -LO https://raw.githubusercontent.com/ahmetb/kubectx/master/kubectx
chmod +x kubens kubectx
sudo mv kubens kubectx /usr/local/bin


# isntall eksctl

# for ARM systems, set ARCH to: `arm64`, `armv6` or `armv7`
ARCH=amd64
PLATFORM=$(uname -s)_$ARCH

curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz"

# (Optional) Verify checksum
curl -sL "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_checksums.txt" | grep $PLATFORM | sha256sum --check

tar -xzf eksctl_$PLATFORM.tar.gz -C /tmp && rm eksctl_$PLATFORM.tar.gz

sudo mv /tmp/eksctl /usr/local/bin

echo " $(eksctl version)"

# kubens and kubectx

curl -LO https://raw.githubusercontent.com/ahmetb/kubectx/master/kubens
curl -LO https://raw.githubusercontent.com/ahmetb/kubectx/master/kubectx
chmod +x kubens kubectx
sudo mv kubens kubectx /usr/local/bin


  if [ -z "${aws_access_key_id}" ]; then
  echo "Error: aws_access_key_id is not set"
  exit 1
fi

if [ -z "${aws_secret_access_key}" ]; then
  echo "Error: aws_secret_access_key is not set"
  exit 1
fi

# Helm
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh



sudo -i -u ec2-user bash << EOF
  aws configure set aws_access_key_id ${aws_access_key_id}
  aws configure set aws_secret_access_key ${aws_secret_access_key}
  aws configure set default.region ${aws_region}
EOF