## Repository Status

This repository is intended for educational and research purposes only.

The Terraform configuration contained here was developed as part of the AWS Cloud Forensics Research Lab to better understand Terraform syntax, infrastructure-as-code concepts, and their application to cloud forensics and DFIR research.

At the time of publication, this configuration has **not been deployed** as a complete production or research environment. Consequently, the repository should be considered a reference implementation rather than a validated deployment.

Some configuration values have been intentionally generalized, omitted, or sanitized to prevent the disclosure of sensitive information, including but not limited to account identifiers, credentials, environment-specific parameters, and other security-relevant details.

The examples provided are intended to illustrate the design of the laboratory infrastructure and the relationship between Terraform-defined resources and AWS cloud environments. They should be reviewed, adapted, and validated before being used in any real AWS account.

Researchers and practitioners are encouraged to customize the infrastructure according to their own experimental objectives, security requirements, and AWS best practices.


# AWS Cloud Forensics Research Lab - Terraform Deployment

## Purpose

This directory contains the Terraform configuration used to automate the deployment of the AWS environment designed for cloud forensics research and Digital Forensics and Incident Response (DFIR) experimentation in the context of my project with Mitacs 2026.

The main objective of this infrastructure-as-code implementation is to provide a reproducible laboratory environment where cloud forensic concepts can be explored, including:

* Cloud resource deployment and configuration.
* Evidence collection and preservation.
* Security monitoring and detection capabilities.
* IAM permission analysis.
* Incident investigation workflows.
* The relationship between declared infrastructure (Terraform) and the actual cloud environment.

Terraform is used to automate the creation of the laboratory components to improve consistency, repeatability, and documentation of the experimental environment.

---

# Design Considerations

## Terraform Managed Infrastructure

The resources defined in this project represent the intended state of the laboratory environment.

However, it is important to consider that Terraform state does not necessarily represent every resource that exists within an AWS account. Some AWS components are created automatically by AWS or managed externally and may not appear as independent Terraform resources.

For forensic purposes, the actual AWS environment should always be considered alongside Terraform state, CloudTrail logs, and service-specific logging mechanisms.

---

# AWS-Managed and Implicit Resources

Some resources may exist within the AWS environment without being explicitly managed by Terraform.

These resources may not be removed automatically by `terraform destroy` because they are either created outside Terraform or managed implicitly by AWS.

Current examples include:

## Default Route Tables

When a VPC is created, AWS automatically creates a main route table.

If a subnet does not have an explicitly associated route table, it uses this main route table.

Example:

```
Destination      Target
10.x.x.x/16      local
```

The laboratory intentionally leaves the private workload subnet using the AWS-created main route table instead of creating an additional Terraform-managed private route table.

---

## Default Network ACLs

AWS automatically creates a default Network ACL for each VPC.

Unless custom Network ACLs are created, subnets will continue using the default ACL.

---

## Default Security Groups

AWS automatically creates a default security group for each VPC.

Although this laboratory defines specific security groups for workloads, the default security group remains part of the AWS environment.

---

## Service-Linked Roles

AWS services such as GuardDuty and Security Hub may create service-linked IAM roles automatically when enabled.

These roles are managed by AWS and may not be removed as regular Terraform-managed resources.

---

# Administrative User Naming

The Terraform administrator user is named:

```
admin_terraform
```

This naming convention is intentional.

The user was originally created manually in the AWS account before Terraform automation was implemented. To maintain consistency between the existing AWS environment and the Terraform configuration, the same naming convention is preserved.

Although the name includes "terraform", this user represents the administrative identity used to deploy and manage the laboratory infrastructure.

---

# IAM Policies and Scenario Dependency

The IAM policies included in this project are designed according to the requirements of the initial laboratory scenario:

**Scenario 1 - Privilege Escalation**

Therefore, the permissions assigned to users represent the expected access model for that specific investigation scenario.

The policies should not be considered universal or final.

Depending on the research objective, the following elements may require modification:

* User permissions.
* IAM policies.
* Access levels.
* Security service permissions.
* Evidence acquisition capabilities.

Researchers deploying this laboratory are encouraged to modify IAM permissions according to their own scenarios.

---

# Terraform State and Infrastructure Changes

Terraform manages infrastructure based on the expected state stored in the Terraform configuration and state file.

If resources are manually modified after deployment, Terraform may detect differences between:

* The Terraform configuration.
* The Terraform state.
* The actual AWS environment.

Before destroying the laboratory environment using:

```
terraform destroy
```

the environment should be returned to the original state created by Terraform.

Otherwise, Terraform may fail to delete resources due to:

* Missing dependencies.
* Manual modifications.
* Resources created outside Terraform.
* Changed permissions.
* Modified configurations.

For experimental changes, it is recommended to either:

* Document modifications and update Terraform accordingly.
* Revert manual changes before destruction.

---

# Credentials and Sensitive Information

This laboratory creates IAM users with programmatic access through AWS access keys.

Because Terraform manages these resources, sensitive information such as access keys may exist within the Terraform state file.

The Terraform state file must therefore be protected.

Recommended practices:

* Do not commit Terraform state files to public repositories.
* Use `.gitignore` to exclude sensitive Terraform files.
* Use remote state storage with encryption when deploying in shared environments.
* Rotate or delete laboratory credentials after experimentation.

This configuration is intended for research and educational environments, not production deployments.

---

# Security Services Dependency

Some IAM permissions included in this project assume the use of AWS security services:

* Amazon GuardDuty.
* AWS Security Hub.

These permissions exist because they are required for the initial forensic scenarios implemented in the laboratory.

However, enabling these services is not considered a strict requirement of the Terraform deployment.

They may be:

* Enabled manually through the AWS console.
* Enabled through additional Terraform resources.
* Disabled or replaced depending on the research objective.

If these services are not enabled, some permissions granted to the forensic analyst user will simply remain unused.

---

# Reproducibility and Research Scope

This Terraform implementation prioritizes:

* Reproducibility.
* Transparency.
* Controlled experimentation.
* Documentation of infrastructure changes.

The laboratory should be considered a research environment where infrastructure decisions, IAM permissions, logging configurations, and security services can be modified to evaluate their impact on cloud forensic investigations.
