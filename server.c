/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   server.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: nanasser <nanasser@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025/05/21 20:24:06 by nanasser          #+#    #+#             */
/*   Updated: 2025/05/21 20:25:46 by nanasser         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "Libft/libft.h" // for ft_atoi and ft_printf
#include <signal.h> // for server signals

void	handler(int sig)
{
	static char	byte;
	static int	bits;

	byte <<= 1;
	bits++;
	if (sig == SIGUSR1)
		byte |= 1;
	if (bits == 8)
	{
		ft_putchar_fd(byte, 1);
		byte = 0;
		bits = 0;
	}
}

int	main(int ac, char **av)
{
	int	pid;

	(void)av;
	if (ac == 1)
	{
		pid = getpid();
		ft_printf("PID %d\n", pid);
		ft_printf("Awaiting Prompt...\n");
		while (ac == 1)
		{
			signal(SIGUSR1, handler);
			signal(SIGUSR2, handler);
			pause();
		}
	}
	else
	{
		ft_printf("real funny. Run ./server\n");
		return (0);
	}
	return (0);
}
