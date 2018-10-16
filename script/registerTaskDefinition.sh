echo "now configure taskdefinition.json"

echo $taskFamily
echo $projectName
echo $containerPort
echo $customCpu
echo $customMemory
echo $registryUrl

file_task=$cur_dir/script/taskdefinition.json

sed -i 's/\("family": "\).*/\1'"$taskFamily"'",/g' $file_task
sed -i 's/\("name": "\).*/\1'"$projectName"'",/g' $file_task
sed -i 's/\("containerPort": \).*/\1'"$containerPort"',/g' $file_task
sed -i 's/\("hostPort": \).*/\1'"$containerPort"',/g' $file_task
sed -i 's/\("cpu": "\).*/\1'"$customCpu"'",/g' $file_task
sed -i 's/\("memory": "\).*/\1'"$customMemory"'"/g' $file_task
sed -i 's/\("image": "\).*/\1'"${registryUrl}\/${projectName}"'",/g' $file_task
sed -i 's/\("executionRoleArn": "\).*/\1'"${executionRoleArn}"'",/g' $file_task


echo "now register task definition"
aws ecs register-task-definition --cli-input-json file://$file_task
