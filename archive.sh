#!/usr/bin/bash

op_email=

read -s -p "Enter email for 1Password account: " op_email
echo

eval $(op signin my.1password.com $op_email)

mkdir -p archive && cd archive
mkdir -p documents
mkdir -p op
echo "Copying /Users/john/Documents/"
cp -R /Users/john/Documents/ documents/

echo "Saving 1Password items. This might take a while...."
ITEMS=()
for row in $(op list items | jq -r '.[] .uuid');
do
  item=$(op get item ${row})
  ITEMS+=(${item})
done
echo ${ITEMS[@]} | jq -sc . > op/op_output.json


echo "Saving 1Password documents. This might take a while...."
mkdir -p op/op_documents
cd op/op_documents/
arr=$(op list documents | jq  -c '.[] | "\(.uuid) \(.overview."title")"')
IFS=$'\n'
for doc in $arr;
do
  target=$(echo $doc | awk ' { print substr($1,2) } ')
  file_name=$(echo $doc | awk ' { split($0,a," - "); print substr(a[1],29) }')
  op get document $target > "$(echo $file_name)"
done
cd ../../../
echo "Compressing archive..."
tar -zcf archive.tar.gz archive
echo "Deleting archive"
rm -rf archive
echo "Archive created!"