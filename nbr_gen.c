#include <unistd.h>
#include <stdlib.h>
#include <sys/time.h>

unsigned int	ft_atous(char *str)
{
	unsigned short	result;

	result = 0;
	while (*str == ' ')
		str++;
	while (*str > 47 && *str < 58)
		result = ((result * 5) << 1) + *str++ - 48;
	return (result);
}

void	ft_putnbr(unsigned int nbr)
{
	char	c;

	if (nbr > 9)
	{
		ft_putnbr(nbr / 10);
		c = (nbr % 10) + 48;
	}
	else
		c = nbr + 48;
	write(1, &c, 1);
}

unsigned int	ft_get_rdm_nbr(void)
{
	return (rand() & 0b11111111111111111);
}

void	ft_show_array(unsigned int *array, unsigned short quantity)
{
	unsigned short	i;
	unsigned char	cond;

	i = 0;
	cond = i != quantity;
	while (cond)
	{
		ft_putnbr(array[i++]);
		cond = i != quantity;
		if (cond)
			write(1, " ", 1);
	}
}

void	ft_create_show_random_array(unsigned short quantity)
{
	unsigned int	array[quantity];
	unsigned int	rdm_nbr;
	unsigned short	i;
	unsigned short	j;

	i = 0;
	outer:
	while (i != quantity)
	{
		rdm_nbr = ft_get_rdm_nbr();
		j = 0;
		while (j != i)
		{
			if (array[j] == rdm_nbr)
				goto outer;
			j++;
		}
		array[i++] = rdm_nbr;
	}
	ft_show_array(array, quantity);
}

void	ft_show_help(char *program_name)
{
	unsigned int	length;

	length = 0;
	write(2, "Usage: ", 7);
	while (program_name[length])
		length++;
	write(2, program_name, length);
	write(2, " <quantity>\n", 12);
}

long long	timeInMilliseconds(void)
{
    struct timeval	tv;

    gettimeofday(&tv, NULL);
    return (((long long)tv.tv_sec) * 1000) + (tv.tv_usec / 1000);
}

int	main(int argc, char **argv)
{
	unsigned short		quantity;

	if (argc != 2)
	{
		ft_show_help(argv[0]);
		return (1);
	}
	quantity = ft_atous(argv[1]);
	if (quantity != 0)
	{
		srand(timeInMilliseconds());
		ft_create_show_random_array(quantity);
	}
	return (0);
}
