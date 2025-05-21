/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   client.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: marvin <marvin@student.42.fr>              +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/05/21 03:45:31 by marvin            #+#    #+#             */
/*   Updated: 2025/05/21 03:45:31 by marvin           ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libft/libft.h" // for ft_atoi and ft_printf
#include <signal.h>

static void	send_signal(int	num, int pid)
{
	int	bytes[8];
	int	i;

	i = 0;
	while (i < 8)
		bytes[i++] = 0;
	i = 0;
	while (num > 0)
	{
		bytes[i++] = num % 2;
		num /= 2;
	}
	i = 7;
	while (i >= 0)
	{
		if (bytes[i--])
			kill(pid, SIGUSR1);
		else
			kill(pid, SIGUSR2);
		usleep(500);
	}
}

int	main(int ac, char **av)
{
	int		pid;
	char	*msg;
	char	*str;
	int		i;

	i = 0;
	str = av[1];
	if (ac == 3)
	{
		while (str[i])
		{
			if (!(str[i] >= '0' && str[i] <= '9'))
				return (1);
			i++;
		}
		pid = ft_atoi(av[1]);
		msg = av[2];
		while (*msg)
			send_signal((int)*msg++, pid);
	}
	return (0);
}
