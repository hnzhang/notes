
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

# Amazon Cognito
* Cognito User Pool, User Directory with authentication to IdP(Identity Provider) to grant access to your app
* Cognito Identity Pools, Provide temporary credentials for users to access AWS services
* Cognito Sync, Syncs users data and preferences across all devices

## Web Identify Federation and IdP
* Web Identitfy Federation, to exchange identify and security information between an identity provider(IdP) and an application
* Identity Provider (IdP), a trusted provider of your users identify that lets you use authenticatioe to access other services. They could be: Facebook, Amazon, Google, Twitter, Github, LinkedIn.

** Type of Identity Providers
The tech that behind the Identity Providers. Most time it is Security Assertion Markup Language(SAML), or SSO(Single Sign ON), or OpenID Connection(OIDC) OAuth. OAuth most time is for Social media account authentication.

* OIDC is a type of Identity Provider which uses OAuth
* SAML is a type of Identity Provider wich is used for Single Sign-On

* AWS CLI(command line interface)
The CLI is installed used a python script

* AWS SDK
Available in multiple languages C++/ GO/ JAVA/JS/.NET/NodeJS/PHP/Python/Ruby

Pragmatic Access Keys are needed for authentications used in code. Both of them are collectively known as AWS Credentials
* Access Key ID
* Secrete Access Key

These are stored in  your user home. eg. (~/.aws/credentials). the credentials files allow to manage multiple credientials(called profiles).

* DNS
** SOA(Start of Authority)
Every domain must have an SOA record. The SOA is a way for Domain Admins to provide information about the domain. eg, how often it is updated, what is the admin's email address, etc.
A Zone file can contian only one SOA Record

** DNS records
*** A record, Address record
*** CNAME(Canonical Names)
*** NS Records

** Route53 
Route53 is the DNS Service from AWS

# EC2
 _EC2 Instance profile can have an IAM role attached to avoid embedding AWS credentials_
 ## EC2 Placement groups
* Cluster, to pack EC2 instances closely together inside an AZ. It has very low latency network performance. It is well suitable for high performance computing applications. Also Cluster cannot be cross multiple AZ.

* Partition. each partition do not share the underlying hardware with each other. It is well suitable for large distributed and replicated workload(Hadoop, Cassandra, Kalfka, etc)

* Spread. Each instance is placed on a different rack. When critical instancs shoul dbe kept separate from each other, Spread should be used. You can spread a max of 7 instances. Spreads can be cross multiple AZ.

## UserData
UserData can be provided to an EC2 instance. UserData is a script, which will be automatically run when the EC2 instance is launched.
## MetaData
From within an instance of EC2, a special URL endpoint can be accessed(http://169.254.169.254/latest/meta-data) to get information about the instance(like public-ipv4, ami-id, instance-type, mac, hostname, etc). these can work together with UserData for advanced AWS staging automation
## EC2 Pricing Models
## On-Demand Least Commitment, charted by hours or by minutes.
## Spot Biggest Saving upto 90%
## Reserved Instances(RI) Beset Long-Term upto 75%
## Dedicated Most Expensive Model

## AMI 
Amazon Machine Image(AMI) provides the info required to launch an instance.
You can turn your EC2 instances into AMIs

AMI can hold the following info,
* a template for the root volume for the instance(EBS snapshot or instance store template) eg. an operating system, an application server, and applications.
* Launch permissions that control which AWS accounts can use the AMI to launch instances
* A block device mapping that specifies the volumes to attach to the instance when it is launched.

Using System Management Automation, AMIs can be routinely patched with security updates.
AMIs are used with LaunConfigurations. When you want to roll out updates to multiple instances you mkae a copy of your LaunchConfiguration with the new AMI

AMI is region specific. You you need an AMI which is availble in another region, you can copy the AMI into destination region.
# AWS Marketplace

# ECS Auto Scaling Group
* Capacity Setting, min instances, max instances, ideal instances
* Health Check Replacement, 
** EC2 Health Check Type for software or hardware issue
** ELB Health Check Type for respond. If ELB find the endpoint is not healthy, ELB forwards  this info to ASG, which will terminate the unhealthy instance
* Scaling Policies
** Target Tracking Scaling Policy. Scaling Out is to add more instances, and Scaling In is to remove instances
** Simple Scaling Policy. Scaling when the alarm is breached. It is legacy scaling policy, and is not recommended. Scaling Up is to increase the size of the instance.

When a new instance is added, it uses a Launch Configuration, which holds the configuration values for that new Instance. eg. AMI, Instance Type, Role, etc.
Launch Configuration cannot be edited/modified and must be cloned or create a new one. As a result, Launch Configuration must be manually updated in by editing the Auto Scaling  settings.
** Scaling Policies with Steps. 
