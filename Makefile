# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: marvin <marvin@student.42.fr>              +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/01/24 18:06:28 by nanasser          #+#    #+#              #
#    Updated: 2025/05/21 01:09:36 by marvin           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

OBJ_PATH = obj/
LIBFT_PATH = libft/

NAME = client
NAME = server
LIBFT = $(LIBFT_PATH)libft.a

SRC = ./client.c server.c \

OBJ = $(SRC:%.c=$(OBJ_PATH)%.o)

CC		=		cc

CFLAGS	= -Wall -Werror -Wextra -g -O3

RED=\033[0;31m
GREEN=\033[0;32m
BGREEN=\033[1;32m
YELLOW=\033[0;33m
WHITE=\033[0;37m

MAKEFLAGS += --no-print-directory

SPINNER = \
	( \
		spin='|/-\\'; \
		i=0; \
		while kill -0 $$! 2>/dev/null; do \
			i=`expr $$i + 1`; \
			case $$i in \
				1) c="|" ;; \
				2) c="/" ;; \
				3) c="-" ;; \
				4) c="\\\\"; i=0 ;; \
			esac; \
			printf "\r$(YELLOW)Main Make on the way... $$c$(WHITE)"; \
			sleep 0.1; \
		done; \
		printf "\r\033[KMain program is $(GREEN)ready! ✅\n"; \
	)

SPINNER2 = \
	( \
		spin='|/-\\'; \
		i=0; \
		while kill -0 $$! 2>/dev/null; do \
			i=`expr $$i + 1`; \
			case $$i in \
				1) c="|" ;; \
				2) c="/" ;; \
				3) c="-" ;; \
				4) c="\\\\"; i=0 ;; \
			esac; \
			printf "\r$(YELLOW)Libft Make on the way... $$c$(WHITE)"; \
			sleep 0.1; \
		done; \
		printf "\r\033[KLibft is $(GREEN)ready! ✅\n$(WHITE)"; \
	)

all:$(NAME)

$(NAME): $(LIBFT) $(OBJ_PATH) $(OBJ)
	@{ \
		cp $(LIBFT) $(NAME) && \
		ar -rcs $(NAME) $(OBJ) $(OBJ2); \
	} & \
	$(SPINNER); \
	status=$$?; \
	if [ $$status -ne 0 ]; then \
		printf "\n$(RED)❌❌ERRRRRRR💢💢💢💢 CHECK THE ERROR ABOVE$(WHITE)"; \
		exit $$status; \
	fi
	@echo "$(BGREEN)Full Build Fini!.$(WHITE)"

$(LIBFT):
	@{ \
		make -C $(LIBFT_PATH) all; \
	} & \
	$(SPINNER2); \
	status=$$?; \
	if [ $$status -ne 0 ]; then \
		printf "\n$(RED)❌❌ERRRRRRR💢💢💢💢 CHECK THE ERROR ABOVE$(WHITE)"; \
		exit $$status; \
	fi

$(OBJ_PATH)%.o : %.c
	@$(CC) $(CFLAGS) -c $< -o $@

$(OBJ_PATH):
	@mkdir -p $(OBJ_PATH)

clean:
	@rm -rf $(OBJ_PATH)
	@make clean -C $(LIBFT_PATH)
	@echo "$(BGREEN)cleaned like the blackhole you're getting if you DON'T GET TO COOKING$(WHITE)"

fclean: clean
	@rm -f $(NAME) 
	@rm -f $(LIBFT)
	@rm -f client server

re: fclean $(NAME)

.PHONY: all clean fclean re