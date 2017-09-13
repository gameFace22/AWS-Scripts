#!/bin/bash 

#nobucketfound="bucket does not exist"

echo "[*]Checking if AWS credentials are present"
sleep 1
#Add test to check if the ~/.aws/config file is present

#Add test to check if the bucket name is valid/present or not

directorylisting()
{
 echo "[*]Checking if AWS Bucket has directory listing enabled"
 sleep 1
 touch aws-test.txt
 aws s3 ls s3://$1 > aws-test.txt 
 count=$(wc -l aws-test.txt | awk '{print $1}')
 #echo $count
 if [ $count -gt 0 ] ; then
  printf "\033[1;31m[+]Found Directory Listing in bucket $1\033[0m\n"
  echo "[*]Files/Directories Found"
  cat aws-test.txt | awk '{print $4}' | sed -e 's/^/[+]/'
  rm aws-test.txt
 else 
  printf "\033[1;31m[-]Directory Listing has been disabled in $1\033[0m\n"
 fi
}

directorylisting

