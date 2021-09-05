#!/bin/bash -xe
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
yum update -y
yum install python3.7 java-1.8.0-openjdk-devel -y
yum erase awscli -y

cd /opt/
wget https://archive.apache.org/dist/kafka/2.4.0/kafka_2.12-2.4.0.tgz
tar -xzf kafka_2.12-2.4.0.tgz
mv kafka_2.12-2.4.0 kafka

cd /home/ec2-user
wget https://bootstrap.pypa.io/get-pip.py
python3.7 get-pip.py
pip3 install boto3
pip3 install awscli

cd /opt/					           
BASE_URL=$(wget -qO- https://nifi.apache.org/download.html | grep -Eo '(http|https)://[a-zA-Z0-9./?=_-]*' | grep -E 'bin.tar.gz' | head -1) 
NIFI_URL=$(wget $BASE_URL -qO- https://nifi.apache.org/download.html | grep -Eo '(http|https)://[a-zA-Z0-9./?=_-]*' | grep -E 'bin.tar.gz' | head -1)
NIFI_FILE=$(basename $NIFI_URL)
NIFI_DIR=$(echo $NIFI_FILE| awk -F-bin.tar.gz '{print $1}')
wget $NIFI_URL
sudo gunzip -c $NIFI_FILE | sudo tar xvf -
sudo mv $NIFI_DIR nifi  
sudo ./nifi/bin/nifi.sh install
sudo sed -i '/java.arg.3=/ s/=.*/=-Xmx8000m/' ./nifi/conf/bootstrap.conf
sudo ./nifi/bin/nifi.sh start
cp /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.*/jre/lib/security/cacerts /tmp/kafka.client.truststore.jks
echo "security.protocol=SSL" > /opt/kafka/config/client.properties
echo "ssl.truststore.location=/tmp/kafka.client.truststore.jks" >> /opt/kafka/config/client.properties
