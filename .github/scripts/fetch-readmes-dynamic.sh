#!/bin/bash

headers=( $(ls ./readmes/headers/) )
echo "Headers located: ${headers[@]}"

for header in "${headers[@]}"
do
  echo Checking $header ...
  second_line=$( sed '2!d' "./readmes/headers/"$header )
  readme_source="${second_line#*:}"
  echo $readme_source
  wget $readme_source -O "./readmes/temp/"$header
  echo $header loaded
  cat ./readmes/headers/$header ./readmes/temp/$header > ./content/readmes/$header
  echo $header content page created
done


