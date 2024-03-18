#!/bin/bash

RED=$(tput setaf 196)
GREEN=$(tput setaf 10)
CYAN=$(tput setaf 80)
BLUEGREEN=$(tput setaf 50)
NORMAL=$(tput sgr0)
BOLD=$(tput bold)

printError() {
	echo ${RED}
	echo $1
	echo $2
	echo ${NORMAL}
	rm push_swap
	exit 0
}

cp ../push_swap push_swap
#clear
echo "${CYAN}/* **************************************************************** */"
echo "/*             .         __      '        .       '       .         */"
echo "/*       *            _-~  ~-_      .         '      .              */"
echo "/*      .   .        /___  ___\  '             .             .      */"
echo "/*                  / (O)  (o) \         *         ___    *  .      */"
echo "/*        __,-~-~-,/    -..-    \  .-~~-.   __..-~~   ~~-.._        */"
echo "/*     .-~  'V~V~V'\ -v----v-   \/     /.-~  //..  \   \.  '~-._    */"
echo "/*       //.     \.' '\..___..---/    /''    .    '   .   ..        */"
echo "/*                                                                  */"
echo "/*            ${BLUEGREEN}[shChallenger - push_swap_tester]${CYAN}                     */"
echo "/*                                                                  */"
echo "/* **************************************************************** */"
echo ""
echo "${CYAN}Checking norminette...${NORMAL}"
NORMI=$(norminette ../*.c ../*.h)
if [[ $NORMI == *"Error!"* ]]; then
	printError "Norminette failed." "Final Note: 0"
fi
echo "${GREEN} Yep! Normi is good :D${NORMAL}"
echo ""

# # Check if push_swap return Error whe invalid input
# echo "${CYAN}Checking invalid input...${NORMAL}"
# INVALID_INPUT=(
# "" "a" " " "1 1"
# "Hello, wolrd !"
# "0 one 1 2 3"
# "1 1 2 3 4 5 6 7 8 9 10"
# "1 2 3 4 5 6 7 8 9 10 1"
# "2 3 4 5 6 7 8 9 10 1 1"
# "654684 168468 4512 324132 13546 2435464 168468"
# "1 2 2147483647 3 4 5 6 7 8 9 2147483647"
# "-2 -1 0 1 2 3 4 5 6 -1"
# # "-2 -1 0 1 2 3 4 5 6"
# "-2147483649 1 2 3"
# "1 2 3 2147483648"
# "1 2 3 123132131313"
# "1 2 3 1231321313132"
# "1 2 3 12313213131322"
# "1 2 3 1231321313132256468798795")
# LEN=${#INVALID_INPUT[@]}
# EXPECTED="Error$"
# SUCCESSNB=0

# for ((i=0; i<$LEN; i++)); do
# 	OUTPUT=$(./push_swap ${INVALID_INPUT[i]} | cat -e)

# 	# echo "testing input ${INVALID_INPUT[i]}, Output : \"${OUTPUT}\""
# 	echo -ne "Test $i/$LEN: ${INVALID_INPUT[i]}                                   "\\r
# 	sleep 0.1
# 	if [ "$OUTPUT" != "$EXPECTED" ]; then
# 		echo "push_swap does not return \"${EXPECTED}\" with invalid input ${INVALID_INPUT[i]}                                                                                             "
# 	else
# 		((SUCCESSNB++))
# 	fi
# done

# if [ "$SUCCESSNB" == "$LEN" ]; then
# 	echo "${GREEN} Yep! $SUCCESSNB/$LEN Error handling is good :D                                              "
# else
# 	echo "${RED} NOO! $SUCCESSNB/$LEN                                             "
# fi
# echo ""


# # Check if push_swap sorts correctly
# echo "${CYAN}CHECKER Test, until size 300:${NORMAL}"
# for ((i=1; i<301; i++)); do
#     ARG=$(./nbr_gen $i)
#     OUTPUT=$(./push_swap $ARG)
#     OUT=$(echo "$OUTPUT" | tr " " "\n")
#     LINES_COUNT=$(echo "$OUT" | wc -l)
#     if [ "$OUT" == "" ]; then
#     	RES="NO_INST"
#     else
#     	RES=$(echo "$OUT" | ./checker_linux $ARG)
#     fi
#     echo -ne "Array size $i: CHECKER $RES (Complexity: $LINES_COUNT)                 "\\r
#     if [ "$RES" != "OK" ] && [ "$RES" != "NO_INST" ]; then
#     	echo "./push_swap $ARG" > command_log
#     	printError "CHECKER KO ! See command_log for command detail" "Final Note: 0"
#     fi
# done
# echo "${GREEN} Yep! CHECKER is good :D                                              "
# echo ""


# Check if push_swap sorts correctly and meets required performance
SIZE=(3 5 10 100 500)
MAX=(3 12 50 700 5500)
SIGN=("=" "=" "" "")
SUM=0
TESTNB=100
LEN=${#SIZE[@]}
for ((i=0; i<$LEN; i++)); do
	echo -e "${CYAN}Complexity Test: Size=${SIZE[i]}, Awaited <${SIGN[i]} ${MAX[i]}${NORMAL}"
	SUM=0
	MAX_LINES=0		
	if [ "${SIGN[i]}" != "=" ]; then
            MAX[i]=$((MAX[i]-1))
	fi
	for ((j=1; j<$TESTNB; j++)); do
		ARG=$(./nbr_gen ${SIZE[i]})
		OUTPUT=$(.././push_swap $ARG)
		LINES_COUNT=$(echo "$OUTPUT" | wc -l)
		if [ -z "$OUTPUT" ]; then
			RES=$(echo -n "$OUTPUT" | ./checker_linux $ARG) #checker isn't happy with empty string :(
		else
			RES=$(echo "$OUTPUT" | ./checker_linux $ARG)
		fi
		SUM=$((SUM + LINES_COUNT))
		# echo "res = " $RES
		# echo "OUTPUT = " $OUTPUT
		if [ "$LINES_COUNT" -gt "$MAX_LINES" ]; then
            MAX_LINES="$LINES_COUNT"
        fi
		echo -ne "Test $j/$TESTNB: CHECKER $RES (Complexity: $LINES_COUNT)                 "\\r
		if [ "$RES" != "OK" ]; then
			echo "./push_swap $ARG" > command_log
			printError "CHECKER KO ! See command_log for command detail" "Final Note: 80"
		elif [ "$LINES_COUNT" -gt "${MAX[i]}" ]; then
			echo "./push_swap $ARG" > command_log
			printError "TOO MUCH COMPLEXITY ! See command_log for command detail" "Final Note: 80"
		fi
	done
	echo "${GREEN} Passed all $TESTNB tests ! Complexity Size=${SIZE[i]} was good :D               "
	AV=$(echo "scale=2; $SUM / $TESTNB" | bc)
	printf "${GREEN} Average = ${BOLD}%.2f${NORMAL}${GREEN} Max = ${BOLD}%d${NORMAL}\n" "$AV" "${MAX_LINES}"

done

rm push_swap
echo "${CYAN}/* **************************************************************** */"
echo "${GREEN}Congratulations! Tests were successful"
echo "Final Note : ${BOLD}100${NORMAL}"
