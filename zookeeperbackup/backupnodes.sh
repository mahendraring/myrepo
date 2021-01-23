todate=`date +'%d%m%y%H%M%S'`

server=XXXXXXXXXXX

port=2181

mkdir zookeeperbkpfiles/$todate

mkdir zookeeperbkpfiles/$todate/encrypted

mkdir zookeeperbkpfiles/$todate/decrypted

for node in `cat ./nodes.csv`do

node_file_name=`echo $node|cut -f 3,4 -d '/' --output-delimiter='_'`

zookeeper/bin/zkCli.sh -server $server:$port get $node   > zookeeperbkpfiles/$todate/org$node_file_name.log

sed -n '25p' zookeeperbkpfiles/$todate/org$node_file_name.log > zookeeperbkpfiles/$todate/encrypted/$node_file_name.log

base64 -d zookeeperbkpfiles/$todate/encrypted/$node_file_name.log >  zookeeperbkpfiles/$todate/decrypted/$node_file_name.log.txt

done
