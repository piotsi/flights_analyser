# Flights Analyser

[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/piotsik/project/general)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=piotsik%2Fproject&benchmark=INFRASTRUCTURE+SECURITY)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/piotsik/project/cis_aws)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=piotsik%2Fproject&benchmark=CIS+AWS+V1.2)

# Prerequisites
- Installed Terraform
- Installed Ansible
- Installed AWS CLI
    - Make sure you are in the same region you have deployed resources using Terraform (aws configure)
- Existing S3 bucket

## Steps
1. `terraform init`
2. `terraform apply`
3. Provide NIFI sensitive properties key 
4. ssh tunnel (access NiFi instance) [for data flow editing]
    - Forward port from the instance to your machine: 
    `ssh -i myKey.pem -L 8443:localhost:8443 ec2-user@$(terraform output -raw ec2_kafka_client_public_ip)`
    - Get NiFi credentials: 
    `grep Generated /opt/nifi/logs/nifi-app*log`
    - Go to `127.0.0.1:8443/nifi` (not localhost:8443!)
    - Copy flow (optional):
    `scp -i myKey.pem ec2-user@$(terraform output -raw ec2_kafka_client_public_ip):/opt/nifi/conf/flow.xml.gz .`
5. Update Glue ETL script
    - `aws s3 cp script.py $(terraform output -raw s3_glue_script)`

## Approximate deployment and destroying time
- deployment: around 30 minutes
- destroying: around 3 minutes (sometimes will have to remove manually network interfaces created by glue)

## Graph of the infrastructure
![graph](https://github.com/piotsik/flights_analyser/blob/main/images/graph.png)

## Logical model of the data warehouse
![logical model](https://github.com/piotsik/flights_analyser/blob/main/images/logicalmodel.png)

## Checklist
- [x] Terraform: miscellaneous (VPC, IAM)
- [x] Terraform: NiFi
- [x] Nifi: Data Flow
- [x] Terraform: Glue
- [x] Terraform: Redshift
- [x] Ansible: Redshift
- [ ] ~~Datadog~~ (abandoded)
- [ ] ~~Elasticsearch~~ (abandoded)
