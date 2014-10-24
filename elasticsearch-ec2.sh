#! /bin/bash

# usage: . CLUSTER_NAME ACCESS_KEY SECRET_KEY BUCKET_NAME AWS_REGION


if [ "$(whoami)" != "root" ]; then
	echo "Sorry, you are not root."
	exit 1
fi

wget http://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-0.20.2.zip
unzip elasticsearch-0.20.2 -d /usr/local/elasticsearch
rm elasticsearch-0.20.2.zip

cd /usr/local/elasticsearch/elasticsearch-0.20.2/
bin/plugin -install elasticsearch/elasticsearch-cloud-aws/1.4.0


echo "cluster.name: $0" > /usr/local/elasticsearch/elasticsearch-0.20.2/config/elasticsearch.yml
echo "cloud:" >> /usr/local/elasticsearch/elasticsearch-0.20.2/config/elasticsearch.yml
echo "    aws:" >> /usr/local/elasticsearch/elasticsearch-0.20.2/config/elasticsearch.yml
echo "        access_key: $1" >> /usr/local/elasticsearch/elasticsearch-0.20.2/config/elasticsearch.yml
echo "        secret_key: $2" >> /usr/local/elasticsearch/elasticsearch-0.20.2/config/elasticsearch.yml
echo "        region: $4" >> /usr/local/elasticsearch/elasticsearch-0.20.2/config/elasticsearch.yml
echo "discovery:" >> /usr/local/elasticsearch/elasticsearch-0.20.2/config/elasticsearch.yml
echo "    type: ec2" >> /usr/local/elasticsearch/elasticsearch-0.20.2/config/elasticsearch.yml
echo "repositories:" >> /usr/local/elasticsearch/elasticsearch-0.20.2/config/elasticsearch.yml
echo "    s3:" >> /usr/local/elasticsearch/elasticsearch-0.20.2/config/elasticsearch.yml
echo "        bucket: $3" >> /usr/local/elasticsearch/elasticsearch-0.20.2/config/elasticsearch.yml
echo "        region: $4" >> /usr/local/elasticsearch/elasticsearch-0.20.2/config/elasticsearch.yml




cd bin
yum install -y git
git clone https://github.com/gileze33/elasticsearch-servicewrapper.git
mv elasticsearch-servicewrapper/service ./
/usr/local/elasticsearch/elasticsearch-0.20.2/bin/service/elasticsearch install
sudo chkconfig elasticsearch on
shutdown -r now