#!/bin/sh

SRC="https://raw.githubusercontent.com/tasmota/decode-config/development/decode-config.py"
DIR="/home/pi/tasmota"
CONFIG_DIR="${DIR}/configs"

mkdir -p ${CONFIG_DIR}
curl -s $SRC -o ${DIR}/decode-config.py

for ip in `$DIR/tasmota-discover | grep " : " | awk '{print $1}'`; do 
    $DIR/decode-config.py -d $ip --backup-file $CONFIG_DIR/@H-$ip-@f-@v.json --backup-type json
    $DIR/decode-config.py -d $ip --backup-file $CONFIG_DIR/@H-$ip-@f-@v.dmp --backup-type dmp
done
