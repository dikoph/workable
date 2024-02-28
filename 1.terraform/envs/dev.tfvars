region = "us-west-2"
environment = "dev"

vpc_name = "mrama"

#create or reuse existing vpc
create_vpc = true
existing_vpc_id=""

vpc_cidr_block = "10.0.0.0/16"
public_subnets = [
  {
    cidr = "10.0.1.0/24"
    az   = "us-west-2a"
  },
  {
    cidr = "10.0.2.0/24"
    az   = "us-west-2b"
  }
]

private_subnets = [
  {
    cidr = "10.0.3.0/24"
    az   = "us-west-2a"
  },
  {
    cidr = "10.0.4.0/24"
    az   = "us-west-2b"
  }
]

# modgoDB
mongoDB_nodes_coount=2
mongoDB_ami = "ami-0895022f3dac85884"
mongoDB_instance_type = "t2.micro"

# deploy managed mongoDB (documentDB)
managed_mondoDB = true

# documentDB
cluster_name = "mrama-docdb"
master_username = "mrama"
db_instance_class = "db.t3.medium"
instance_count = "2"

#rds postgres
rds_username = "mrama"
replica_count = 1
storage_type = "gp2"
engine_version = "16.2"
master_instance_class = "db.t3.micro" 
slave_instance_class = "db.t3.micro"

