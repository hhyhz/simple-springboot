export cur_dir=$(pwd)

file_config=$cur_dir/script/config

currentline=$(cat $file_config | grep "projectName")
export projectName=`echo ${currentline} | cut -d"=" -f2`

currentline=$(cat $file_config | grep "registryUrl")
export registryUrl=`echo ${currentline} | cut -d"=" -f2`

currentline=$(cat $file_config | grep "containerPort")
export containerPort=`echo ${currentline} | cut -d"=" -f2`

currentline=$(cat $file_config | grep "customCpu")
export customCpu=`echo ${currentline} | cut -d"=" -f2`

currentline=$(cat $file_config | grep "customMemory")
export customMemory=`echo ${currentline} | cut -d"=" -f2`

currentline=$(cat $file_config | grep "desiredCount")
export desiredCount=`echo ${currentline} | cut -d"=" -f2`

currentline=$(cat $file_config | grep "loadBalancerArn")
export loadBalancerArn=`echo ${currentline} | cut -d"=" -f2`

currentline=$(cat $file_config | grep "targetGroupArn")
export targetGroupArn=`echo ${currentline} | cut -d"=" -f2`

currentline=$(cat $file_config | grep "subnet1")
export subnet1=`echo ${currentline} | cut -d"=" -f2`

currentline=$(cat $file_config | grep "subnet2")
export subnet2=`echo ${currentline} | cut -d"=" -f2`

currentline=$(cat $file_config | grep "securityGroup")
export securityGroup=`echo ${currentline} | cut -d"=" -f2`

currentline=$(cat $file_config | grep "executionRoleArn")
export executionRoleArn=`echo ${currentline} | cut -d"=" -f2`

currentline=$(cat $file_config | grep "loadBalancerDNS")
loadBalancerDNS=`echo ${currentline} | cut -d"=" -f2`

export clusterName=${projectName}-cluster
export taskFamily=${projectName}-task
export serviceName=${projectName}-service

sh $cur_dir/script/pushToECR.sh

sh $cur_dir/script/createCluster.sh

sh $cur_dir/script/registerTaskDefinition.sh

sh $cur_dir/script/createOrUpdateService.sh

echo "project address:  http://${loadBalancerDNS}:${containerPort}"
