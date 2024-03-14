#!/bin/bash

RED=$(tput setaf 196)
GREEN=$(tput setaf 10)
CYAN=$(tput setaf 80)
BLUEGREEN=$(tput setaf 50)
NORMAL=$(tput sgr0)

printError() {
	echo ${RED}
	echo $1
	echo $2
	echo ${NORMAL}
	rm push_swap
	exit 0
}

cp ../push_swap .
clear
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
NORMI=$(norminette ..)
if [[ $NORMI == *"Error!"* ]]; then
	printError "Norminette failed." "Final Note: 0"
fi
echo "${GREEN} Yep! Normi was good :D${NORMAL}"
echo ""
echo "${CYAN}CHECKER Test, until size 300:${NORMAL}"
for ((i=0; i<301; i++)); do
    ARG=$(./nbr_gen $i)
    OUTPUT=$(./push_swap $ARG)
    OUT=$(echo "$OUTPUT" | tr " " "\n")
    LINES_COUNT=$(echo "$OUT" | wc -l)
    if [ "$OUT" == "" ]; then
    	RES="NO_INST"
    else
    	RES=$(echo "$OUT" | ./checker_linux $ARG)
    fi
    echo -ne "Array size $i: CHECKER $RES (Complexity: $LINES_COUNT)                 "\\r
    if [ "$RES" != "OK" ] && [ "$RES" != "NO_INST" ]; then
    	printError "CHECKER KO ! See command_log for command detail" "Final Note: 0"
    fi
done
echo "${GREEN} Yep! CHECKER was good :D                                              "
echo ""
echo "${CYAN}Complexity Test: Size=100, Awaited < 700${NORMAL}"
for ((i=1; i<1000; i++)); do
    ARG=$(./nbr_gen 100)
    OUTPUT=$(./push_swap $ARG)
    OUT=$(echo "$OUTPUT" | tr " " "\n")
    LINES_COUNT=$(echo "$OUT" | wc -l)
    RES=$(echo "$OUT" | ./checker_linux $ARG)
    LINES_COUNT=$(($LINES_COUNT+0))
    echo -ne "Test $i/500: CHECKER $RES (Complexity: $LINES_COUNT)                  "\\r
    if [ "$RES" != "OK" ]; then
    	printError "CHECKER KO ! See command_log for command detail" "Final Note: 0"
    elif [ $LINES_COUNT -gt 700 ]; then
    	printError "TOO MUCH COMPLEXITY ! See command_log for command detail" "Final Note: 0"
    fi
done
echo "${GREEN} Yep! Complexity Size=100 was good :D                                  "
echo ""
echo "${CYAN}Complexity Test: Size=500, Awaited < 5500${NORMAL}"
for ((i=1; i<500; i++)); do
    ARG=$(./nbr_gen 500)
    OUTPUT=$(./push_swap $ARG)
    OUT=$(echo "$OUTPUT" | tr " " "\n")
    LINES_COUNT=$(echo "$OUT" | wc -l)
    RES=$(echo "$OUT" | ./checker_linux $ARG)
    LINES_COUNT=$(($LINES_COUNT+0))
    echo -ne "Test $i/100: CHECKER $RES (Complexity: $LINES_COUNT)                  "\\r
    if [ "$RES" != "OK" ]; then
    	printError "CHECKER KO ! See command_log for command detail" "Final Note: 80"
    elif [ $LINES_COUNT -gt 5500 ]; then
    	printError "TOO MUCH COMPLEXITY ! See command_log for command detail" "Final Note: 80"
    fi
done
rm push_swap
echo "${GREEN} Yep! Complexity Size=700 was good :D                                 "
echo "Congratulations! Tests were successful"
echo "Final Note : 100"
echo ${NORMAL}
