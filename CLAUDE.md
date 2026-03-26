# netactuate-terraform-bgp — AI Provisioning Context

Terraform provisions VMs and assigns them to a BGP group. It does NOT configure
the BGP daemon — that's Ansible's job (bird2 or frr playbook).

## The Pattern

```
terraform apply → terraform output -raw ansible_inventory > inventory.ini → ansible-playbook -i inventory.ini bgp.yaml
```

## Required Inputs

| Input | Source |
|-------|--------|
| API key | portal.netactuate.com/account/api |
| Contract ID | Portal |
| BGP group ID | NetActuate support |
| Locations | Customer choice |
| Plan | Customer choice |
| SSH public key path | Local machine |

## What to Do

1. `cp terraform.tfvars.example terraform.tfvars` — fill in values
2. `terraform init && terraform apply`
3. `terraform output -raw ansible_inventory > inventory.ini`
4. Hand inventory to bird2 or frr: `ansible-playbook -i inventory.ini bgp.yaml`

## Scope

Terraform handles:
- VM provisioning (netactuate_server)
- SSH key creation (netactuate_sshkey)
- BGP group assignment (netactuate_bgp_sessions)

Ansible handles:
- BGP daemon installation and configuration
- Anycast IP binding
- Sysctl tuning

## Teardown

```bash
terraform destroy
```
