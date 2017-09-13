#!/bin/bash

echo "[*]Checking if AWS credentials are present"
sleep 1

if [[ -f ~/.aws/credentials ]] ; then
 echo "[+]Fetching Credentials"
else
 echo "[-]Please Configure AWS CLI"
 exit
fi

#Add test to check if the ~/.aws/config file is present

response=$(curl --write-out %{http_code} --silent --output /dev/null s3.amazonaws.com/$1)
if [ $response -eq 404 ] ; then
 printf "\033[1;31m[-]Please check the bucket name. Bucket not found $1\033[0m\n"
 exit
else
 if [ $response -eq 403 ] ; then
  printf "\033[1;31m[-]No Read Access without Key\033[0m\n"
  aws s3 ls s3://$1 > RESULTS
  printf "\033[1;31m[+]Misconfigured ACL - Access with Any Key in $1\033[0m\n"
  echo "[*]Check RESULTS to view the bucket contents"
 else
  aws s3 ls s3://$1 --no-sign-request > RESULTS
  printf "\033[1;31m[+]Misconfigured ACL - Univeral Access in $1\033[0m\n"
  echo "[*]Check RESULTS to view the bucket contents"
 fi
fi
