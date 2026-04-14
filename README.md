# netactuate-terraform-bgp

Terraform module for provisioning BGP-enabled VMs on NetActuate's global edge network.
Creates VMs, assigns them to a BGP group via the API, and outputs a ready-to-use Ansible
inventory.

> **Important:** This repo provisions infrastructure and assigns BGP groups at the API level.
> It does **not** configure the BGP daemon. After `terraform apply`, use
> [netactuate-ansible-bgp-bird2](https://github.com/netactuate/netactuate-ansible-bgp-bird2) or
> [netactuate-ansible-bgp-frr](https://github.com/netactuate/netactuate-ansible-bgp-frr) to
> configure BIRD2 or FRR on the provisioned nodes.

## Prerequisites

- **Terraform 1.0+** or **OpenTofu**
- NetActuate API key, contract ID, and BGP group ID
- An SSH public key

### Install Terraform

**macOS:** `brew install terraform`
**Linux:** Use [tfenv](https://github.com/tfutils/tfenv) or direct binary
**Windows:** `winget install Hashicorp.Terraform` or WSL2

### NetActuate Terraform Provider

The NetActuate Terraform provider is installed automatically when you run `terraform init`.
It is downloaded from the Terraform Registry and shared across all modules on your system.
Each module in this collection is an independent, self-contained project with its own
`main.tf`, `variables.tf`, and `outputs.tf` — you can use any module on its own without
the others.

## Configuration

```bash
cp terraform.tfvars.example terraform.tfvars
```

| Variable | Type | Description | Example |
|----------|------|-------------|---------|
| `api_key` | string | NetActuate API key (sensitive) | `"abc123..."` |
| `contract_id` | string | Billing contract ID | `"12345"` |
| `bgp_group_id` | string | BGP group ID | `"67890"` |
| `locations` | list(string) | PoP codes | `["LAX", "FRA", "SIN"]` |
| `vm_count_per_location` | number | VMs per location | `1` |
| `plan` | string | VM plan | `"VR1x1x25"` |
| `os_image` | string | OS image | `"Ubuntu 24.04 LTS (20240423)"` |
| `hostname_prefix` | string | Hostname prefix | `"myapp"` |
| `domain` | string | Domain suffix | `"example.com"` |
| `ssh_public_key_path` | string | Path to SSH pub key | `"~/.ssh/id_ed25519.pub"` |

## Usage

```bash
terraform init
terraform plan
terraform apply
```

## Handoff to Ansible

After `terraform apply`, generate the inventory and hand off to the BGP playbook:

```bash
# Save inventory
terraform output -raw ansible_inventory > inventory.ini

# Configure BGP with BIRD2
cd /path/to/netactuate-ansible-bgp-bird2
ansible-playbook -i /path/to/inventory.ini bgp.yaml

# Or with FRR
cd /path/to/netactuate-ansible-bgp-frr
ansible-playbook -i /path/to/inventory.ini bgp.yaml
```

The inventory includes `location` and `bgp_enabled=True` per host, so the Ansible
playbooks work without modification.

## Teardown

```bash
terraform destroy
```

## AI-Assisted

```
Provision BGP-enabled NetActuate VMs with Terraform:

- API Key: <KEY>
- Contract ID: <ID>
- BGP Group ID: <ID>
- Locations: LAX, FRA, SIN
- Plan: VR1x1x25

Please terraform apply, then hand off the inventory to the bird2 ansible playbook.
```

## Need Help?

- NetActuate support: support@netactuate.com
- [Terraform NetActuate Provider](https://registry.terraform.io/providers/netactuate/netactuate/latest)
