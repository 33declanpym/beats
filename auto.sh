curl -O https://raw.githubusercontent.com/Impulss/beats/master/filebeat.yml
curl -O https://raw.githubusercontent.com/Impulss/beats/master/packetbeat.yml 
curl -O https://raw.githubusercontent.com/Impulss/beats/master/topbeat.yml

mkdir -p /etc/pki/tls/certs

cp /tmp/logstash-forwarder.crt /etc/pki/tls/certs/

rpm --import http://packages.elastic.co/GPG-KEY-elasticsearch

cat >/etc/yum.repos.d/elastic-beats.repo <<EOL
[beats]
name=Elastic Beats Repository
baseurl=https://packages.elastic.co/beats/yum/el/\$basearch
enabled=1
gpgkey=https://packages.elastic.co/GPG-KEY-elasticsearch
gpgcheck=1
EOL

yum -y install filebeat packetbeat topbeat

mv filebeat.yml /etc/filebeat/filebeat.yml
mv packetbeat.yml /etc/packetbeat/packetbeat.yml
mv topbeat.yml /etc/topbeat/topbeat.yml

service filebeat start
service packetbeat start
service topbeat start
