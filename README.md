# Flights Analyser

[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/piotsik/project/general)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=piotsik%2Fproject&benchmark=INFRASTRUCTURE+SECURITY)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/piotsik/project/cis_aws)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=piotsik%2Fproject&benchmark=CIS+AWS+V1.2)

# Prerequisites
- Installed Terraform
- Installed Ansible
- Installed AWS CLI
    - Make sure you are in the same region you have deployed resources using Terraform (aws configure)

# Steps:
1. `terraform init`
2. `terraform apply`
3. ssh tunnel (access NiFi instance)
    - Forward port from the instance to your machine: `ssh -i kafkaKey.pem -L 8443:localhost:8443 ec2-user@$(terraform output -raw ec2_kafka_client_public_ip)`
    - Check every 10 seconds if NiFi is up: `while :; do clear; echo 'NiFi listening: ' ; sudo netstat -tlnp | grep 127.0.0.1:8443 | awk '{print $4}'; sleep 10; done`
    - Get NiFi credentials: `grep Generated /opt/nifi/logs/nifi-app*log`
    - Go to: `127.0.0.1:8443/nifi` (not localhost:8443!)
    - (opt) Copy flow `scp -i kafkaKey.pem ec2-user@$(terraform output -raw ec2_kafka_client_public_ip):/opt/nifi/conf/flow.xml.gz .`

# Deployment time:
- 2:42 (as of 12 September 2021)