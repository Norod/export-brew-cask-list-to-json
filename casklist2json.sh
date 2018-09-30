#!/bin/bash

echo "Generate a json information file for each installable brew cask package"

JSON_OUTPUT_FOLDER="./json"

echo "Files will be saved at ${JSON_OUTPUT_FOLDER}"

mkdir ${JSON_OUTPUT_FOLDER}

casks=$(brew search --casks)

count=0;
for cask in $casks; do
	count=$((count+1))
done 

num_of_casks=$count

echo "There are ${num_of_casks} installable brew cask packages"
echo " "

index=0

for cask in $casks; do
	index=$((index+1))
    jsoninfo=$(brew cask info $cask --json=v1)
    jsondict=$(echo ${jsoninfo} | sed 's:^.\(.*\).$:\1:')
    jsonfile="${JSON_OUTPUT_FOLDER}/${cask}.json"
    echo -e "${cask} --> ${jsonfile} \t [${index}/${num_of_casks}]"
    echo $jsondict > $jsonfile
done

echo " "
echo "Done"
