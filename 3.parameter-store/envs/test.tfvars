region = "us-west-2"
environment = "test"

vpc_name = "mrama"

#create or reuse existing vpc
create_vpc = true
existing_vpc_id=""

vpc_cidr_block = "10.0.0.0/16"
public_subnets = [
  {
    cidr = "10.0.5.0/24"
    az   = "us-west-2a"
  },
  {
    cidr = "10.0.6.0/24"
    az   = "us-west-2b"
  }
]

private_subnets = [
  {
    cidr = "10.0.7.0/24"
    az   = "us-west-2a"
  },
  {
    cidr = "10.0.8.0/24"
    az   = "us-west-2b"
  }
]

# modgoDB
mongoDB_nodes_coount=3
mongoDB_ami = "ami-0895022f3dac85884"
mongoDB_instance_type = "t2.micro"

# deploy managed mongoDB
managed_mondoDB = true

# documentDB
cluster_name = "docdb"
master_username = "dion"
# master_password = "password"
db_instance_class = "db.t3.medium"
instance_count = "3"

#rds postgres
rds_username = "dionysis"
# rds_password = "password123!"
replica_count = 2
storage_type = "gp2"
engine_version = "16.2"
master_instance_class = "db.t3.micro" 
slave_instance_class = "db.t3.micro"