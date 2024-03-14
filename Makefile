SRC = nbr_gen.c nbr_gen_utils.c

OBJ = $(SRC:.c=.o)

NAME = nbr_gen

CC = clang

CFLAGS = -O3 -Wall -Wextra -Werror

all:	$(NAME)
	make -C ..
	bash tester.sh

$(NAME):	$(OBJ)
	$(CC) -o $(NAME) $(OBJ)

%.o : %.c
	$(CC) -c $(CFLAGS) $?

clean:
	rm -f $(OBJ)

fclean: clean
	rm -f $(NAME)

re: fclean all

.PHONY: all clean fclean re
