#! /bin/bash
arr_csv=() 
while IFS= read -r line 
do
    arr_csv+=("$line")
done < /var/lib/jenkins/workspace/csvfiletest/app/ip.csv

echo "Displaying the contents of array mapped from csv file:"
index=0
for record in "${arr_csv[@]}"
do
    echo "Record at index-${index} : $record"
	((index++))
done