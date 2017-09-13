#!/bin/bash

#nobucketfound="bucket does not exist"

echo "[*]Checking if AWS credentials are present"
sleep 1
#Add test to check if the ~/.aws/config file is present

response=$(curl --write-out %{http_code} --silent --output /dev/null s3.amazonaws.com/$1)
if [ $response -eq 404 ] ; then 
 printf "\033[1;31m[-]Please check the bucket name. Bucket not found $1\033[0m\n"
 exit
else
 if [ $response -eq 403 ] ; then
  echo "[-]No Read Access"
  printf "\033[1;31m[-]No Read Access to the bucket $1\033[0m\n"
  exit
 fi
fi
 
#Add test to check if the bucket name is valid/present or not
sleep 1
touch aws-test.txt
aws s3 ls s3://$1 > aws-test.txt
printf "\033[1;31m[+]Misconfigured ACL in $1\033[0m\n"
echo "[*]Files/Directories Found"
cat aws-test.txt | awk '{print $4}' | sed -e 's/^/[+]/'
rm aws-test.txt

