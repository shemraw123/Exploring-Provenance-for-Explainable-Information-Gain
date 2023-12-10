#!/bin/bash

if [ "$#" != 1 ]; then
        echo "takes one parameter that is the query file"
        exit 1
else
        QUERYFILE=$1
fi

if [ ! -f ${QUERYFILE} ]; then
        echo "${QUERYFILE} does not exit"
        exit 1
fi

# echo $PATH
# set number of repetitions

REPETITIONS=3

# Loop up to Repetition
i=1;
#totalsum=0.0;

while [ ${i} -le ${REPETITIONS} ]
do
#	echo "${i} of ${REPETITIONS}"
	start=$(date +%s.%N)
	/usr/local/pgsql/bin/psql -p 5439 -f ${QUERYFILE} >&/dev/null
	end=$(date +%s.%N)
	result=$(echo "scale=3; $end - $start" | bc)
	# echo "Runtime is ${result}"

	if [ -n "${result}" ]; then
          
	  echo ${result}
          i=`expr ${i} + 1`
	
	elif [ -z "${result}" ]; then
	
	  if [ ${i} -eq 4 ]; then
	    exit 1
	  else
	    echo "1800.00"
	    i=`expr ${i} + 1`
	  fi

	fi 

#	totalsum=`echo $result + $totalsum | bc`
#	echo "Current total sum is ${totalsum}"
done


