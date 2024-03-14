/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   nbr_gen.h                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: shChallenger <shChallenger@student.42.fr>  +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/03/14 06:25:07 by shChallenger      #+#    #+#             */
/*   Updated: 2024/03/14 06:25:54 by shChallenger     ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef NBR_GEN_H

# define NBR_GEN_H

# include <unistd.h>
# include <stdlib.h>
# include <sys/time.h>

// Utils

unsigned int	ft_atous(char *str);
void			ft_putnbr(unsigned int nbr);
unsigned int	ft_get_rdm_nbr(void);
long long		ft_get_ms_time(void);

// Main

void			ft_show_array(unsigned int *array, unsigned short quantity);
void			ft_create_show_random_array(const unsigned short QUANTITY);
void			ft_show_help(char *program_name);

#endif