#cloud-config

apt:
  sources:
    docker.list:
      source: deb [arch=amd64] https://download.docker.com/linux/ubuntu $RELEASE stable
      keyid: 9DC858229FC7DD38854AE2D88D81803C0EBFCD88

package_update: true
package_upgrade: true

packages:
  - apt-transport-https
  - ca-certificates
  - curl
  - gnupg-agent
  - software-properties-common
  - docker-ce
  - docker-ce-cli
  - containerd.io
  - unzip

# Enable ipv4 forwarding, required on CIS hardened machines
write_files:
  - path: /etc/sysctl.d/enabled_ipv4_forwarding.conf
    content: |
      net.ipv4.conf.all.forwarding=1
  - path: /etc/ssh/sshd_config
    append: true
    content: |
      ClientAliveInterval 600
      ClientAliveCountMax 0

# create the docker group
groups:
  - docker

# Add default auto created user to docker group
system_info:
  default_user:
    groups: [docker]

runcmd:
  - sudo apt-get remove -y awscli
  - curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-2.17.14.zip" -o "awscliv2.zip"
  - unzip awscliv2.zip
  - sudo ./aws/install
  - rm -rf awscliv2.zip aws
  - curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  - sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
  - rm kubectl
