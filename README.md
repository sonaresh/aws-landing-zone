# AWS Enterprise Landing Zone -- Terraform Implementation

------------------------------------------------------------------------

# Overview

This repository implements a modular, enterprise-grade AWS Landing Zone
using Terraform.

The architecture aligns with AWS Control Tower and follows a layered
security-first design model.

This implementation demonstrates:

-   Governance guardrails via SCP
-   Identity boundaries and least privilege enforcement
-   Organization security baseline
-   Regional isolation
-   Secure workload onboarding
-   Optional enterprise security services
-   Modular state management strategy

------------------------------------------------------------------------

# Architecture Overview

``` mermaid
flowchart TB

  subgraph AWS Organization
    Root[Root]
    InfraOU[Infrastructure OU]
    SecurityOU[Security OU]
    WorkloadsOU[Workloads OU]
    SandboxOU[Sandbox OU]
  end

  subgraph Governance Layer
    SCP1[SCP - IAM Guardrails]
    SCP2[SCP - Encryption Enforcement]
    SCP3[SCP - Region Allowlist]
    SCP4[SCP - Logging Protection]
    SCP5[SCP - Quarantine Pattern]
  end

  subgraph Identity Layer
    Boundary[Permission Boundaries]
    Breakglass[Break-glass Role]
    AuditRole[Audit Role]
  end

  subgraph Regional Baseline
    USE1[Baseline - us-east-1]
    USE2[Baseline - us-east-2]
  end

  subgraph Workload Integration
    S3[Encrypted S3 Bucket]
    AppRole[Application IAM Role]
  end

  subgraph Enterprise Advanced
    SecLake[Security Lake Optional]
    FMS[Firewall Manager Optional]
  end

  Root --> SCP1
  Root --> SCP2
  Root --> SCP3
  Root --> SCP4
  Root --> SCP5

  SCP1 --> InfraOU
  SCP1 --> SecurityOU
  SCP1 --> WorkloadsOU
  SCP1 --> SandboxOU

  Boundary --> WorkloadsOU
  USE1 --> WorkloadsOU
  USE2 --> WorkloadsOU
  AppRole --> WorkloadsOU

  SecLake --> Root
  FMS --> Root
```

------------------------------------------------------------------------

# Repository Structure

aws-landing-zone/ - 01-governance/ - 02-identity/ -
03-security-baseline/ - 04-backup-policies/ - 06-regional/ -
us-east-1/ - us-east-2/ - 07-workload-integration/ -
09-enterprise-advanced/ - env/ - lab.auto.tfvars

------------------------------------------------------------------------

# Execution Order

1.  01-governance\
2.  02-identity\
3.  03-security-baseline\
4.  04-backup-policies\
5.  06-regional (per region)\
6.  07-workload-integration\
7.  09-enterprise-advanced (optional)

------------------------------------------------------------------------

# How to Deploy

Step 1 -- Authenticate

aws sso login --profile aws_lab

Step 2 -- Navigate to module

cd 01-governance

Step 3 -- Initialize

terraform init

Step 4 -- Plan

terraform plan -var-file="../env/lab.auto.tfvars"

Step 5 -- Apply

terraform apply -var-file="../env/lab.auto.tfvars"

------------------------------------------------------------------------

# State Management Strategy

Each module maintains independent state.

## Lab Mode (Current)

-   Local terraform.tfstate per module
-   Safe for experimentation
-   No shared global state

## Enterprise Mode (Recommended)

Remote backend per module:

s3://lz-terraform-state/ - governance/terraform.tfstate -
identity/terraform.tfstate - security-baseline/terraform.tfstate -
backup/terraform.tfstate - regional/us-east-1/terraform.tfstate -
regional/us-east-2/terraform.tfstate - workload/terraform.tfstate -
enterprise-advanced/terraform.tfstate

DynamoDB table used for state locking.

------------------------------------------------------------------------

# State Isolation Diagram

``` mermaid
flowchart LR

  Dev[Engineer]
  Module1[Governance State]
  Module2[Identity State]
  Module3[Regional State]
  S3[S3 Backend]
  DDB[DynamoDB Lock Table]

  Dev --> Module1
  Dev --> Module2
  Dev --> Module3

  Module1 --> S3
  Module2 --> S3
  Module3 --> S3

  S3 --> DDB
```

------------------------------------------------------------------------

# Cost Control

Designed to stay within lab budget:

Low cost resources: - IAM - SCP - S3 minimal storage - CloudWatch short
retention

Disabled by default: - Security Lake ingestion - Firewall Manager
policies - High-volume data logging

------------------------------------------------------------------------

# Design Principles

-   Least privilege enforced
-   OU-aware governance
-   No hardcoded secrets
-   Modular Terraform layers
-   Region isolation
-   Feature toggles for expensive services
-   State isolation per layer

------------------------------------------------------------------------

# CI/CD Recommendation

``` mermaid
flowchart LR
  Dev --> GitCommit
  GitCommit --> CIPlan
  CIPlan --> Approval
  Approval --> CIApply
  CIApply --> AWS
```

Use CI/CD for: - Plan approval - Controlled apply - Remote backend
enforcement - Audit logging

------------------------------------------------------------------------

# Production Enhancements

Future enterprise improvements:

-   Centralized KMS module
-   Organization CloudTrail (management + data events)
-   GuardDuty delegated admin
-   Security Hub delegated admin
-   Network baseline module
-   Transit Gateway integration
-   Account vending automation

------------------------------------------------------------------------

# Conclusion

This landing zone demonstrates:

Governance\
Identity control\
Security baseline\
Regional architecture\
Workload onboarding\
Enterprise-grade optional services

Structured for real-world enterprise deployment patterns.
