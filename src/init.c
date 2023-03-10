/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   init.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: mbertin <mbertin@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/03/08 09:54:07 by mbertin           #+#    #+#             */
/*   Updated: 2023/03/10 15:05:48 by mbertin          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../includes/philo.h"

void	init_data(t_vault *data, t_philo *philo, int argc, char **argv)
{
	int	i;

	i = -1;
	data->argc = argc;
	data->argv = ft_dbl_ptr_copy(argv);
	data->error = 0;
	data->time_die = 0;
	data->time_eat = 0;
	data->time_sleep = 0;
	data->nbr_time_eat = 0;
	philo->data = data;
	data->death = FALSE;
	get_start_time(data);
	while (++i < data->nbr_philo)
		pthread_mutex_init(&data->forks[i], NULL);
}

bool	init_philo(t_vault *data)
{
	int	i;

	i = -1;
	while (++i < data->nbr_philo)
	{
		data->philo[i].id = i;
		data->philo[i].f_left = UNUSED;
		data->philo[i].f_right = UNUSED;
		data->philo[i].nbr_eat = 0;
		data->philo[i].time_last_eat = 0;
		data->philo[i].data = data;
		if (pthread_create(&data->philo[i].thread, NULL,
				&routine, (void *)&data->philo[i]) != 0)
		{
			data->error = 3;
			return (false);
		}
	}
	return (true);
}
