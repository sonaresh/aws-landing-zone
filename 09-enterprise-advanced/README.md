# 09-enterprise-advanced

This stack contains **optional** enterprise-grade services that can introduce cost.
Keep feature toggles OFF for lab work until you are ready.

## Features
- **AWS Security Lake** (optional, can be expensive)
- **AWS Firewall Manager** (setup only; policies optional)

## Prerequisites
- Must be executed from the **Management account** context (Control Tower management account).
- `security_admin_account_id` should point to the account acting as Security Admin.

## Usage

```powershell
cd 09-enterprise-advanced
terraform init
terraform plan  -var-file="..\env\lab.auto.tfvars"
terraform apply -var-file="..\env\lab.auto.tfvars"

Recommended Lab Approach

Start with everything disabled:

enable_security_lake = false

enable_firewall_manager = false

Enable one service at a time and validate cost/behavior.

Cost Notes

Security Lake charges for data ingestion and storage. If you enable many sources, cost increases.

Firewall Manager itself is not usually the cost driver, but managed policies and underlying resources can be.


# Recommended Lab Approach

- Start with everything disabled:
    enable_security_lake = false
    enable_firewall_manager = false
- Enable one service at a time and validate cost/behavior.

# Cost Notes

- Security Lake charges for data ingestion and storage. If you enable many sources, cost increases.
- Firewall Manager itself is not usually the cost driver, but managed policies and underlying resources can be.


---

# How to enable later (in env/lab.auto.tfvars)

Add:

```hcl
enable_security_lake = false
enable_firewall_manager = false
enable_fms_delegated_admin = false
enable_security_lake_delegated_admin = false