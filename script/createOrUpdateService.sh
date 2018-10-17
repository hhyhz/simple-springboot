
echo "now create service"
echo "projectName=${projectName}"
echo "desiredCount=${desiredCount}"
echo "port=${containerPort}"
echo ""
echo "cluster:${clusterName}"
echo "service:${serviceName}"
echo "task:${taskFamily}"
echo "subnets:${subnet1},${subnet2}"
echo "securityGroup:${securityGroup}"
echo "loadBalancer:${loadBalancerArn}"
echo "targetGroup:${targetGroupArn}"

aws elbv2 create-listener --load-balancer-arn ${loadBalancerArn} --protocol HTTP --port ${containerPort} --default-actions Type=forward,TargetGroupArn=${targetGroupArn}

if aws ecs describe-services --service ${serviceName} --cluster ${clusterName} | grep "INACTIVE"
then
  aws ecs create-service --cluster ${clusterName} --service-name ${serviceName} --task-definition ${taskFamily} --desired-count ${desiredCount} --launch-type "FARGATE" --network-configuration "awsvpcConfiguration={subnets=[${subnet1},${subnet2}],securityGroups=[${securityGroup}],assignPublicIp=ENABLED}" --load-balancers targetGroupArn=${targetGroupArn},containerName=${projectName},containerPort=${containerPort}
elif aws ecs describe-services --service ${serviceName} --cluster ${clusterName} | grep "MISSING"
then
  aws ecs create-service --cluster ${clusterName} --service-name ${serviceName} --task-definition ${taskFamily} --desired-count ${desiredCount} --launch-type "FARGATE" --network-configuration "awsvpcConfiguration={subnets=[${subnet1},${subnet2}],securityGroups=[${securityGroup}],assignPublicIp=ENABLED}" --load-balancers targetGroupArn=${targetGroupArn},containerName=${projectName},containerPort=${containerPort}
else
  aws ecs update-service --service ${serviceName} --task-definition ${taskFamily} --cluster ${clusterName} --desired-count ${desiredCount}
fi
