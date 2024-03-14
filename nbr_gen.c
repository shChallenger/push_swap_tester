/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   nbr_gen.c                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: shChallenger <shChallenger@student.42.fr>  +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/03/14 06:25:07 by shChallenger      #+#    #+#             */
/*   Updated: 2024/03/14 06:25:54 by shChallenger     ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "nbr_gen.h"

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

void	ft_create_show_random_array(const unsigned short QUANTITY)
{
	unsigned int	array[QUANTITY];
	unsigned int	rdm_nbr;
	unsigned short	i;
	unsigned short	j;

	i = 0;
	while (i != QUANTITY)
	{
		rdm_nbr = ft_get_rdm_nbr();
		j = 0;
		while (j != i)
		{
			if (array[j] == rdm_nbr)
				break ;
			j++;
		}
		if (j == i)
			array[i++] = rdm_nbr;
	}
	ft_show_array(array, QUANTITY);
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
		srand(ft_get_ms_time());
		ft_create_show_random_array(quantity);
	}
	return (0);
}
