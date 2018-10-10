echo "now push image to ECR"
echo "image=${projectName}"
echo "registryUrl:${registryUrl}"

if aws ecr describe-repositories | grep "${projectName}\""
then
  echo "repository already exists"
else
  aws ecr create-repository --repository-name ${projectName}
fi
$(aws ecr get-login --no-include-email --region us-east-2)
docker tag ${projectName} ${registryUrl}/${projectName}
docker push ${registryUrl}/${projectName}
echo "image pushed"
