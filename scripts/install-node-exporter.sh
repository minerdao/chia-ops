#!/usr/bin/env bash
currentUser=chia
chiaPath=/home/$currentUser/chia

cd $chiaPath
wget -c https://cs-cn-filecoin.oss-cn-beijing.aliyuncs.com/node-exporter/node_exporter-0.18.1.linux-amd64.tar.gz
chown -R $currentUser:$currentUser node_exporter-0.18.1.linux-amd64.tar.gz
tar xfvz node_exporter-0.18.1.linux-amd64.tar.gz

mv node_exporter-0.18.1.linux-amd64/node_exporter /usr/local/bin/
chmod a+x /usr/local/bin/node_exporter
rm -rf $chiaPath/node_exporter-0.18.1.linux-amd64*

mkdir -p /home/$currentUser/prometheus/run
chown -R $currentUser:$currentUser /home/$currentUser/prometheus

systemctl enable node-exporter
systemctl start node-exporter