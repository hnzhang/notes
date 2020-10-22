
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
```
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
```
Password policy

Pragamtic Access Keys

MFA--Multi-Factor Authentication

----------------------
 User Group         |
 usr1 usr2 ...      |<--Role(s) <--Policies
----------------------

Inline Policy --> | user| <-- Role <-- Policy/Policies

-----------------
 AWS Resources | <---Role(s) <---Policies
-----------------

# Amazon Cognito
* Cognito User Pool, User Directory with authentication to IdP(Identity Provider) to grant access to your app
* Cognito Identity Pools, Provide temporary credentials for users to access AWS services
* Cognito Sync, Syncs users data and preferences across all devices

## Web Identify Federation and IdP
* Web Identitfy Federation, to exchange identify and security information between an identity provider(IdP) and an application
* Identity Provider (IdP), a trusted provider of your users identify that lets you use authenticatioe to access other services. They could be: Facebook, Amazon, Google, Twitter, Github, LinkedIn.
  * Type of Identity Providers
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
  * SOA(Start of Authority)
Every domain must have an SOA record. The SOA is a way for Domain Admins to provide information about the domain. eg, how often it is updated, what is the admin's email address, etc.
A Zone file can contian only one SOA Record

  * DNS records
    * A record, Address record
    * CNAME(Canonical Names)
    * NS Records

* Route53 
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
 * EC2 Health Check Type for software or hardware issue
 * ELB Health Check Type for respond. If ELB find the endpoint is not healthy, ELB forwards  this info to ASG, which will terminate the unhealthy instance
* Scaling Policies
 * Target Tracking Scaling Policy. Scaling Out is to add more instances, and Scaling In is to remove instances
 * Simple Scaling Policy. Scaling when the alarm is breached. It is legacy scaling policy, and is not recommended. Scaling Up is to increase the size of the instance.

When a new instance is added, it uses a Launch Configuration, which holds the configuration values for that new Instance. eg. AMI, Instance Type, Role, etc.
Launch Configuration cannot be edited/modified and must be cloned or create a new one. As a result, Launch Configuration must be manually updated in by editing the Auto Scaling  settings.
* Scaling Policies with Steps. 

# ELB - Elastic Load Balancer
ELB can help distribute incoming application traffic cross multiple targets, such as EC2 Instances, Containers, IP addresses, and lambda functions.
ELB is AWS solution for load balancing traffic, and there are 3 types,
1. Application Load Balancer(HTTP or HTTPS, working on Layer 7), ALB
   1. Web Application Firewall(WAF) can be attached to ALB.
   1. ALB is great for web applicaitons.
   1. ALB has Listeners, Rules, and Target Groups to route traffic

1. Network Load Balencer ( work on Layer 4--transport), NLB
   1. It can handle millions of request per second while still maintain extremely low latency.
   1. It can perform cross-zone load balance.
   1. Great for Multiplayer Video Games or when Netowrk performance is critical.
   1. NLB uses Listeners and Target Groups to route traffic.
   1. NHL is for TCP/UDP
1. Classic Load Balancer, CLB(legacy)
   1. use Listners and EC2 instances are directly registered as targets to CLB


## Sticky Sessions on ELB
to bind a user's session to a specific EC2 instance to ensure all the requests from that session are sent to the same instance.
It is typically used with Classic Load Balancer. It can also be enabled for ALB though it can only be set on a Target Group instead of individual EC2 instances.
Cookies are used to remember which EC2 instance.
It is very useful when specific information is only stored locally on a single instance.

## X-Forwarded-For(XFF) Header
If you need the IPv3 address of a user, check the X_Forwarded-For header. The X-Forwarded-For header is a command method for identifying the originating IP address of a client connecting to a web server through an HTTP proxy or a load balancer. See Mozilla website for more info, https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Forwarded-For

## Health Checks from ELB
Instances are monitored by ELB report back Health Checks as InService, or OutofService
Health Checks communicate directly with the instance to determine its state.
ELB doesn't kill/terminate  an unhealthy instance. It will just forward traffic to  healthy instances
For ALB and NHL, the Health Checks are found on the Target Group

## Cross-Zone Load Balancing
This is only available for Classic and Network Load Balancer
Basically, the idea is to have a Load Balancer work on top of a group of child Load Balancers cross multiple Zones. Each Child Load Balancer is corresonding for a Zone. 
When this is enabled, the traffic will be load balanced cross all the instances in all the zones. Otherwise, the traffic is only balanced inside local zone.

## Request Routing -- Request Routing
Request Routing is to apply rules to incoming requeste and then either forward or redirect the traffic based on the fllowing
* Host header
* Http header
* Source IP
* Http head method
* Path
* Query string

ELB cannot go cross regions. You must create one per region.
Amazon Certification Manager SSL can be attached to ELB for SSL

# AWS System Manager
## Session Manager
To manage EC2 instance with SSH through the web.

#Elastic File System(EFS)
Scalable, elastic, cloud-native NFS file system. As a single file system, it can be attached to multiple EC2 instances(the file volume must be in the same VPC). 
No worries about running out of managing disk space. Volumne can scale up to petabyte size storage
It can support thousands of concurrent connections over NFS.
Grow and shrink automatically based on data stored(elastic)
EC2 instances install the NFS v4.1 client to mount the EFS volume
Pricing $0.30/GB/month

# Elastic Block Storage
## What is IOPS?
IOPS stands for Input/Out per second. It is the speed at which non-contiguous reads and writes can be performed on a storage media. high IO = lots of small read and writes

## What is throughput?
The data transfer rate to and from the storage media in megabytes per second

## What is Bandwidth?
Bandwith is the measurement of the total possible speed of data movement along the network

Think of Bandwdith as the Pipe and throughput as the water

## 5 typpes of EBS Storage

|Type | code |Description|
|------|-----|--------|
| General purpose(SSD) | gp2 | for general purpose usage without specific requirement |
| Provisioned IOPS(SSD) |io1 | when you require really fast input & output |
| Throughput Optimized(HDD)| st1 magnetic drive optimized for quick throughput |
| Cold HDD | sc1 | Lowest cost HDD volume for infrequent access workloads
| EBS Magnetic | standard | Previous generation HDD|

## How to move EBS volumes
### From one AZ to another AZ
1. take a snapshot of the volume
1. create an AMI form the snapshot
1. lauch new EC2 instance in desired AZ
### From one region to another
1. Take a snapshot of the volume
1. Create an AMI from the snapshot
1. copy the AMI to another region
1. lauch a new EC2 instance from the copied AMI.

## EBS vs Instance Store Volumes
An EC2 instance can be backed(root device) by an EBS volume or Instance Store Volume

| EBS Volume | Instance Store Volume(Ephemeral)
|---|----|
| A durable , block-level storage device that you can attache to a single EC2 instance | A temp storage type lcoated on disks that a physically attached to a host machine
| EBS volume create from an EBS snapshot |  An Instance Storage Volume is created from a template stored in S3
| * Can start and stop the instances | * Cannot stop instance and can only terminate
| * Daata will persist if you reboot your system | * Data will be lost in case of the instance fails or being terminated
