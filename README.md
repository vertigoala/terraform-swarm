# terraform-swarm

Terraform and ansible playbooks to create a swarm mode cluster in AWS Lightsail.

## Provisioning nodes

Adjust `swarm.tf` for your needs (such as host count and key name) and run:

```sh
aws configure # api auth
terraform apply
```

## Test connectivity

Ansible can work with dynamic inventories. We have provided a custom python script that parses the tfstate:

```sh
ansible -i ./terraform.py -m ping all
```

## Install Docker in Swarm mode

```sh
ansible-playbook install-docker-ce.yaml -i ./terraform.py
```

## Test remote docker connectivity

```sh
. ./setenv.sh
docker node ls
ID                            HOSTNAME            STATUS    (...)
iazywsae37y32h8lx7xgehlmo *   ip-172-26-17-25     Ready     (...)
t7zm8vcqr6pbdwpzgytxhke77     ip-172-26-21-27     Ready     (...)
tafx35xskvnp3b60a832x2mfk     ip-172-26-21-88     Ready     (...)
tjklviszwdgc0i97vcm5mwwpb     ip-172-26-27-170    Ready     (...)
```

## Install Traefik and Portainer

This stack compose deploy Traefik as a front-end LB for all apps. It also installs Portainer for cluster managent UI. DO NOT CHANGE THE STACK NAME "traefik".

Portainer is under a hostname front-end rule ("Host:portainer.example.com"), you can create a hosts file entry for faking it (or change it to any DNS name you want that points to one of the nodes). Just open the browser at "http://portainer.example.com".

```sh
docker stack deploy --compose-file=traefik-portainer-stack.yml traefik
```

## Other tips

To update OS packages on all nodes:

```sh
ansible -i terraform.py all -m apt -a "upgrade=yes update_cache=yes cache_valid_time=86400" --become
```

To install EBS plugin (optional):

```sh
ansible -a "docker plugin install --grant-all-permissions --alias rexray-ebs rexray/ebs EBS_ACCESSKEY=XXXXXX EBS_SECRETKEY=XXXXXXXXXX EBS_REGION=us-east-1" all -i terraform.py
```

To disable and remove the ebs plugin from all nodes:

```sh
ansible -a "docker plugin disable rexray-ebs" all -i terraform.py
ansible -a "docker plugin rm rexray-ebs" all -i terraform.py
```
