echo Enter Cluster Name:
read cluster_name

echo Enter Container Name:
read container_name

echo Enter AWS Profile Name:
read profile

region="eu-west-1"

task_id=$(aws ecs list-tasks --cluster ${cluster_name} --service-name ${container_name} --profile ${profile} --region ${region} | jq '.taskArns[]' -r | cut -d'/' -f3)

aws ecs execute-command --cluster ${cluster_name} --task ${task_id} --container ${container_name} --interactive --command "/bin/sh" --profile ${profile} --region ${region}
