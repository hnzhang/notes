
# TODO: understand the following Terms,
* ENI--elastic network interface
* AMI
* CIDR block
* Bastion
* AWS Marketplace 
# Internet Gateway

# Security Goups
to define rules for inbound/outbound network traffic

## limits.
### for regsion
 --default 2,500, max 10,000
 ### per security group,
 * 60 inbound
 * 60 outbound
 ### for Elastic Network Interface(ENI)
 --default 5 security groups
 --max 16 security groups
 
# NAT
Network Address translation
for private subnet
1. outbound tranffic to gain the internet
2. if two networks which have conflicting network addresses, NAT can help to make the addresses aggreeable
## NAT Instances is legacy implementation by EC2 instances.
## NAT Gateways is a managed service which launches redundant instances within the selected AZ.

NAT instances  have to run within a public subnet


# Guacamole Bastion

# Identity and Access Management
## Users
### A user can have  a role directly attached
### A user can have  a policy directly attached
# Groups -- a user can belong to a group.
## 
## Roles -- 
* A role can have many policies attached
* Various AWS resources allow you to attach role directly to them

## Policies
### Managed Policies
for example, AmazonECSFullAccess
### Customer Managed Policies
### Inline Policies

Policy is structured in JSON
{
"Version": "2012-07-09",
"Statement":[{
  "Sid": "Deny-Barcley-S3-Access",
  ...
},{
}
...
]
}

Password policy

Pragamtic Access Keys

MFA--Multi-Factor Authentication

----------------------
|| User Group         |
|| usr1 usr2 ...      |<--Role(s) <--Policies
----------------------

Inline Policy --> | user| <-- Role <-- Policy/Policies

-----------------
| AWS Resources | <---Role(s) <---Policies
-----------------



