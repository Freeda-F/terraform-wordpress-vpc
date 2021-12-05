# Creating VPC Architecture For Wordpress In AWS Using Terraform

## Brief description
This script can be used to instal Wordpress in a customized the network configuration of your Amazon VPC using Terraform. Here, we use WordPress software with dedicated database server.WordPress instance has to be a part of public subnet so that it is accessible via Internet. Database should not be accessible from the outside for security purposes. Hence, it will be provisioned inside one of the private seubnet.


## Usage

1) Creation of an Infrastructure as code using Terraform, which automatically creates a VPC

2) In this VPC, we will create 6 subnets: a) 3 public subnets [accessible from outside] b) 3 private subnet [Inaccessible from outside]

3) Create a public route table with Internet gateway for the VPC network to connect with the Internet. Also, a private route table with NAT gateway for instances in private subnet to connect with the Internet.

4) Launch an EC2 instance as a bastion server which is used to SSH into the instances inside both public subnets and privae subnets.

5) Launch an EC2 instance that has WordPress files installed in them and also having a security group that only accepts port 80 connection from the Internet and port 22 from a bastion server. The requirements for installing Wordress will be configured using userdata.

6) Launch an EC2 instance that has MYSQL setup already(this will be setup using userdata) with security group allowing port 3306 in private subnet so that our WordPress VM can connect with the same. Also, it accepts SSH connection from bastion server as well.

## Prerequisites

- [Terraform v1.0.11](https://www.terraform.io/downloads.html)
- IAM user with administrator access to EC2.

## Terraform Installation

```
$ wget https://releases.hashicorp.com/terraform/1.0.11/terraform_1.0.11_linux_amd64.zip
$ unzip terraform_1.0.11_linux_amd64.zip
$ mv terraform /usr/bin/
```
## How to Configure

1. The file variables.tf will contain the variables used in the script. This can be modified according to the requirements in the default parameter. Here is an example below
```
variable "region" {
  default = "us-east-2" #provide your required region here instead of us-east-2
}
```
2. The file set-mysql.sh contains the mysql root password, database-name, database-username and password which can be modified if required. If not modified, MySQL will be spinned up the EC2 instance using the parameters defined in the file (Optional step).
```
#!/bin/bash

sudo yum install mariadb-server -y
sudo /sbin/chkconfig mariadb on
sudo /sbin/service mariadb start
sudo mysqladmin -u root password '123a'                                 ---------------------> #Change your MySQL password here
sudo mysql -u root -p123a                                               ---------------------> #Change your MySQL password here
CREATE DATABASE db;                                                     ---------------------> #Change your DB-name here
sudo mysql -u root -p123a -e  "CREATE DATABASE db DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
use db;                                                                 ---------------------> #Change your DB-name here
create user 'dbuser'@'%' identified by 'wordpress';                    ---------------------> #Change your DB-username here
GRANT ALL ON db.* TO 'dbuser'@'%';                                     ---------------------> #Change your DB-name,DB-username here
FLUSH PRIVILEGES;"
sudo /sbin/service mariadb restart
```

## provisioning:

1. Navigate to the project directory where the files are to be installed and execute the below commands.

```
$ git clone https://github.com/Freeda-F/terraform-wordpress-vpc.git
$ cd terraform-wordpress-vpc
$ terraform init
$ terraform plan
$ terraform apply
```

## Destroying the Infra:

If you require to remove all the created resources using terraform, use the command below.
```
terraform destroy
```

## Result 

Once the script has been executed successfully, you may access the WordPress site to complete the installation using the IP address of the webserver instance created. The installation can be completed by giving the database details in WordPress. 



After giving the the correct DB credentials, you will get the ready to install page. You may click on 'Run the installation' to complete it.




