todate=`date +'%d%m%y%H%M%S'`

server=XXXXXXXX

port=2181

mkdir -p zookeeperbkpfiles/nodeslist 

> zookeeperbkpfiles/nodeslist/allnodes.csv

zookeeper/bin/zkCli.sh -server $server:$port ls /   > zookeeperbkpfiles/nodeslist/nodes_raw.log

egrep  '^\[' zookeeperbkpfiles/nodeslist/nodes_raw.log > zookeeperbkpfiles/nodeslist/nodes.log

for i in `cat zookeeperbkpfiles/nodeslist/nodes.log |cut -f 2 -d '['|cut -f 1 -d ']'`

do

serviceName=`echo $i |cut -f 1 -d ','`

mkdir -p zookeeperbkpfiles/nodeslist/$serviceName
zookeeper/bin/zkCli.sh -server $server:$port ls /$serviceName > zookeeperbkpfiles/nodeslist/$serviceName/nodes_raw.log

egrep  '^\[' zookeeperbkpfiles/nodeslist/$serviceName/nodes_raw.log > zookeeperbkpfiles/nodeslist/$serviceName/nodes.log

for j in `cat zookeeperbkpfiles/nodeslist/$serviceName/nodes.log |cut -f 2 -d '['|cut -f 1 -d ']'`

do

ConfigName=`echo $j |cut -f 1 -d ','`echo "$serviceName/$ConfigName" >> zookeeperbkpfiles/nodeslist/allnodes.csv

done

done

cp scripts/nodes.csv scripts/nodes.csv_$todate

cp zookeeperbkpfiles/nodeslist/allnodes.csv scripts/nodes.csv 
