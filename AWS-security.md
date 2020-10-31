With cloud technologies, how to protect data, systems, and assets in the way that can improve your security posture.

# Design Principles
* Enable **Traceability**
* Implement a string **identity foundation**
* Apply security **at all layers**
* **Automate security** best practices
* **Protect data** in transit and at rest
* Keep **people** away from data
* **Prepare** for security events.

# AWS Account Management and Separation
Account level separation
* not good ideas to have accounts mirror your organization's reporting structure.
* zero trust container
* not using root user.

 AWS Organizations help centrally manage accounts.
 * accounts could be grouped into organization units
 * use Service Control Policies(SCPs) to apply permission guardrails at the Organization, organization unit, or account level.
 * AWS Control Tower offers
  * Simplfied way to setup and govern multiple accounts
  * automates the setup of account in AWS Organizations.
  * automates provisioning
  * applies guardrails
  * dashboard
 AWS CloudTtrail--logging of all actions performed across your organization
 AWS Config--audit workloads for compliance
 AWS CloudFormation StackSets--centrally manage AWS CloudFormation stacks.

# AWS IAM Role

# AWS Security Hub
