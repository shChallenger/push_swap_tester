#!/bin/bash
cp ../push_swap .
for ((i=1; i<501; i++)); do
    ARG=$(./nbr_gen $i)
    RES=$(./push_swap $ARG | ./checker_linux $ARG)
    echo "Array size $i: $RES"
    if [ "$RES" != "OK" ]; then
    	echo "Error detected!"
    	echo "command: ./push_swap $ARG"
    	rm push_swap
    	exit 1
    fi
done
rm push_swap
echo "Congratulations! Tests were successful"
