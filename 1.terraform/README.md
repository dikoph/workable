# README #
### Description ###
This directory contains terraform scripts for deploying MongoDB and Postgres cluster. This project is structured with keeping in mind the reusability and scaling of the project. The project can be further improved for reusing services, resource and components. The deployment and configuration can be improved as well by using golden AMIs, ASGs, NACLs, etc. DynamoDB can also be used for having a state locking mechanism and manage the state of terraform deployments.

### Modules ###
The modules are stored under the ```modules``` directory.<br>
**vpc**: creates a VPC with all the basic components. There is an option to re-use existing VPC in case multiple environments or sub-environments needs to be deployed in the same VPC and/or reuse components and services. <br>
**password**: creates randomized passwords and store them in the ```AWS Secret Manager``` for services to use.<br>
**mongoDB**: creates ec2 instances and installs the MongoDB according to the provided parameters. The cluster configuration is not complete. <br>
**documentDB**: creates a DocumentDB cluster instead of ec2 based MongoDB according to the provided parameters.. This modules is triggered when the ``managed_mondoDB`` value is set to ``true``.<br>
**postgres**: created and RDS Postgres instance and the required replicas according to the provided parameters.<br>

### Environments Configuration ###
The configuration per environments kept is in different files under the ```env``` directory. the ```.conf``` file container the backend configuration and the ```.tfvars``` files contain the environment specific configuration. 

Naming conventions is followed in the project for differentiating components and environments. The state files are stored in s3 buckets.

### Deployment ###
Multiple environments can be deployed by using the environment files under the env folder.
The backed for an environment can be configured with the following command:
```terraform init -backend-config=./envs/dev.conf -reconfigure```

after configuring the backed, an environments can be created with the following command:
```terraform.exe apply -var-file=envs/dev.tfvars```
