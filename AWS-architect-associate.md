
# TODO: understand the following Terms,
* ENI--elastic network interface
* AMI
* CIDR block

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

