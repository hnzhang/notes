# Use CloudFormation for automation
Tags
Infrastructure as Code
Operation as Code
## sample templale in JSON format
```JSON
{
  "AWSTemplateFormatVersion" : "2010-09-09",

  "Description" : "OE Lab AWS CloudFormation Template: Sample template showing how to create a VPC and add EC2 instances with security groups and tagging. For use with OE Lab operations exercises. **WARNING** This template creates an Amazon EC2 instance. You will be billed for the AWS resources used if you create a stack from this template.",

  "Parameters" : {

    "WorkloadName": {
      "Description" : "The Name tag you wish to apply to the workload that will be created",
      "Type": "String",
      "MinLength": "1",
      "MaxLength": "256"
    },

    "InstanceProfile": {
      "Description" : "Instance profile to assign to instances (not required).",
      "Type": "String"
    },

    "InstanceTypeWeb" : {
      "Description" : "WebServer EC2 instance type",
      "Type" : "String",
      "Default" : "t2.micro",
      "AllowedValues" : [ "t1.micro", "t2.nano", "t2.micro", "t2.small", "t2.large", "m1.small" ],
      "ConstraintDescription" : "must be a valid EC2 instance type."
    },

    "InstanceTypeApp" : {
      "Description" : "AppServer EC2 instance type",
      "Type" : "String",
      "Default" : "t2.micro",
      "AllowedValues" : [ "t1.micro", "t2.nano", "t2.micro", "t2.small", "t2.medium", "t2.large", "m1.small", "m1.medium" ],
      "ConstraintDescription" : "must be a valid EC2 instance type."
    },

    "KeyName": {
      "Description" : "Name of an existing EC2 KeyPair to enable SSH access to the instance",
      "Type": "AWS::EC2::KeyPair::KeyName",
      "ConstraintDescription" : "must be the name of an existing EC2 KeyPair."
    },
    
    "SourceLocation" : {
      "Description" : "The CIDR IP address range that can be used to SSH to the EC2 instances and access the servers via http",
      "Type": "String",
      "MinLength": "9",
      "MaxLength": "18",
      "Default": "0.0.0.0/0",
      "AllowedPattern": "(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})/(\\d{1,2})",
      "ConstraintDescription": "must be a valid IP CIDR range of the form x.x.x.x/x."
    }
  },

  "Mappings" : {
    "Region2Examples" : {
      "us-east-1"      : { "Examples" : "https://s3.amazonaws.com/cloudformation-examples-us-east-1" },
      "us-west-2"      : { "Examples" : "https://s3-us-west-2.amazonaws.com/cloudformation-examples-us-west-2" },
      "us-west-1"      : { "Examples" : "https://s3-us-west-1.amazonaws.com/cloudformation-examples-us-west-1" },
      "eu-west-1"      : { "Examples" : "https://s3-eu-west-1.amazonaws.com/cloudformation-examples-eu-west-1" },
      "eu-west-2"      : { "Examples" : "https://s3-eu-west-2.amazonaws.com/cloudformation-examples-eu-west-2" },
      "eu-west-3"      : { "Examples" : "https://s3-eu-west-3.amazonaws.com/cloudformation-examples-eu-west-3" },
      "eu-central-1"   : { "Examples" : "https://s3-eu-central-1.amazonaws.com/cloudformation-examples-eu-central-1" },
      "ap-southeast-1" : { "Examples" : "https://s3-ap-southeast-1.amazonaws.com/cloudformation-examples-ap-southeast-1" },
      "ap-northeast-1" : { "Examples" : "https://s3-ap-northeast-1.amazonaws.com/cloudformation-examples-ap-northeast-1" },
      "ap-northeast-2" : { "Examples" : "https://s3-ap-northeast-2.amazonaws.com/cloudformation-examples-ap-northeast-2" },
      "ap-northeast-3" : { "Examples" : "https://s3-ap-northeast-3.amazonaws.com/cloudformation-examples-ap-northeast-3" },
      "ap-southeast-2" : { "Examples" : "https://s3-ap-southeast-2.amazonaws.com/cloudformation-examples-ap-southeast-2" },
      "ap-south-1"     : { "Examples" : "https://s3-ap-south-1.amazonaws.com/cloudformation-examples-ap-south-1" },
      "us-east-2"      : { "Examples" : "https://s3-us-east-2.amazonaws.com/cloudformation-examples-us-east-2" },
      "ca-central-1"   : { "Examples" : "https://s3-ca-central-1.amazonaws.com/cloudformation-examples-ca-central-1" },
      "sa-east-1"      : { "Examples" : "https://s3-sa-east-1.amazonaws.com/cloudformation-examples-sa-east-1" },
      "cn-north-1"     : { "Examples" : "https://s3.cn-north-1.amazonaws.com.cn/cloudformation-examples-cn-north-1" },
      "cn-northwest-1" : { "Examples" : "https://s3.cn-northwest-1.amazonaws.com.cn/cloudformation-examples-cn-northwest-1" }
    },

    "AWSInstanceType2Arch" : {
      "t1.micro"    : { "Arch" : "PV64"   },
      "t2.nano"     : { "Arch" : "HVM64"  },
      "t2.micro"    : { "Arch" : "HVM64"  },
      "t2.small"    : { "Arch" : "HVM64"  },
      "t2.medium"   : { "Arch" : "HVM64"  },
      "t2.large"    : { "Arch" : "HVM64"  },
      "m1.small"    : { "Arch" : "PV64"   },
      "m1.medium"   : { "Arch" : "PV64"   },
      "m1.large"    : { "Arch" : "PV64"   },
      "m1.xlarge"   : { "Arch" : "PV64"   },
      "m2.xlarge"   : { "Arch" : "PV64"   },
      "m2.2xlarge"  : { "Arch" : "PV64"   },
      "m2.4xlarge"  : { "Arch" : "PV64"   },
      "m3.medium"   : { "Arch" : "HVM64"  },
      "m3.large"    : { "Arch" : "HVM64"  },
      "m3.xlarge"   : { "Arch" : "HVM64"  },
      "m3.2xlarge"  : { "Arch" : "HVM64"  },
      "m4.large"    : { "Arch" : "HVM64"  },
      "m4.xlarge"   : { "Arch" : "HVM64"  },
      "m4.2xlarge"  : { "Arch" : "HVM64"  },
      "m4.4xlarge"  : { "Arch" : "HVM64"  },
      "m4.10xlarge" : { "Arch" : "HVM64"  },
      "c1.medium"   : { "Arch" : "PV64"   },
      "c1.xlarge"   : { "Arch" : "PV64"   },
      "c3.large"    : { "Arch" : "HVM64"  },
      "c3.xlarge"   : { "Arch" : "HVM64"  },
      "c3.2xlarge"  : { "Arch" : "HVM64"  },
      "c3.4xlarge"  : { "Arch" : "HVM64"  },
      "c3.8xlarge"  : { "Arch" : "HVM64"  },
      "c4.large"    : { "Arch" : "HVM64"  },
      "c4.xlarge"   : { "Arch" : "HVM64"  },
      "c4.2xlarge"  : { "Arch" : "HVM64"  },
      "c4.4xlarge"  : { "Arch" : "HVM64"  },
      "c4.8xlarge"  : { "Arch" : "HVM64"  },
      "g2.2xlarge"  : { "Arch" : "HVMG2"  },
      "g2.8xlarge"  : { "Arch" : "HVMG2"  },
      "r3.large"    : { "Arch" : "HVM64"  },
      "r3.xlarge"   : { "Arch" : "HVM64"  },
      "r3.2xlarge"  : { "Arch" : "HVM64"  },
      "r3.4xlarge"  : { "Arch" : "HVM64"  },
      "r3.8xlarge"  : { "Arch" : "HVM64"  },
      "i2.xlarge"   : { "Arch" : "HVM64"  },
      "i2.2xlarge"  : { "Arch" : "HVM64"  },
      "i2.4xlarge"  : { "Arch" : "HVM64"  },
      "i2.8xlarge"  : { "Arch" : "HVM64"  },
      "d2.xlarge"   : { "Arch" : "HVM64"  },
      "d2.2xlarge"  : { "Arch" : "HVM64"  },
      "d2.4xlarge"  : { "Arch" : "HVM64"  },
      "d2.8xlarge"  : { "Arch" : "HVM64"  },
      "hi1.4xlarge" : { "Arch" : "HVM64"  },
      "hs1.8xlarge" : { "Arch" : "HVM64"  },
      "cr1.8xlarge" : { "Arch" : "HVM64"  },
      "cc2.8xlarge" : { "Arch" : "HVM64"  }
    },

    "AWSInstanceType2NATArch" : {
      "t1.micro"    : { "Arch" : "NATPV64"   },
      "t2.nano"     : { "Arch" : "NATHVM64"  },
      "t2.micro"    : { "Arch" : "NATHVM64"  },
      "t2.small"    : { "Arch" : "NATHVM64"  },
      "t2.medium"   : { "Arch" : "NATHVM64"  },
      "t2.large"    : { "Arch" : "NATHVM64"  },
      "m1.small"    : { "Arch" : "NATPV64"   },
      "m1.medium"   : { "Arch" : "NATPV64"   },
      "m1.large"    : { "Arch" : "NATPV64"   },
      "m1.xlarge"   : { "Arch" : "NATPV64"   },
      "m2.xlarge"   : { "Arch" : "NATPV64"   },
      "m2.2xlarge"  : { "Arch" : "NATPV64"   },
      "m2.4xlarge"  : { "Arch" : "NATPV64"   },
      "m3.medium"   : { "Arch" : "NATHVM64"  },
      "m3.large"    : { "Arch" : "NATHVM64"  },
      "m3.xlarge"   : { "Arch" : "NATHVM64"  },
      "m3.2xlarge"  : { "Arch" : "NATHVM64"  },
      "m4.large"    : { "Arch" : "NATHVM64"  },
      "m4.xlarge"   : { "Arch" : "NATHVM64"  },
      "m4.2xlarge"  : { "Arch" : "NATHVM64"  },
      "m4.4xlarge"  : { "Arch" : "NATHVM64"  },
      "m4.10xlarge" : { "Arch" : "NATHVM64"  },
      "c1.medium"   : { "Arch" : "NATPV64"   },
      "c1.xlarge"   : { "Arch" : "NATPV64"   },
      "c3.large"    : { "Arch" : "NATHVM64"  },
      "c3.xlarge"   : { "Arch" : "NATHVM64"  },
      "c3.2xlarge"  : { "Arch" : "NATHVM64"  },
      "c3.4xlarge"  : { "Arch" : "NATHVM64"  },
      "c3.8xlarge"  : { "Arch" : "NATHVM64"  },
      "c4.large"    : { "Arch" : "NATHVM64"  },
      "c4.xlarge"   : { "Arch" : "NATHVM64"  },
      "c4.2xlarge"  : { "Arch" : "NATHVM64"  },
      "c4.4xlarge"  : { "Arch" : "NATHVM64"  },
      "c4.8xlarge"  : { "Arch" : "NATHVM64"  },
      "g2.2xlarge"  : { "Arch" : "NATHVMG2"  },
      "g2.8xlarge"  : { "Arch" : "NATHVMG2"  },
      "r3.large"    : { "Arch" : "NATHVM64"  },
      "r3.xlarge"   : { "Arch" : "NATHVM64"  },
      "r3.2xlarge"  : { "Arch" : "NATHVM64"  },
      "r3.4xlarge"  : { "Arch" : "NATHVM64"  },
      "r3.8xlarge"  : { "Arch" : "NATHVM64"  },
      "i2.xlarge"   : { "Arch" : "NATHVM64"  },
      "i2.2xlarge"  : { "Arch" : "NATHVM64"  },
      "i2.4xlarge"  : { "Arch" : "NATHVM64"  },
      "i2.8xlarge"  : { "Arch" : "NATHVM64"  },
      "d2.xlarge"   : { "Arch" : "NATHVM64"  },
      "d2.2xlarge"  : { "Arch" : "NATHVM64"  },
      "d2.4xlarge"  : { "Arch" : "NATHVM64"  },
      "d2.8xlarge"  : { "Arch" : "NATHVM64"  },
      "hi1.4xlarge" : { "Arch" : "NATHVM64"  },
      "hs1.8xlarge" : { "Arch" : "NATHVM64"  },
      "cr1.8xlarge" : { "Arch" : "NATHVM64"  },
      "cc2.8xlarge" : { "Arch" : "NATHVM64"  }
    },

    "AWSRegionArch2AMI" : {
      "us-east-1"        : {"PV64" : "ami-c87053b2", "HVM64" : "ami-97785bed", "HVMG2" : "ami-0a6e3770"},
      "us-west-2"        : {"PV64" : "ami-31d86849", "HVM64" : "ami-f2d3638a", "HVMG2" : "ami-ee15a196"},
      "us-west-1"        : {"PV64" : "ami-d8494bb8", "HVM64" : "ami-824c4ee2", "HVMG2" : "ami-0da4a46d"},
      "eu-west-1"        : {"PV64" : "ami-e539a69c", "HVM64" : "ami-d834aba1", "HVMG2" : "ami-af8013d6"},
      "eu-west-2"        : {"PV64" : "NOT_SUPPORTED", "HVM64" : "ami-403e2524", "HVMG2" : "NOT_SUPPORTED"},
      "eu-west-3"        : {"PV64" : "NOT_SUPPORTED", "HVM64" : "ami-8ee056f3", "HVMG2" : "NOT_SUPPORTED"},
      "eu-central-1"     : {"PV64" : "ami-ba55c9d5", "HVM64" : "ami-5652ce39", "HVMG2" : "ami-1d58ca72"},
      "ap-northeast-1"   : {"PV64" : "ami-a5593dc3", "HVM64" : "ami-ceafcba8", "HVMG2" : "ami-edfd658b"},
      "ap-northeast-2"   : {"PV64" : "NOT_SUPPORTED", "HVM64" : "ami-863090e8", "HVMG2" : "NOT_SUPPORTED"},
      "ap-northeast-3"   : {"PV64" : "NOT_SUPPORTED", "HVM64" : "ami-83444afe", "HVMG2" : "NOT_SUPPORTED"},
      "ap-southeast-1"   : {"PV64" : "ami-360e724a", "HVM64" : "ami-68097514", "HVMG2" : "ami-c06013bc"},
      "ap-southeast-2"   : {"PV64" : "ami-922ed2f0", "HVM64" : "ami-942dd1f6", "HVMG2" : "ami-85ef12e7"},
      "ap-south-1"       : {"PV64" : "NOT_SUPPORTED", "HVM64" : "ami-531a4c3c", "HVMG2" : "ami-411e492e"},
      "us-east-2"        : {"PV64" : "NOT_SUPPORTED", "HVM64" : "ami-f63b1193", "HVMG2" : "NOT_SUPPORTED"},
      "ca-central-1"     : {"PV64" : "NOT_SUPPORTED", "HVM64" : "ami-a954d1cd", "HVMG2" : "NOT_SUPPORTED"},
      "sa-east-1"        : {"PV64" : "ami-7c155810", "HVM64" : "ami-84175ae8", "HVMG2" : "NOT_SUPPORTED"},
      "cn-north-1"       : {"PV64" : "ami-77559f1a", "HVM64" : "ami-cb19c4a6", "HVMG2" : "NOT_SUPPORTED"},
      "cn-northwest-1"   : {"PV64" : "ami-80707be2", "HVM64" : "ami-3e60745c", "HVMG2" : "NOT_SUPPORTED"}
    }
  },

  "Conditions" : {
      "DefInstanceProfile" : {
        "Fn::Not" : [{
          "Fn::Equals": [
              { "Ref" : "InstanceProfile" },
              ""
          ]
      }]  
    }
  },

  "Resources" : {

    "VPC" : {
      "Type" : "AWS::EC2::VPC",
      "Properties" : {
        "CidrBlock" : "10.0.0.0/16",
        "Tags" : [ {"Key" : "Application", "Value" : { "Ref" : "AWS::StackId"} }, {"Key" : "Name", "Value" : { "Ref" : "WorkloadName"} } ]
      }
    },

    "Subnet" : {
      "Type" : "AWS::EC2::Subnet",
      "Properties" : {
        "VpcId" : { "Ref" : "VPC" },
        "CidrBlock" : "10.0.0.0/24",
        "Tags" : [ {"Key" : "Application", "Value" : { "Ref" : "AWS::StackId"} } ]
      }
    },

    "InternetGateway" : {
      "Type" : "AWS::EC2::InternetGateway",
      "Properties" : {
        "Tags" : [ {"Key" : "Application", "Value" : { "Ref" : "AWS::StackId"} } ]
      }
    },

    "AttachGateway" : {
       "Type" : "AWS::EC2::VPCGatewayAttachment",
       "Properties" : {
         "VpcId" : { "Ref" : "VPC" },
         "InternetGatewayId" : { "Ref" : "InternetGateway" }
       }
    },

    "RouteTable" : {
      "Type" : "AWS::EC2::RouteTable",
      "Properties" : {
        "VpcId" : {"Ref" : "VPC"},
        "Tags" : [ {"Key" : "Application", "Value" : { "Ref" : "AWS::StackId"} } ]
      }
    },

    "Route" : {
      "Type" : "AWS::EC2::Route",
      "DependsOn" : "AttachGateway",
      "Properties" : {
        "RouteTableId" : { "Ref" : "RouteTable" },
        "DestinationCidrBlock" : "0.0.0.0/0",
        "GatewayId" : { "Ref" : "InternetGateway" }
      }
    },

    "SubnetRouteTableAssociation" : {
      "Type" : "AWS::EC2::SubnetRouteTableAssociation",
      "Properties" : {
        "SubnetId" : { "Ref" : "Subnet" },
        "RouteTableId" : { "Ref" : "RouteTable" }
      }
    },

    "NetworkAcl" : {
      "Type" : "AWS::EC2::NetworkAcl",
      "Properties" : {
        "VpcId" : {"Ref" : "VPC"},
        "Tags" : [ {"Key" : "Application", "Value" : { "Ref" : "AWS::StackId"} } ]
      }
    },

    "InboundHTTPNetworkAclEntry" : {
      "Type" : "AWS::EC2::NetworkAclEntry",
      "Properties" : {
        "NetworkAclId" : {"Ref" : "NetworkAcl"},
        "RuleNumber" : "100",
        "Protocol" : "6",
        "RuleAction" : "allow",
        "Egress" : "false",
        "CidrBlock" : "0.0.0.0/0",
        "PortRange" : {"From" : "80", "To" : "80"}
      }
    },

    "InboundSSHNetworkAclEntry" : {
      "Type" : "AWS::EC2::NetworkAclEntry",
      "Properties" : {
        "NetworkAclId" : {"Ref" : "NetworkAcl"},
        "RuleNumber" : "101",
        "Protocol" : "6",
        "RuleAction" : "allow",
        "Egress" : "false",
        "CidrBlock" : "0.0.0.0/0",
        "PortRange" : {"From" : "22", "To" : "22"}
      }
    },

    "InboundResponsePortsNetworkAclEntry" : {
      "Type" : "AWS::EC2::NetworkAclEntry",
      "Properties" : {
        "NetworkAclId" : {"Ref" : "NetworkAcl"},
        "RuleNumber" : "102",
        "Protocol" : "6",
        "RuleAction" : "allow",
        "Egress" : "false",
        "CidrBlock" : "0.0.0.0/0",
        "PortRange" : {"From" : "1024", "To" : "65535"}
      }
    },

    "OutBoundHTTPNetworkAclEntry" : {
      "Type" : "AWS::EC2::NetworkAclEntry",
      "Properties" : {
        "NetworkAclId" : {"Ref" : "NetworkAcl"},
        "RuleNumber" : "100",
        "Protocol" : "6",
        "RuleAction" : "allow",
        "Egress" : "true",
        "CidrBlock" : "0.0.0.0/0",
        "PortRange" : {"From" : "80", "To" : "80"}
      }
    },

    "OutBoundHTTPSNetworkAclEntry" : {
      "Type" : "AWS::EC2::NetworkAclEntry",
      "Properties" : {
        "NetworkAclId" : {"Ref" : "NetworkAcl"},
        "RuleNumber" : "101",
        "Protocol" : "6",
        "RuleAction" : "allow",
        "Egress" : "true",
        "CidrBlock" : "0.0.0.0/0",
        "PortRange" : {"From" : "443", "To" : "443"}
      }
    },

    "OutBoundResponsePortsNetworkAclEntry" : {
      "Type" : "AWS::EC2::NetworkAclEntry",
      "Properties" : {
        "NetworkAclId" : {"Ref" : "NetworkAcl"},
        "RuleNumber" : "102",
        "Protocol" : "6",
        "RuleAction" : "allow",
        "Egress" : "true",
        "CidrBlock" : "0.0.0.0/0",
        "PortRange" : {"From" : "1024", "To" : "65535"}
      }
    },

    "SubnetNetworkAclAssociation" : {
      "Type" : "AWS::EC2::SubnetNetworkAclAssociation",
      "Properties" : {
        "SubnetId" : { "Ref" : "Subnet" },
        "NetworkAclId" : { "Ref" : "NetworkAcl" }
      }
    },

    "InstanceSecurityGroup" : {
      "Type" : "AWS::EC2::SecurityGroup",
      "Properties" : {
        "VpcId" : { "Ref" : "VPC" },
        "GroupDescription" : "Enable SSH access via port 22 and web access via port 80",
        "SecurityGroupIngress" : [
          {"IpProtocol" : "tcp", "FromPort" : "22", "ToPort" : "22", "CidrIp" : { "Ref" : "SourceLocation"}},
          { "IpProtocol" : "tcp", "FromPort" : "80", "ToPort" : "80", "CidrIp" : { "Ref" : "SourceLocation"}}
         ]
      }
    },


    "WebServerInstance1" : {
      "Type" : "AWS::EC2::Instance",
      "DependsOn" : "AttachGateway",
      "Metadata" : {
        "Comment" : "Install a simple application",
        "AWS::CloudFormation::Init" : {
          "config" : {
            "packages" : {
              "yum" : {
                "httpd"             : []
              }
            },

            "files" : {
              "/var/www/html/index.html" : {
                "content" : { "Fn::Join" : ["\n", [
                  "<img src=\"", {"Fn::FindInMap" : ["Region2Examples", {"Ref" : "AWS::Region"}, "Examples"]}, "/cloudformation_graphic.png\" alt=\"AWS CloudFormation Logo\"/>",
                  "<h1>Congratulations, you have successfully launched the AWS CloudFormation sample.</h1>"
                ]]},
                "mode"    : "000644",
                "owner"   : "root",
                "group"   : "root"
              },

              "/etc/cfn/cfn-hup.conf" : {
                "content" : { "Fn::Join" : ["", [
                  "[main]\n",
                  "stack=", { "Ref" : "AWS::StackId" }, "\n",
                  "region=", { "Ref" : "AWS::Region" }, "\n"
                ]]},
                "mode"    : "000400",
                "owner"   : "root",
                "group"   : "root"
              },

              "/etc/cfn/hooks.d/cfn-auto-reloader.conf" : {
                "content": { "Fn::Join" : ["", [
                  "[cfn-auto-reloader-hook]\n",
                  "triggers=post.update\n",
                  "path=Resources.WebServerInstance1.Metadata.AWS::CloudFormation::Init\n",
                  "action=/opt/aws/bin/cfn-init -v ",
                  "         --stack ", { "Ref" : "AWS::StackName" },
                  "         --resource WebServerInstance1 ",
                  "         --region ", { "Ref" : "AWS::Region" }, "\n",
                  "runas=root\n"
                ]]},
                "mode"    : "000400",
                "owner"   : "root",
                "group"   : "root"
              }
            },

            "services" : {
              "sysvinit" : {
                "httpd"    : { "enabled" : "true", "ensureRunning" : "true" },
                "cfn-hup" : { "enabled" : "true", "ensureRunning" : "true", 
                              "files" : ["/etc/cfn/cfn-hup.conf", "/etc/cfn/hooks.d/cfn-auto-reloader.conf"]}
              }
            }
          }
        }
      },
      "Properties" : {
        "ImageId" : { "Fn::FindInMap" : [ "AWSRegionArch2AMI", { "Ref" : "AWS::Region" },
                          { "Fn::FindInMap" : [ "AWSInstanceType2Arch", { "Ref" : "InstanceTypeWeb" }, "Arch" ] } ] },
        "InstanceType" : { "Ref" : "InstanceTypeWeb" },
        "KeyName" : { "Ref" : "KeyName" },
        "Tags" : [ {"Key" : "Application", "Value" : { "Ref" : "AWS::StackId"} }, 
            {"Key" : "SSMManaged", "Value" : "True" }, 
            {"Key" : "Confidentiality", "Value" : "Public" }, 
            {"Key" : "Environment", "Value" : "OELabIPM" },
            {"Key" : "InstanceRole", "Value" : "WebServer" },
            {"Key" : "Patch Group", "Value" : "Critical" },
            {"Key" : "Workload", "Value" : { "Ref" : "WorkloadName" } },
            {"Key" : "Name", "Value" : { "Fn::Join" : [ "-", [ { "Ref" : "WorkloadName"}, "Web1" ]] } } ],
        "NetworkInterfaces" : [{
          "GroupSet"                 : [{ "Ref" : "InstanceSecurityGroup" }],
          "AssociatePublicIpAddress" : "true",
          "DeviceIndex"              : "0",
          "DeleteOnTermination"      : "true",
          "SubnetId"                 : { "Ref" : "Subnet" }
        }],
        "IamInstanceProfile" : {
            "Fn::If" : [
                "DefInstanceProfile",
                { "Ref" : "InstanceProfile" },
                { "Ref" : "AWS::NoValue" }
            ]
        },        
        "UserData"       : { "Fn::Base64" : { "Fn::Join" : ["", [
             "#!/bin/bash -xe\n",
             "yum update -y aws-cfn-bootstrap\n",

             "/opt/aws/bin/cfn-init -v ",
             "         --stack ", { "Ref" : "AWS::StackName" },
             "         --resource WebServerInstance1 ",
             "         --region ", { "Ref" : "AWS::Region" }, "\n",

             "/opt/aws/bin/cfn-signal -e $? ",
             "         --stack ", { "Ref" : "AWS::StackName" },
             "         --resource WebServerInstance1 ",
             "         --region ", { "Ref" : "AWS::Region" }, "\n"
        ]]}}
      },
      "CreationPolicy" : {
        "ResourceSignal" : {
          "Timeout" : "PT15M"
        }
      }
    },

    "WebServerInstance2" : {
      "Type" : "AWS::EC2::Instance",
      "DependsOn" : "AttachGateway",
      "Metadata" : {
        "Comment" : "Install a simple application",
        "AWS::CloudFormation::Init" : {
          "config" : {
            "packages" : {
              "yum" : {
                "httpd"             : []
              }
            },

            "files" : {
              "/var/www/html/index.html" : {
                "content" : { "Fn::Join" : ["\n", [
                  "<img src=\"", {"Fn::FindInMap" : ["Region2Examples", {"Ref" : "AWS::Region"}, "Examples"]}, "/cloudformation_graphic.png\" alt=\"AWS CloudFormation Logo\"/>",
                  "<h1>Congratulations, you have successfully launched the AWS CloudFormation sample.</h1>"
                ]]},
                "mode"    : "000644",
                "owner"   : "root",
                "group"   : "root"
              },

              "/etc/cfn/cfn-hup.conf" : {
                "content" : { "Fn::Join" : ["", [
                  "[main]\n",
                  "stack=", { "Ref" : "AWS::StackId" }, "\n",
                  "region=", { "Ref" : "AWS::Region" }, "\n"
                ]]},
                "mode"    : "000400",
                "owner"   : "root",
                "group"   : "root"
              },

              "/etc/cfn/hooks.d/cfn-auto-reloader.conf" : {
                "content": { "Fn::Join" : ["", [
                  "[cfn-auto-reloader-hook]\n",
                  "triggers=post.update\n",
                  "path=Resources.WebServerInstance2.Metadata.AWS::CloudFormation::Init\n",
                  "action=/opt/aws/bin/cfn-init -v ",
                  "         --stack ", { "Ref" : "AWS::StackName" },
                  "         --resource WebServerInstance2 ",
                  "         --region ", { "Ref" : "AWS::Region" }, "\n",
                  "runas=root\n"
                ]]},
                "mode"    : "000400",
                "owner"   : "root",
                "group"   : "root"
              }
            },

            "services" : {
              "sysvinit" : {
                "httpd"    : { "enabled" : "true", "ensureRunning" : "true" },
                "cfn-hup" : { "enabled" : "true", "ensureRunning" : "true", 
                              "files" : ["/etc/cfn/cfn-hup.conf", "/etc/cfn/hooks.d/cfn-auto-reloader.conf"]}
              }
            }
          }
        }
      },
      "Properties" : {
        "ImageId" : { "Fn::FindInMap" : [ "AWSRegionArch2AMI", { "Ref" : "AWS::Region" },
                          { "Fn::FindInMap" : [ "AWSInstanceType2Arch", { "Ref" : "InstanceTypeWeb" }, "Arch" ] } ] },
        "InstanceType" : { "Ref" : "InstanceTypeWeb" },
        "KeyName" : { "Ref" : "KeyName" },
        "Tags" : [ {"Key" : "Application", "Value" : { "Ref" : "AWS::StackId"} }, 
            {"Key" : "SSMManaged", "Value" : "True" }, 
            {"Key" : "Confidentiality", "Value" : "Public" }, 
            {"Key" : "Environment", "Value" : "OELabIPM" },
            {"Key" : "InstanceRole", "Value" : "WebServer" },
            {"Key" : "Patch Group", "Value" : "Critical" },
            {"Key" : "Workload", "Value" : { "Ref" : "WorkloadName" } },
            {"Key" : "Name", "Value" : { "Fn::Join" : [ "-", [ { "Ref" : "WorkloadName"}, "Web2" ]] } } ],
        "NetworkInterfaces" : [{
          "GroupSet"                 : [{ "Ref" : "InstanceSecurityGroup" }],
          "AssociatePublicIpAddress" : "true",
          "DeviceIndex"              : "0",
          "DeleteOnTermination"      : "true",
          "SubnetId"                 : { "Ref" : "Subnet" }
        }],
        "IamInstanceProfile" : {
            "Fn::If" : [
                "DefInstanceProfile",
                { "Ref" : "InstanceProfile" },
                { "Ref" : "AWS::NoValue" }
            ]
        },          
        "UserData"       : { "Fn::Base64" : { "Fn::Join" : ["", [
             "#!/bin/bash -xe\n",
             "yum update -y aws-cfn-bootstrap\n",

             "/opt/aws/bin/cfn-init -v ",
             "         --stack ", { "Ref" : "AWS::StackName" },
             "         --resource WebServerInstance2 ",
             "         --region ", { "Ref" : "AWS::Region" }, "\n",

             "/opt/aws/bin/cfn-signal -e $? ",
             "         --stack ", { "Ref" : "AWS::StackName" },
             "         --resource WebServerInstance2 ",
             "         --region ", { "Ref" : "AWS::Region" }, "\n"
        ]]}}
      },
      "CreationPolicy" : {
        "ResourceSignal" : {
          "Timeout" : "PT15M"
        }
      }
    },
        
    "AppServer1": {
        "Type": "AWS::EC2::Instance",
        "Metadata": {
            "Comment" : "Install a simple server"
        },
        "Properties" : {
            "ImageId" : { "Fn::FindInMap" : [ "AWSRegionArch2AMI", { "Ref" : "AWS::Region" },
                            { "Fn::FindInMap" : [ "AWSInstanceType2Arch", { "Ref" : "InstanceTypeApp" }, "Arch" ] } ] },
            "InstanceType" : { "Ref" : "InstanceTypeApp" },
            "KeyName" : { "Ref" : "KeyName" },
            "Tags" : [ {"Key" : "Application", "Value" : { "Ref" : "AWS::StackId"} }, 
                {"Key" : "SSMManaged", "Value" : "True" }, 
                {"Key" : "Confidentiality", "Value" : "Public" }, 
                {"Key" : "Environment", "Value" : "OELabIPM" },
                {"Key" : "InstanceRole", "Value" : "AppServer" },
                {"Key" : "Patch Group", "Value" : "Critical" },
                {"Key" : "Workload", "Value" : { "Ref" : "WorkloadName" } },
                {"Key" : "Name", "Value" : { "Fn::Join" : [ "-", [ { "Ref" : "WorkloadName"}, "App1" ]] } } ],
            "NetworkInterfaces" : [{
                "GroupSet"                 : [{ "Ref" : "InstanceSecurityGroup" }],
                "AssociatePublicIpAddress" : "true",
                "DeviceIndex"              : "0",
                "DeleteOnTermination"      : "true",
                "SubnetId"                 : { "Ref" : "Subnet" }
            }],
            "IamInstanceProfile" : {
                "Fn::If" : [
                    "DefInstanceProfile",
                    { "Ref" : "InstanceProfile" },
                    { "Ref" : "AWS::NoValue" }
                ]
            },
            "UserData"       : { "Fn::Base64" : { "Fn::Join" : ["", [
                "#!/bin/bash -xe\n",
                "yum update -y aws-cfn-bootstrap\n",

                "/opt/aws/bin/cfn-init -v ",
                "         --stack ", { "Ref" : "AWS::StackName" },
                "         --resource AppServer1 ",
                "         --region ", { "Ref" : "AWS::Region" }, "\n",

                "/opt/aws/bin/cfn-signal -e $? ",
                "         --stack ", { "Ref" : "AWS::StackName" },
                "         --resource AppServer1 ",
                "         --region ", { "Ref" : "AWS::Region" }, "\n"
            ]]}}
        },
      "CreationPolicy" : {
        "ResourceSignal" : {
          "Timeout" : "PT15M"
        }
      }
    },

    "AppServer2": {
        "Type": "AWS::EC2::Instance",
        "Metadata": {
            "Comment" : "Install a simple server"
        },
        "Properties" : {
            "ImageId" : { "Fn::FindInMap" : [ "AWSRegionArch2AMI", { "Ref" : "AWS::Region" },
                            { "Fn::FindInMap" : [ "AWSInstanceType2Arch", { "Ref" : "InstanceTypeApp" }, "Arch" ] } ] },
            "InstanceType" : { "Ref" : "InstanceTypeApp" },
            "KeyName" : { "Ref" : "KeyName" },
            "Tags" : [ {"Key" : "Application", "Value" : { "Ref" : "AWS::StackId"} }, 
                {"Key" : "SSMManaged", "Value" : "True" }, 
                {"Key" : "Confidentiality", "Value" : "Public" }, 
                {"Key" : "Environment", "Value" : "OELabIPM" },
                {"Key" : "InstanceRole", "Value" : "AppServer" },
                {"Key" : "Patch Group", "Value" : "Critical" },
                {"Key" : "Workload", "Value" : { "Ref" : "WorkloadName" } },
                {"Key" : "Name", "Value" : { "Fn::Join" : [ "-", [ { "Ref" : "WorkloadName"}, "App2" ]] } } ],
            "NetworkInterfaces" : [{
                "GroupSet"                 : [{ "Ref" : "InstanceSecurityGroup" }],
                "AssociatePublicIpAddress" : "true",
                "DeviceIndex"              : "0",
                "DeleteOnTermination"      : "true",
                "SubnetId"                 : { "Ref" : "Subnet" }
            }],
            "IamInstanceProfile" : {
                "Fn::If" : [
                    "DefInstanceProfile",
                    { "Ref" : "InstanceProfile" },
                    { "Ref" : "AWS::NoValue" }
                ]
            },
            "UserData"       : { "Fn::Base64" : { "Fn::Join" : ["", [
                "#!/bin/bash -xe\n",
                "yum update -y aws-cfn-bootstrap\n",

                "/opt/aws/bin/cfn-init -v ",
                "         --stack ", { "Ref" : "AWS::StackName" },
                "         --resource AppServer2 ",
                "         --region ", { "Ref" : "AWS::Region" }, "\n",

                "/opt/aws/bin/cfn-signal -e $? ",
                "         --stack ", { "Ref" : "AWS::StackName" },
                "         --resource AppServer2 ",
                "         --region ", { "Ref" : "AWS::Region" }, "\n"
            ]]}}
        },
      "CreationPolicy" : {
        "ResourceSignal" : {
          "Timeout" : "PT15M"
        }
      }
    }

  },

  "Outputs" : {
    "PrimaryURL" : {
      "Value" : { "Fn::Join" : [ "", ["http://", { "Fn::GetAtt" : ["WebServerInstance1", "PublicIp"] }]]},
      "Description" : "Newly created application URL"
    },
    "SecondaryURL" : {
      "Value" : { "Fn::Join" : [ "", ["http://", { "Fn::GetAtt" : ["WebServerInstance2", "PublicIp"] }]]},
      "Description" : "Newly created application URL"
    }
  }
}
```

## Cloudformation tempalte sample in YAML format
```YAML
AWSTemplateFormatVersion: 2010-09-09
Description: >-
  AWS CloudFormation Sample Template to create lab resources. Creates a VPC and
  subnet, an S3 Bucket, an SNS Topic, an EC2 Instance, and a Lambda Function.

  **WARNING** You will be billed for the AWS resources created if you create a
  stack from this template.

  Copyright 2019 Amazon.com, Inc. or its affiliates. All Rights Reserved.

  Licensed under the Apache License, Version 2.0 (the "License"). You may not
  use this file except in compliance with the License. A copy of the License is
  located at

      https://www.apache.org/licenses/LICENSE-2.0

  or in the "license" file accompanying this file. This file is distributed  on
  an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
  express or implied. See the License for the specific language governing
  permissions and limitations under the License.
Parameters:
  BucketName:
    Type: String
    Description: >-
      A name for the S3 bucket that is created. Note that the namespace for S3
      buckets is global so the bucket name you enter here has to be globally
      unique.
  LatestAmiId:
    Type: 'AWS::SSM::Parameter::Value<AWS::EC2::Image::Id>'
    Default: /aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2
  NotificationEmail:
    Type: String
    Description: The email address to which CloudWatch Alarm notifications are published.
Resources:
  VPC:
    Type: 'AWS::EC2::VPC'
    Properties:
      CidrBlock: 10.0.0.0/16
      Tags:
        - Key: Name
          Value: WA-Lab-VPC
  Subnet:
    Type: 'AWS::EC2::Subnet'
    Properties:
      CidrBlock: 10.0.0.0/24
      VpcId: !Ref VPC
      MapPublicIpOnLaunch: 'true'
      Tags:
        - Key: Name
          Value: WA-Lab-Subnet
  InternetGateway:
    Type: 'AWS::EC2::InternetGateway'
    Properties:
      Tags:
        - Key: Name
          Value: WA-Lab-InternetGateway
  VPCGatewayAttachment:
    Type: 'AWS::EC2::VPCGatewayAttachment'
    Properties:
      InternetGatewayId: !Ref InternetGateway
      VpcId: !Ref VPC
  RouteTable:
    Type: 'AWS::EC2::RouteTable'
    Properties:
      VpcId: !Ref VPC
      Tags:
        - Key: Name
          Value: WA-Lab-RouteTable
  Route:
    Type: 'AWS::EC2::Route'
    DependsOn: VPCGatewayAttachment
    Properties:
      RouteTableId: !Ref RouteTable
      DestinationCidrBlock: 0.0.0.0/0
      GatewayId: !Ref InternetGateway
  RouteTableAssociation:
    Type: 'AWS::EC2::SubnetRouteTableAssociation'
    Properties:
      RouteTableId: !Ref RouteTable
      SubnetId: !Ref Subnet
  Instance:
    Type: 'AWS::EC2::Instance'
    DependsOn: DataReadFunction
    Properties:
      ImageId: !Ref LatestAmiId
      InstanceType: t2.micro
      IamInstanceProfile: !Ref InstanceProfile
      SubnetId: !Ref Subnet
      UserData: !Base64
        'Fn::Join':
          - ''
          - - |
              #!/bin/bash -x
            - |
              echo "test" >> /home/ec2-user/data.txt
            - |
              echo "#!/bin/bash" >> /home/ec2-user/data-write.sh
            - |
              echo "while true" >> /home/ec2-user/data-write.sh
            - |
              echo "do" >> /home/ec2-user/data-write.sh
            - 'echo "aws s3api put-object --bucket '
            - !Ref BucketName
            - |2
               --key data.txt --body /home/ec2-user/data.txt" >> /home/ec2-user/data-write.sh
            - |
              echo "sleep 50" >> /home/ec2-user/data-write.sh
            - |
              echo "done" >> /home/ec2-user/data-write.sh
            - |
              chmod +x /home/ec2-user/data-write.sh
            - |
              sh /home/ec2-user/data-write.sh &
      Tags:
        - Key: Name
          Value: WA-Lab-Instance
  InstanceProfile:
    Type: 'AWS::IAM::InstanceProfile'
    Properties:
      InstanceProfileName: WA-Lab-Instance-Profile
      Roles:
        - !Ref InstanceRole
  InstanceRole:
    Type: 'AWS::IAM::Role'
    Properties:
      RoleName: WA-Lab-InstanceRole
      AssumeRolePolicyDocument:
        Version: 2012-10-17
        Statement:
          - Effect: Allow
            Principal:
              Service: ec2.amazonaws.com
            Action: 'sts:AssumeRole'
      Policies:
        - PolicyName: S3PutObject
          PolicyDocument:
            Version: 2012-10-17
            Statement:
              - Effect: Allow
                Action: 's3:PutObject'
                Resource: !Join
                  - ''
                  - - 'arn:aws:s3:::'
                    - !Ref BucketName
                    - /*
  Bucket:
    Type: 'AWS::S3::Bucket'
    Properties:
      BucketName: !Ref BucketName
      NotificationConfiguration:
        LambdaConfigurations:
          - Event: 's3:ObjectCreated:Put'
            Function: !GetAtt
              - DataReadFunction
              - Arn
  SNSTopic:
    Type: 'AWS::SNS::Topic'
    Properties:
      TopicName: WA-Lab-Dependency-Notification
      Subscription:
        - Endpoint: !Ref NotificationEmail
          Protocol: email
  DataReadFunction:
    Type: 'AWS::Lambda::Function'
    Properties:
      FunctionName: WA-Lab-DataReadFunction
      Handler: index.lambda_handler
      Role: !GetAtt
        - DataReadLambdaRole
        - Arn
      Runtime: python3.7
      Code:
        ZipFile: !Sub |
          import os
          import boto3

          def lambda_handler(context, event):
            s3 = boto3.client('s3')
            response = s3.delete_object(
            Bucket='${BucketName}',
            Key='data.txt'
            )

            print(response)

            print('success')
            return "File deleted"
  OpsItemFunction:
    Type: 'AWS::Lambda::Function'
    Properties:
      FunctionName: WA-Lab-OpsItemFunction
      Handler: index.lambda_handler
      Role: !GetAtt
        - OpsItemLambdaRole
        - Arn
      Runtime: python3.7
      Code:
        ZipFile: !Sub |
          import json
          import boto3

          def lambda_handler(event, context):
              print(event)

              client = boto3.client('ssm')

              create_opsitem = client.create_ops_item(
              Description='Datawrite service is failing to write data to S3',
              OperationalData={
                  '/aws/resources': {
                      'Value': '[{\"arn\":\"arn:aws:s3:::${BucketName}\"}]',
                      'Type': 'SearchableString'
                  }
              },
              Source='Lambda',
              Category='Availability',
              Title='S3 Data Writes failing',
              Severity='2'
          )

              print(create_opsitem)

              return {
                  'statusCode': 200,
                  'body': json.dumps('OpsItem Created!')
              }
  DataReadLambdaRole:
    Type: 'AWS::IAM::Role'
    Properties:
      RoleName: WA-Lab-DataReadLambdaRole
      AssumeRolePolicyDocument:
        Version: 2012-10-17
        Statement:
          - Effect: Allow
            Principal:
              Service: lambda.amazonaws.com
            Action: 'sts:AssumeRole'
      ManagedPolicyArns:
        - 'arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole'
      Policies:
        - PolicyName: LambdaPolicy
          PolicyDocument:
            Version: 2012-10-17
            Statement:
              - Sid: VisualEditor0
                Effect: Allow
                Action: 's3:DeleteObject'
                Resource: !Join
                  - ''
                  - - 'arn:aws:s3:::'
                    - !Ref BucketName
                    - /*
  OpsItemLambdaRole:
    Type: 'AWS::IAM::Role'
    Properties:
      RoleName: WA-Lab-OpsItemLambdaRole
      AssumeRolePolicyDocument:
        Version: 2012-10-17
        Statement:
          - Effect: Allow
            Principal:
              Service: lambda.amazonaws.com
            Action: 'sts:AssumeRole'
      ManagedPolicyArns:
        - 'arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole'
      Policies:
        - PolicyName: LambdaPolicy
          PolicyDocument:
            Version: 2012-10-17
            Statement:
              - Sid: VisualEditor0
                Effect: Allow
                Action: 'ssm:CreateOpsItem'
                Resource: '*'
  DataReadLambdaPermission:
    Type: 'AWS::Lambda::Permission'
    Properties:
      Action: 'lambda:InvokeFunction'
      FunctionName: !Ref DataReadFunction
      Principal: s3.amazonaws.com
      SourceAccount: !Ref 'AWS::AccountId'
      SourceArn: !Join
        - ''
        - - 'arn:aws:s3:::'
          - !Ref BucketName
Outputs:
  SNSTopic:
    Description: The SNS Topic you subscribed to.
    Value: !Ref SNSTopic
  DataReadFunction:
    Description: The Lambda function that gets invoked when an object is uploaded to S3.
    Value: !Ref DataReadFunction
  OpsItemFunction:
    Description: >-
      The Lambda function that gets invoked when the CloudWatch Alarm is
      triggered.
    Value: !GetAtt
      - OpsItemFunction
      - Arn
```
## Stack
A Stack is a collection of AWS Resources created from a CloudFormation template


# AWS System Manager
a collection of features that enable IT Operations
1. Supported operating system
2. AWS Systems Manager Agent must be installed
   1. AWS Systems Manager Agent for windows requires PowerShell 3.0 or later
3. EC2 instances must have outbound internet access
4. You must access AWS Systems Manager in a supported region
5. AWS Systems Manager requires IAM Roles
  1. for instnaces that will process commands
  2. for users executing commands
 
 AWS Systems Manager Agrent is installed by default on
 * Amazon Linux
 * Windows Server 2016 
 There is no additional charge for AWS Systems Manager
 
## Inventory
Use Systems Manager Inventory to Track Instances

## State Manager
## Association
## Compliance
For pactch compliance and configuration inconsistencies.
## Patch Manager automates the process of patching managed instances with security related updates.
### Patch Baselines
Patch Manager uses patch baselines, which include rules for auto-approvng patches within days or their release.

# Dependency Monitoring
To monitor dependent resource. if dependent resource gets unavailable, take actions(SNS and/or OpsItem)
