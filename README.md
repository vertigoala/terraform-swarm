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
export SERVERNAME=<manager_node_ip_address>
export DOCKER_HOST=ssh://ubuntu@$SERVERNAME
docker node ls
ID                            HOSTNAME            STATUS    (...)
iazywsae37y32h8lx7xgehlmo *   ip-172-26-17-25     Ready     (...)
t7zm8vcqr6pbdwpzgytxhke77     ip-172-26-21-27     Ready     (...)
tafx35xskvnp3b60a832x2mfk     ip-172-26-21-88     Ready     (...)
tjklviszwdgc0i97vcm5mwwpb     ip-172-26-27-170    Ready     (...)
```

## Install Portainer (optional)

Portainer is a web UI for docker swarm. Just open the browser at "http://<any_cluster_ip_addr>:9000" (open this port in the node firewall).

```sh
curl -L https://downloads.portainer.io/portainer-agent-stack.yml -o portainer-agent-stack.yml
docker stack deploy --compose-file=portainer-agent-stack.yml portainer
```
