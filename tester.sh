#!/bin/bash
cp ../push_swap .
echo "Checking norminette..."
NORMI=$(norminette ../*.c ../*.h)
if [[ $NORMI == *"Error!"* ]]; then
	echo "Norminette failed."
	echo "Final Note: 0"
fi
echo "CHECKER Test, until size 50:"
for ((i=0; i<51; i++)); do
    ARG=$(./nbr_gen $i)
    OUTPUT=$(./push_swap $ARG)
    OUT=$(echo "$OUTPUT" | tr " " "\n")
    LINES_COUNT=$(echo "$OUT" | wc -l)
    if [ "$OUT" == "" ]; then
    	RES="NO_INST"
    else
    	RES=$(echo "$OUT" | ./checker_linux $ARG)
    fi
    echo "Array size $i: $RES (Iterations: $LINES_COUNT)"
    if [ "$RES" != "OK" ] && [ "$RES" != "NO_INST" ]; then
    	echo "Error detected!"
    	echo "Final Note : 0"
    	echo "command: ./push_swap $ARG"
    	rm push_swap
    	exit 1
    fi
done
echo "Instructions Number Test: Size=100"
for ((i=1; i<100; i++)); do
    ARG=$(./nbr_gen 100)
    OUTPUT=$(./push_swap $ARG)
    OUT=$(echo "$OUTPUT" | tr " " "\n")
    LINES_COUNT=$(echo "$OUT" | wc -l)
    RES=$(echo "$OUT" | ./checker_linux $ARG)
    LINES_COUNT=$(($LINES_COUNT+0))
    echo "Test $i/500: $RES (Iterations: $LINES_COUNT)"
    if [ "$RES" != "OK" ] || [ $LINES_COUNT -gt 700 ]; then
    	echo "Error detected!"
    	echo "Final Note : 0"
    	echo "command: ./push_swap $ARG"
    	rm push_swap
    	exit 1
    fi
done
echo "Instructions Number Test: Size=500"
for ((i=1; i<100; i++)); do
    ARG=$(./nbr_gen 500)
    OUTPUT=$(./push_swap $ARG)
    OUT=$(echo "$OUTPUT" | tr " " "\n")
    LINES_COUNT=$(echo "$OUT" | wc -l)
    RES=$(echo "$OUT" | ./checker_linux $ARG)
    LINES_COUNT=$(($LINES_COUNT+0))
    echo "Test $i/100: $RES (Iterations: $LINES_COUNT)"
    if [ "$RES" != "OK" ] || [ $LINES_COUNT -gt 5500 ]; then
    	echo "Error detected!"
    	echo "Final Note : 80"
    	echo "command: ./push_swap $ARG"
    	rm push_swap
    	exit 1
    fi
done
rm push_swap
echo "Congratulations! Tests were successful"
echo "Final Note : 100"
