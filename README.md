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


