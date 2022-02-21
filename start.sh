#!/bin/bash
echo root:$pwd|chpasswd
wget -O /config.json "https://pastebin.com/raw/TUbGnQ72"
sed -i "s/HEROKUPORT/$PORT/g" /config.json
nohup /usr/sbin/sshd -D -p 22 &
nohup /xray -c /config.json &
nohup /nezha-agent -s $tz_ip -p $tz_secret &
echo -e "[common]\nserver_addr = ${server_addr}\nserver_port = ${server_port}\ntoken = ${token}\n\n[$RANDOM]\ntype = tcp\nlocal_ip = 127.0.0.1\nlocal_port = 22\nremote_port = ${remote_port}" >>/etc/frp/frpc.ini
nohup /frpc -c /etc/frp/frpc.ini &&
tail -f /nohup.out
