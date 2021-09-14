#!/bin/bash
echo hello

headers=( $(ls ./readmes/headers/) )
echo "Headers located: ${headers[@]}"

for header in "${headers[@]}"
do
  echo Checking $header ...
  wget $( sed '2!d' "./readmes/headers/"$header ) -O "./readmes/temp/"$header
  echo $header loaded
  cat ./readmes/headers/$header ./readmes/temp/$header > ./content/readmes/$header
  echo $header content page created
done


