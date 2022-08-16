#! /bin/bash
arr_csv=() 
echo "First arg: $1"
echo "Second arg: $2"
echo "Third arg: $3"
echo "List of all arg: $@"
while IFS= read -r line 
do
    arr_csv+=("$line")
done < /var/lib/jenkins/workspace/csvfiletest/app/ip.csv

echo "Displaying the contents of array mapped from csv file:"
index=0
for record in "${arr_csv[@]}"
do
    echo "Ip-${index} : $record"
	((index++))
done
