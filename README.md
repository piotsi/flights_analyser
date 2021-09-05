# Flights Analyser

[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/piotsik/project/general)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=piotsik%2Fproject&benchmark=INFRASTRUCTURE+SECURITY)
[![Infrastructure Tests](https://www.bridgecrew.cloud/badges/github/piotsik/project/cis_aws)](https://www.bridgecrew.cloud/link/badge?vcs=github&fullRepo=piotsik%2Fproject&benchmark=CIS+AWS+V1.2)

1. `terraform init`
2. `terraform apply`
3. ssh tunnel (access NiFi instance)
    - Establish connection: `ssh -i myKey.pem -L $port:localhost:$port ec2-user@$ip`
    - Get NiFi credentials: `grep Generated /opt/nifi/logs/nifi-app*log`
    - Go to: `127.0.0.1:$port/nifi`