y=$(aws ecr get-login-password --region us-east-2)
docker login --username AWS --password $y accountid.dkr.ecr.us-east-2.amazonaws.com
