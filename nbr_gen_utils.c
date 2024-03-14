/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   nbr_gen_utils.c                                    :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: shChallenger <shChallenger@student.42.fr>  +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/03/14 06:25:07 by shChallenger      #+#    #+#             */
/*   Updated: 2024/03/14 06:25:54 by shChallenger     ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "nbr_gen.h"

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

long long	ft_get_ms_time(void)
{
	struct timeval	tv;

	gettimeofday(&tv, NULL);
	return ((((long long)tv.tv_sec) * 1000) + (tv.tv_usec / 1000));
}
