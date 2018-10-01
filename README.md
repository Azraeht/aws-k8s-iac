# Create a Bare Metal K8S on AWS

## Getting Started

* Install Ansible

```bash
$ sudo apt-get update
$ sudo apt-get install software-properties-common
$ sudo apt-add-repository ppa:ansible/ansible
$ sudo apt-get update
$ sudo apt-get install ansible
```

* Install Terraform
* Install AWS CLI

```bash
pip install awscli
```

* Configure environment

```bash
~/workspace/k8s-aws/ansible master*
❯ export AWS_ACCESS_KEY_ID='AKIAIQAV5WYG2M432WMQ'

~/workspace/k8s-aws/ansible master*
❯ export AWS_SECRET_ACCESS_KEY='**************************************'

# or

~/workspace/k8s-aws/terraform master*
❯ cat ~/.aws/credentials  
[default]
aws_access_key_id = AKIAIQAV5WYG2M432WMQ
aws_secret_access_key = **************************************
[terraform]
aws_access_key_id = AKIAIW3JS7IMR52CG34Q
aws_secret_access_key = **************************************

```

### Terraform the host

* Prepare 3 hosts (1 master / 2 nodes)

```bash
~/workspace/k8s-aws/*
❯ cd terraform
~/workspace/k8s-aws/terraform*
❯ terraform init
~/workspace/k8s-aws/terraform*
❯ terraform apply -var-file=variables.tfvars
```

### Deploy the cluster

* Retrieve the Public IPs

```bash
~/workspace/k8s-aws master*
❯ aws ec2 describe-instances --query "Reservations[*].Instances[*].{Name:Tags[0].Value,IP:PublicIpAddress}" --output=text
35.180.131.122	controlpane
35.180.156.33	node
35.180.86.140	node
```
* Update `./ansible-kubeadm/inventory`
* Deploy the cluster using Ansible

```bash
~/workspace/k8s-aws/ master*
❯ cd ansible-kubeadm
~/workspace/k8s-aws/ansible-kubeadm master*
❯ ansible-playbook -v site.yml
```