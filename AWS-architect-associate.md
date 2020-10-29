
# TODO: understand the following Terms,
* ENI--elastic network interface
* AMI
* CIDR block
* Bastion
* AWS Marketplace 
* Signed URL
* Signed Cookie
* Key Management Service multi-tenant HSM
* CloudHSM single-tenant HSM
* Multimaster for Dynamo DB


# Internet Gateway

# Security Goups
to define rules for inbound/outbound network traffic

## limits.
### for regsion
 * default 2,500, max 10,000
 ### per security group,
 * 60 inbound
 * 60 outbound
 ### for Elastic Network Interface(ENI)
 * default 5 security groups
 * max 16 security groups
 
# NAT
Network Address translation
for private subnet
1. outbound tranffic to gain the internet
1. if two networks which have conflicting network addresses, NAT can help to make the addresses aggreeable
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
```json
{
"Version": "2012-07-09",
"Statement":[{
  "Sid": "Deny-Barcley-S3-Access",
},{
}
]
}
```
Password policy

Pragamtic Access Keys

MFA--Multi-Factor Authentication


 User Group         |
 usr1 usr2 ...      | <--Role(s) <--Policies
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
| Throughput Optimized(HDD)| st1 | magnetic drive optimized for quick throughput |
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

EBS is a virtual hard disk. Snapshots are a point-in-time copy of that disk existing on S3.

# CloudFront 
Content Distribution Network
* A distributio is a collection of Edge Locations with a specified Origin
* the Origin could be EC2, ELB, Route53, or S3 bucket
* There are two types of distrutions,
1. Web(for static content of websites)
1. RTMP(Real Time Message Protocal) for streaming media

## Configuration on CloudFront
* Behaviors -- to redirect HTTPs, restrict HTTP, restrick Viewer Access, Set TTLs
* Invalidations -- to manually invalidate cache on specific files via invalidations
* Error Pages -- to serve up custom error pages, such as 404.
* Restrictions -- for example, Geo Restrictions can be used to specify whitelist or blacklist for specific countries

## Lambda@Edge
Lambda@Edge functions can be used to override the behavior of request and respond
$ types of Lambda@Edge
1. View Request --when CloudFront receives a requeset from a viewer
1. Origin Request -- before CloudFront forward a request to the origin
1. Origin Response -- When CloudFront receives a response from the origin
1. View Response -- Before the CloudFront forward the response to the view

Viewer --> View Request (λ) -> CloudFront --> Origin Requset (λ) --> Origin --> Origin Response (λ) --> CloudFront -> Viewer Response (λ) -->Viewer

* Origin Identity Access(OAI) is used to access private S3 buckets

#RDS Relational Database Service
A managed Relational Database service. Support multiple SQL engines. easy to scale, backup and secure

Engines,
1. Amazon Aurora
1. MySQL
1. MariaDB -community-developed, commercially supported fork of MySQL
1. PostgreSQL
1. Oracle
1. Microsoft SQL Server

## RDS Encryption
Encryption can be turned on for all RDS engines. some old versions may not support encryption
It will encrypt the automated backups, snapshots, and read replicas
Encryption is handled by AWS Key Management Service(KMS)
 
## RDS Backup
### automated backups 
1. choose a Retention Period between 1 and 35 days
1. Store transaction log throughout the day
1. Automated backups are enabled by default
1. All data is stored inside S3
1. There is no additional chage for backup storage
1. You define your backup window
1. Storeage I/O may be suspended during backup
### Manual Sanpshots
* Taken manually by the user
* Backups persist even if you delete the original RDS instance

## Restore Backup
When recovering, AWS takes the most recent daily backup, and apply transaction log data relevant to that day. This allow point-in-time recoery down to a second inside the relenttion period.
Backup data is never restored on top of an existing instance. It always creates a new instance, which will have a new DNS endpoint.

### RDS to multiple AZ (Master and Save)
This is to ensure database service remain available if another AZ become unavailable.
Master and Slave live in different AZ, and Slave just standby and sync with the Master. When the master gets inavailable, the Automatic Failover Protection will happen, and the Slave will be promoted as a Master.

Only Database Engine on primary instance is active. That means it cannot be used as database service.

Automated backups are taken from standby/Slave。
Database Engine upgrade happens on primary instance

Replication from the Master to the Slave is synchronous

### RDS Read Replicas
Read-Replicas can be created so that mulitple copies of the database get available. These copies are read-only(no writes), and intended to alleviate the workload of your primary database to improve performace

Automatic Backups must be enabled to use Read Replica. That is how Read Replicas are created. Asyc replication happens between the primary RDS instance and the replicas.
You can have max 5 Replica per primary database server, and each replica has its own DNS endpoint

Replicas could be in 
1. Multi-AZ
1. Another Region
1. Replicas of other read Replicas

Replicas can be promoted to their own database, but this will break replication.
No Automatic failover is available for replicas if the primary copy fails. Manual update of urls has to be done to point at copy
Database engine upgrade is independant from the source instance.

Free Performance Insight to check the performance graph.

## RDS Serverless
much cheaper database solution, especially with low traffic volume. For example during project development.
you can use cloud9 to manage it

RDS instances are managed by AWS. Therefore, you cannot SSH into the VM running the databases.


# Aurora
Fully managed PostgreSQL or MySQL compatible database designed by default to scale and fine-tuned to be really fast
Aurora MySQL is 5x better than traditional MySQL
Aurora PostgreSQL is 3x better than tranditional PostgreSQL
1/10th the costs of other solutions offering similar performance and availability

## Scalability
Start with 10G storage, and scale in 10G increments up to 64TB
Storage is auto scaling
Computing resources can scale all the way up to 32 vCPUs and 244GB memory
## Availability
A minimum 3 AZs, and each contains 2 copies of your data at all the time. That means 6 copies. Losing up to 2 copies of your data without affecting write availability
Losing up to 3 copies of your data without affecting read availability

## Fault Tolerance and Durability
Backup and Failover is handled automatically
Storage is self-healing, in that data blocks and disks are continuously scanned for errors and repaired automatically.

## Aurora can run serverless
Idea for infrequent usage of database

Aurora is allowed up to 15 Aurora Replicas

# Amazon Redshift
Redshift is fully managed Petabyte-size Data Warehouse. it analyze(by running complex SQL queries) on massive amounts of data Columnar Store database

## What is  Data Warehouse
* What is  a Database Transaction?
A Transaction symbolize a unit of work performed within  a database management system.(for example, reads and writes)

| Database | Data Warehouse |
|---|---|
|Online Transaction Processing(OLTP) | Online Analytical Processing(OLAP) |
|tp store current transactions| to store large quantities of history data |
|to enable *fast accesss to specific transactions* | to enable fast, complex queries across all the data |
|eg, add items to your shoping list, single source| Generating reports, Multiple Sources |
| Short transactions with emphasis on writes | long transactions with emphasis on reades|


Use Case of Redshift
continuous data copied from 
1. EMR
1. S3
1. DynamoDB

Data are used to power a custom Business Intelligence tool.

A 3rd-party library(like JDBC, ODBC, etc) can be used to connect and query from Redshift for data

Columnar Store is the primary reason Redshift can perform very well.
## Configurations of Redshift
* Single Node 
The node comes in sizes of 160 GB. You can launch a single node to get started with Redshift
* Multi-Node
You can launch a cluster of nodes with Multi-Node mode
* Lead Node --to manage client connections and receive queries
* Compute Node -- to store data and performs queries up to 128 compute nodes.

### Node type regarding EC2
the smalleset is dc2.large
* dc is for Dense Compute. best for high performance, but they have less storage
* ds is for Dense Storage. This is to create clusters in which you have a lot of data.

Redshift uses multiple compression technologies to achieve significant compression relative to tranditional relational data stores
Similar data are stored sequentially on disk
It does not require indexes or materialized views, which saves a lot of space compared to traditional systems.
When it loads data to an empty table, data is sampled and the most appropriate compression scheme is selected automatically

## Redshift Processing
Redshift uses Masive Parallel Processing(MPP).
Automatically distributes data and query loads across all nodes
It lets you easily add new nodes to your data warehouse while still maintaining fast query performance

## Backups
Backups are enabled by default with 1 day retention peroid. Retention peroid can be modified up to 35 days.
Redshift always attempts to maintain at least 3 copies of your data,
* the original copy
* replica on the compute nodes
* backup copy in S3
Snapshots can be asynchronously replicated into S3 in a different region

## Billing
Compute Node Hours
* The total number of hours across all nodes in the billing period
* Billed for i unit per hour, per node
* Not charged for leadeer node hours, only compute notes incur changes
Backup
* backups are stored in S3 and you are billed the S3 storage fees
Data Transfer
* Billed for data transfer into with ODBC/JDBC
* Billed for data transfer cross regions

## Redshift availability
Redshift is single-AZ. To run in multi-AZ you whould have to run multiple Redshift Clusters in different AZ with the same inputs. Snapshots can be saved into different AZ.

# DynamoDB
DynamoDB is a key-value and document database(NoSQL) which can guarantee consistent reads adn writes at any scales.
Features
* Fully managed
* Multiregion
* Multimaster
* Durable Database
* Built-in Security
* Backup and restore
* In-Memory caching
For reads, it provides
* Eventual Consistent Reads(Default). In this mode, data is returned immediately but data can be inconsistent. Copies of data will be generally consistent in 1 sec.
* Strongly Consistent Reads. In this mode, data return will wait until data in consistent. Data will never be inconsistent but latency will be higher. Copies of data will be consistent with a guarantee of 1 sec.

Provisoned Capacity can be customized
All data are stored on SSD storage and spread across 3 different regions.

Terms in DynamoDB
Row is called _ITEM_
column is called _attribute_
Primary Key consists of Partition Key and Sort Key

# AWS CloudFormation
CloudFormation is a templeting language that defines AWS resources to be provided. Automating the creation of resource via code.
It is to implement the idea of *Infrastructure as Code* (loC)
## What is loC
loC is the process of managing and provisioning computer data centers through machine-readable definition files(like YAML, JSON files) rather than physical hardware configuration or interactive configuration tools(no manual configuration!)

### Use Case with a MineCraft Server
People pay a monthly subscription and AWS runs a MineCraft server. They choose where they want and what size of the server they want to run. These inputs can be taken by an AWS lambda to create a new Cloudformation stack. Another Lambda can send people the email of their new Minecraft Server IP address and details.

## Formats
1. JSON, JSON just came first. For some edge cases, JSON has to be used.
1. YAML, YAML is more concise comparing with JSON by skipping curvy brackets.

NestedStacks help you break up your CloudFormation template into smaller reusable templates that can be composed into large templates

## AWS Quick Starts
AWS Quick Starts is a great place to learn CloudFormation. It has a collection of pre-built CloudFormation templates. A lot of diagrams can help understand AWS

# CloudWatch
AWS CloudWatch is a monitoring solution for your AWS resources with a collection of monitoring tools,
* CloudWatch Logs
** A log group is a collection of logs. Log files must belong to a log  group. A log in a log group is called log stream. By Default, Logs are kept indefinitely and never expire. Most AWS Services are integrated with CloudWatch Logs. Logging of services sometimes needs to be turned on or requires the IAM Permissions to write the CloudWatch Logs
* CloudWatch Metrics. Metrics are built on top of logs to represent a time-ordered set of data points. CloudWatch comes with many predefined metrics.
* CloudWatch Events. Event Source Trigger an event based on a condition or on schedule.
* CloudWatch Alarms
* CloudWatch Dashboards

## Custom Metrics and High Resolution Metrics
Using AWS CLI or SDK you can create and publish yuor own custom metrics.
High res metrics lets you track under 1 minute down to 1 sec. With High Resolution you can track at,
* 1 sec
 * 5 secs
 * 10 secs
 * 30 secs
 * multiple of 60 secs
 
 example to create custom metrics,
 aws cloudWatch put-metrics-data --metric-name Enterprise-D --namespace Startleet --unit Bytes --value 231434333 --dimensions HullIntegrity=100, Shield=70, Thrusters=maximum

## Cloudwatch Availability of Data
How often CloudWatch collect and update metrics data for you?
|  |EC2| Other Services|
|---|---|---|
|Basic Monitoring | 5 minutes | 1 minute / 3 Minutes / 5 Minutes |
| Detailed Monitoring | 1 minute interval |   |

Most of services are 1 minute by default. 

For EC2, by default, it is 5 minutes, and extra cost needed to turn it into detailed monitoring.
By Default, some metrics for EC2 instances are not tracked. and CloudWatch agent has to be installed to get extra metrics.

|CloudWatch will track at the Host Level by default| require the Agent to get detailed Metrics|
|---|---|
| CPU Usage| Memory utilization|
| Network usage | Disk Swap utilizaiton |
| Disk usage | Disk spae utilization|
| status Checks(Hypervisor Status, EC2 instance status) | Page file utilization, log collection|


Amazon EventBridge is the same as CloudWatch Events, but with new interfaces


# CloudTrail
CloudTrail is a Logs API calls between AWS Services when you need to know **who to blame**.

AWS CloudTrail is a service that enable **governance**, **compliance**, **operational auditing**, and **risk auditing** of your AWS account. AWS CloudTrail is used to **monitor API calls** and **Actions** made by an AWS Account. It can easily identify which users and accounts made the calls to AWS like,
* Where -- Source IP Address
* When -- EventTime
* Who -- User, UserAgent
* What -- Region, Resource, Action

In your account, CloudTrail is already logging by default, and will collect logs for last 90 days via Event History.
## Trail
If you need more than 90 days you need to create a **Trail**.
Trails are outputs to S3 and do not have GUID like event history. To analyze a **Trail**, **Amazon Athema** has to be used.
### Trail options
* Log cross all the regions
* cross all the account in  an organization
* encrypted via Server Side Encryption via Key Management Service(SSE-KMS)
* turn on Log File Validation  in case it is tampered by someone else.

CloudTrail can be set to deliver events to a CloudWatch log
### Management Events vs Data Events in CloudTrail

|Management Events | Data Events|
|---|---|
|Tracks Management Operations.| Traks specific operations for specific AWS Services. High Volume logging and result in additional cost. 
|Turned on by default, Cannot be off| Turned off by default|
|Configuring security/Registering devices | The two services can be tracked are **S3** and **Lambda**|
|Configuring Rules for routing data | Track actions such as, GetObject, DeleteObject, PutObject
|Setting up logging |

# AWS Lambda
Lambda is a compute service, that runs code without provisioning or managing servers. Servers are automatically start and stop when needed. It can be considered as Serverless Functions. Pay per invocation
It can scales automatically to a few or a 1000 lambda functions concurrently in seconds.
Natively support 7 languages: Ruby, Python, Java, GO, Powershell, NodeJS, C#
You can create your own custom runtime environments.

Lambda is commonly used to glue different services together.

**Example Use Case: Processing Thumbnails**
A web service allows users to upload profile photo. they are stored in S3 bucket. An event trigger can be setup so that when a profile photo comes in, a Lambda can be invoked to generate a thumbnail and store it back to the bucket.

**Example Use Case: Contact Email Form**
A company has a web form as contact email. the form can be submitted via API Gateway Endpoint. That endpoint can trigger a lambda which validate the form data and if valid, the data will be saved to DynamoDB and send an email notification via SNS to the company.

Lambda can be integrated into 3rd party sources via Amazon EventBridge
## Lambda Pricing,
* 1st 1 million requests per month are free. after that, $0.20 per additional 1 million reqests
* 400,000 GB ses free per month. After that, 0.0000166667 for every GB sec
* the price will vary on the amount of memory you allocate. 128M * 3o M executed per month * 200 ms run time per invocation = $5.83

## Default and Limits
* By default, you can have 1000 lambda, but you can ask AWS support for limit increase
* /tmp folder can contian up to 500MB
* By default, Lambda runs in no VPC. You can set them to run in your VPC, but your lambda will lose internet access.
* max timeout can be 15 minutes. If timeout goes beyond that, you probably should consider using FarGate.
* memory can be set between 128MB to max 2008MB at an increment of 64M
## Cold Start and Warm Server  and Pre Warm


# Simple Queue Service(SQS)
Simple Queue Service is fully mamaged queuuing service that enable you to decouple and scale microservices, distributed systems, and serverless applications.

## Queueing vs Streaming
|Queueing | Streaming |
|---|---|
| Generally messages will be deleted once they are consumed | Multiple Consumers can react to events/messages
|Simple communication | Events live in the stream for long periods, so complex operations can be applied.
|Not Real-time | Realtime
| have to pull| |
| not reactive | |
| Sidekiq, SQS,  RabbitMQ| Kafka, Kinesis|

Message Size is between 1 byte and 256K
Amazon SQS extended client lib for java let you send message 256K to 2GB in size via storage in S3 by referencing to S3 Object
## Message Retention
By default 4 days. It can be adjust from 60 seconds to max 14 days.
## Queue Types
1.  Standard Queues allows you a nearly unlimited numbers of transactions per seconds It guarantees that a message will be delivered **AT LEAST once**. **More than one copy** of a message could be potentialy delivered out of order. It provides **best-effort ordering** that helps ensure a message is generally delivered.
2. FIFO queue supports multiple ordered message groups within a single queue. It limits to 300 transactions per second.

## Visibility Timeout
30 secs by defualt. range ( 0 secs to 12 hrs)
This is to prevent another app from reading a message while another app is busy with that message, aka, to avoid someone doing the same task.
A visibility time-out is the peroid of time that message are invisible in the SQS queue after a reading pick up the message.
The message will be deleted from the queue after a job has processed it.
If  ajob is NOT processed before the visibility time-out period, the message will become visible again and another reader will process it.
This can result in the same message being delivered twice.

## Short vs Long Polling
Polling is the method to retrieve messages from the queues

* Short Polling(default) return messages immediately even if the message queue being polled is empty. When a message is needed right away, short polling is what you need
* Long polling wiats until message arrives in the queue or the long poll timeout expires. Long polling makes it inexpensive to retrieve messages as soon as the messages available. Using long polling will reduce the cost because you can reduce the number of empty receives. **Most of use-cases**, you want to use Long Polling.

# SNS
Simple Notification Service is a highly available, durable, secure, fully managed pub/sub messaging service that enable you to decouple microservices, distributed systems, and serverless applications.

## Application Integration!
* Publishers push events to an **SNS Topic**
* Subscribers subscribe to SNS Topic to have events pushed to them

## SNS Topic
Topics allow you to group multiple subscriptions together
A topic is able to deliver to multiple protocols at once, e.g. email, text message, http/s
When Topics deliver messages to subscribers, it will automatically format your message according to the subscriber's chosen protocal.
Topics can be encrypted via KMS

## SNS Subscriptions
A subscription can only subscribe to one protocol and one topic
Available Protocols,
* Email(Good for internal notifications--only support plain text)
* Http/s--for create webhooks into your web-application
* Email-JSON --send JSON via email
* AWS SQS place SNS into SQS queue
* AWS Lambda
* SMS send text message
* Platform Application endpoints Mobile Push
  * ADM Amazon Device Messaging
  * APNs Apple Push Notification Service
  * Baidu Baidu Cloud Push
  * FCM Firebase Cloud Messaging
  * MPNS Microsoft Push Notification Service for Windows Phone
  * WNS Windows Push Notification Services
 
A messages are saved into multi AZs

# ElastiCache
ElastiCache is in-memory Data Store. The trade off is high volatility(low durability, risk of data loss), but access to data i very fast
Frequently identical queries are stored in the cache.
ElastiCache is only accessible to resource operating with the same VPC to ensure low latency.
It supports 2 open source caching engine,
* **Memcached** is generally preferred for caching HTML fragments. Memcached is a simple key-value store. It is very fast.
* **Redis** can perform many different operations on data. It is very good for leaderboards, keep track of unread notification data. It is very fast, but arguably not as fast as Memcached. Redis is single threaded.

# High Availability(HA)
It is the ability for a system to remain available. The solution to ensure High Availability

| Many causes could make a service unavailable | Solution to ensure High Availability|
|---|---|
| When an AZ becomes unavailable, for example, data-center flooded | run our instances in Multi AZ, and and ELB can route traffic to operational AZs |
| When a Region become unavailable, eg, meteor strike | run instances in another region. Route53 can be used to route traffic |
| When an instance of web-app becomes unresponsive, e.g. too much traffic | use Auto Scaling Groups to increase the amount of instances to meet the demand of traffic
| When an instance becomes unavailable e.g. instance failure | use Auto Scaling Groups to ensure minimum amount of instances are running and have ELB route traffic to healty instances |
| When an web-app gets unresponsive due to distance in geographic location | use CloudFront to cache static content for faster delivery in nearby region. Also instances can be run in nearby regions and route traffic using geolocation policy in Route53 |

# Scale up vs Scale Out
|Scale up | Scale out|
|--- |---|
| Vertical scaling by increasing size of the instance |  horizontal Scaling by adding more instance |
| Simpler to manage | more complex to manage |
| Lower availability( if a single instance fails) | Higher Availability| 

Generally, you want to scale out and then up to balance complexity and availability

# Elastic Beanstalk
It is Heroku of AWS. It allows you to quickl;y deploy and manage web-apps on AWS **without worrying about infrastructure**.
It is not recommended for "Production" applications

Elastic Beanstalk is powered by a CloudFormation template setup for you with,
* ELB
* Autoscaling Groups
* RDS Database
* EC2 instance preconfigured platforms
* Monitoring with CloudWatch, SNS
* In-place and Blue/Green deployment methodologies
* Security(Rotaes Passwords)
* it can run Dockerized environment, which apps are packed into dockers and uploaded into ElasticBeansTalk

You can get your web-app ready in any supported language(NodeJS, python, GO, etc), and upload archive zip file to ElasticBeansTalk for deployment. There is version label when the app gets uploaded.

# API Gateway
* API Gateway is a slolution for creating secure APIs in your cloud environment at any scale.
* Created APIs act as a front door for applications to access data, business logic, for functionality from back-end services
* API gameway throttles api endpoints at 10,000 requests per second, and can be increased via service request through AWS account
* **Stages** allow you to have multiple published versions of your API. eg. prod, dev, qa, staging.
* Each stage has an invoke url which is the endpoint you use to interact with your API
* You can use a custom domain for your invoke URL eg. api.exampro.co
 * the API is be be published via Deploy API. you can choose which Stage you want to publish your API
 * Resources are your URLs.
 * Resources can have child resources
 * You can define multiple methods on your resournces.
 CORSE issues are common with API Gateway, CORS can be enabled on all or individual endpoints
 * Caching improves latency and reduces the amount of calls makde to your endpoint
 * Same Origin Policies helps to prevent XSS attacks
 * Smae Origin Prolicies ignore tools like postman or curl
 * CORS is always enforced by the client
 * You can require Authorization to your API via AWS Cognito or a custom Lambda

#Kinesis
Amazon Kinesis is the AWS fully managed solution for collecting, processing, and analyzing streaming data in the cloud.
When you need real-time solution for data, think kinesis.
Streaming Data Example,
* Stock prices
* Game Data( as Player plays)
* Social Network Data
* Geospatial Data
* Click Stream Data

4 types of Kinesis Streams available,
1. Kinesis Data Streams
   1. Data are sharded. You pay per running shard.
   1. you can have multiple consumers, and you must manualy configure your consumers. Data is ordered, and each consumer keeps its own position
   1. Data can be persist from 24 hrs(default) to 168 hours before it disappears from the stream
   
1. Kinesis Firehose Delivery Streams
   1. You choose one consumer from a predefined list.
   1. Data immediately disappears once it is consumed
   1. you can convert incoming data to other to a few file formats, compress and secure data
   1. You pay only for data that is ingested.
1. Kinesis Video Analytics
   1. Ingest video and audio encoded data from various devices and or service
   1. Output video data to ML(like Rekognition, SageMaker) or video processing device
1. Kinesis Data Analytics
   1. Input can be Firehose Streams or Data Streams
   1. to apply data analysis(SQL) and generate an output stream
   1. this makes real time data analysis possible.
   
KPL(Kinesis Producer Library) is a Java library to write data to a stream. You can write data to stream using AWS SDK, but KPL is more efficient
   
# AWS Storage Gateway
It is to extend, backup on-premise storage to the cloud
Software appliance is available as a virtual machine(VM) Image.
It supports VMWare ESXi and Microsoft Hyper-V
Available in 3 types,
1. File Gateway(as NFS) to store files. A file is also an native S3 object once it is transferred to S3
1. Volume Gateway(as iSCICI) for block storage in Amazon S3 with point-in-time as Amazon EBS snapshots. HTTPS is used on S3 side as endpoint protocol.
   1. Stored Volume Gateway. The primary data is on premise, and data is backed up into Amazon S3 snapshots with asyc backup. The size can vary from 1GB to 16 TB in size.
   1. Cached Volume Gateway. The primary data is on Amazon S3, and frequently used data are cached on premise to lower the latency. Cached volume can be between 1GB to 32GB in size.
  
1. Tape gateway(as virtual tape library) back up your data to Amazon S3 and archive in Amazon Glacier using your existing tape-based processes. Also use ISCSI to transfer data. This is supported by NetBackup, Backup Exec, and Veeam.

iSCSI-- **Internet Small Computer System Interface** block protocol


# Preparation Materials
* Exam Guide, outline recommended knowledge, and white papers. It describes scoring model, and lists domains of exam
* Sample Questions. It offers 10 questions, and answers
* Practice Exam. It requires registration. Approx $20. You get immediate pass or failure result. It doesn't reveal incorrect answers
* White Papers
 * Architecting for the Cloud: AWS Best Practices
 * AWS Well-architected Framework
All these can be found at
https://aws.amazon.com/certification/certified-solutions-architect-associate/

https://aws.amazon.com/blogs/aws/new-whitepaper-architecting-for-the-cloud-best-practices/

https://aws.amazon.com/architecture/well-architected/

https://aws.amazon.com/training/self-paced-labs/
## Key Services to Study
### Reliability
* Aamzon VPC (virtual private cloud)
* AWS Direct Connect
* EC2
* Route53
* ELB(Elastic Load balancing)
* CloudWatch
* Amazon S3
* Amazon Glacier
### Performance
* Auto Scaling
* Amazon Elastic Block Store
* Amazon Elastic File System
* Amazon VPC
* Amazon Elastic Container Services(ECS)
* Amazon CloudWatch
* Amazon RDS
* Amazon DynamoDB
### Security
* Identity and Access Management(IAM)
* AWS Security Token Services(STS)
* IAM Instance Profiles & Roles
* AWS Organization
* AWS Config
* Amazon CloudWatch logs
* Amazon Elasticsearch Service
* Amazon VPC Security Groups
* Amazon Key Management Service(KMS)
## Cost Optimzization
* Amazon CloudWatch
* AWS Trusted Advisor
* Reserved Instances
* Spot Instances
* AWS CloudFormation
* Cost Explorer
* Billing Alerts
### Operational Excellence
* AWS CloudFormation
* AWS CodeCommit
* AWS CodePipeline
* AWS Lambda
* AWS Config
* AWS CouldWatch
* AWS CouldWatch Logs
* AWS SNS(Simple Notification Service)
* Amazon Athena(to query massive logs)

# Test-Taking Strategy
* in 3 passes
* 1st pass: choose what you know you know
* 2nd pass: process of elimination
* 3rd pass: Review, Review, Review, Review!




# Exam Tricks
When being asked to **automate the provisioning of resources** think CloudFormation
When **Infrastructure as Code(IoC)** is mentioned, think CouldFormation






