echo "now create cluster"
if aws ecs describe-clusters --cluster ${clusterName} | grep "MISSING"
then
  aws ecs create-cluster --cluster-name ${clusterName}
fi
