# MISC
ternary commands work in tf
terraform state list



# COMMANDS
### run when you clone down
terraform init

### kind of like git status
terraform plan

### deploy
terraform apply
terraform destroy
terraform destroy -target <resource_type>.<name>

### format and validate
terraform fmt
terraform validate

### get info on state
terraform show  // get all state
terraform state list  // list each resource in state
terraform state show aws_security_group.allow_my_ip   // show a specific resource



# VARIABLES
variable "someVar" {
    type = string
    description = "shows during tf plan"
    default = "whatever"
}
## using a var
resource "aws_vpc" "myvpc" {
    cidr_block = ""
    tags = {
        Name = var.someVar
    }
}


# OUTPUTS
output "myOutput" {
    value = resourcename.name.attribute
}


# CREATE MULTIPLE INSTANCES
module "ec2" {
    source = "./ec2"
    for_each = toset(["dev", "stage", "prod"])
}


# EC2
copy ami from the aws console (launch ec2 instance, pick top ami)

provider "aws" {
    region = ""
}

resource "aws_instance" "ec2" {
    ami = ""
    instance_type = ""
    security_groups = [aws_security_group.web_traffic.name]
    depends_on = [aws_instance.other_instance_you_need_first]
    count = 5  // create multi instance


## ELASTIC IP
elastic IPs don't change on rebuild

resource "aws_eip" "elastic_ip" {
    instance = "aws_instance.ec2.id"
}
### use eip
output "EIP" {
    value = "aws_eip.elastic_ip.public_ip"
}


# SECURITY GROUPS
## allows stateful connection, inbound and outbound
resource "aws_security_group" "web_traffic" {
    name = "Allow HTTPS"

    ingress {
        from_port = 443
        to_port = 443
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        same as above
    }
}


# DYNAMIC BLOCKS
### iterates over a list to create tf code
variable "ingressRules" {
    type = list(number)
    default = [443, 53, 8080]
}

### can use the following inside a security group block
dynamic "ingress" {
    iterator = port
    for_each = var.ingressRules
    content{
        from_port = value.port
        to_port = value.port
        protocol = "TCP"
        cidr_blocks = [0.0.0.0/0]
    }
}


# MODULES
### must run init any time module is changed
module "ec2module" {
    source = "./ec2/"  // everything in this folder gets imported
    varName = "Whatever"  // dynamically assign vars inside module
}

### using output of module
output "module_output" {
    value = module.ec2module.output_var_name
}


# RDS
resource "aws_db_instance" "myRDS" {
    db_name = "name of the actual database"
    identifier = "name of the RDS instance"
    instance_class = ""
    engine = "mariadb"
    engine_version = ""
    username = ""
    password = ""
    port = ""
    allocated_storage = 20
    skip_final_snapshot = true
}


# REMOTE BACKEND
### stores your state as a backup somewhere else
terraform {
    backend "s3" {
        bucket = "s3 bucket name"
        key = "folder/state.tfstate" // folder path where you want to store state file
        region = 
        access_key = 
        secret_key = 
    }
}


# IMPORTING
### gives tf control of a resource already setup in console
terraform import aws_vpc.myvpc vpcid


# DATA SOURCES
### get data from anywhere in AWS
data "aws_instance" "dbsearch" {
    filter {
        name = "tag:Name"
        values = ["instance_tag_name"]
    }    
}
output "dbsearcher" {
    value = data.dbsearch.availability_zone
}
