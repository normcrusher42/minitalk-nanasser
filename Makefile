# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: nanasser <nanasser@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/05/21 20:30:10 by nanasser          #+#    #+#              #
#    Updated: 2025/05/21 20:30:12 by nanasser         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

OBJ_PATH = obj/
LIBFT_PATH = libft/

NAME = client
NAME2 = server
LIBFT = $(LIBFT_PATH)libft.a

SRC = client.c
SRC2 = server.c

OBJ = $(SRC:%.c=$(OBJ_PATH)%.o)
OBJ2 = $(SRC2:%.c=$(OBJ_PATH)%.o)

CC		=		cc

CFLAGS	= -Wall -Werror -Wextra

RED=\033[0;31m
GREEN=\033[0;32m
BGREEN=\033[1;32m
YELLOW=\033[0;33m
WHITE=\033[0;37m

MAKEFLAGS += --no-print-directory

SPINNER = \
	( \
		i=0; \
		while kill -0 $$! 2>/dev/null; do \
			case $$((i % 6)) in \
				0) c="\033[0;31m|" ;; \
				1) c="\033[0;33m/" ;; \
				2) c="\033[0;32m-" ;; \
				3) c="\033[0;36m\\" ;; \
				4) c="\033[0;34m|" ;; \
				5) c="\033[0;35m/" ;; \
			esac; \
			printf "\r$(WHITE)Client Make on the way... $$c"; \
			i=$$(expr $$i + 1); \
			sleep 0.1; \
		done; \
		printf "\r\033[K$(WHITE)Client program is $(BGREEN)ready! ✅\033[0m\n"; \
	)

SPINNER2 = \
	( \
		i=0; \
		while kill -0 $$! 2>/dev/null; do \
			case $$((i % 6)) in \
				0) c="\033[0;31m|" ;; \
				1) c="\033[0;33m/" ;; \
				2) c="\033[0;32m-" ;; \
				3) c="\033[0;36m\\" ;; \
				4) c="\033[0;34m|" ;; \
				5) c="\033[0;35m/" ;; \
			esac; \
			printf "\r$(WHITE)Server Make on the way... $$c"; \
			i=$$(expr $$i + 1); \
			sleep 0.1; \
		done; \
		printf "\r\033[K$(WHITE)Server program is $(BGREEN)ready! ✅\033[0m\n"; \
		msg="Full Build Fini!"; \
		len=$$(printf "%s" "$$msg" | wc -c); \
		j=1; \
		spaces="      "; \
		while [ $$j -le $$len ]; do \
			char=$$(printf "%s" "$$msg" | cut -c $$j); \
			case $$((($$j - 1) % 6)) in \
				0) color="\033[0;31m" ;; \
				1) color="\033[0;33m" ;; \
				2) color="\033[0;32m" ;; \
				3) color="\033[0;36m" ;; \
				4) color="\033[0;34m" ;; \
				5) color="\033[0;35m" ;; \
			esac; \
			printf "\r$$spaces$$color%s\033[0m" "$$(printf "%s" "$$msg" | cut -c 1-$$j)"; \
			sleep 0.05; \
			j=$$(expr $$j + 1); \
		done; \
		printf "\n"; \
	)


SPINNERLIB = \
	( \
		i=0; \
		while kill -0 $$! 2>/dev/null; do \
			case $$((i % 6)) in \
				0) c="\033[0;31m|" ;; \
				1) c="\033[0;33m/" ;; \
				2) c="\033[0;32m-" ;; \
				3) c="\033[0;36m\\" ;; \
				4) c="\033[0;34m|" ;; \
				5) c="\033[0;35m/" ;; \
			esac; \
			printf "\r$(WHITE)Libft Make on the way... $$c"; \
			i=$$(expr $$i + 1); \
			sleep 0.1; \
		done; \
		printf "\r\033[K$(WHITE)Libft is $(BGREEN)ready! ✅\033[0m\n"; \
	)

all: $(NAME) $(NAME2)

$(NAME): $(LIBFT) $(OBJ_PATH) $(OBJ)
	@{ \
		$(CC) $(CFLAGS) $(OBJ) $(LIBFT) -o $(NAME); \
	} & \
	$(SPINNER)

$(NAME2): $(LIBFT) $(OBJ_PATH) $(OBJ2)
	@{ \
		$(CC) $(CFLAGS) $(OBJ2) $(LIBFT) -o $(NAME2); \
	} & \
	$(SPINNER2)

$(LIBFT):
	@{ \
		make -C $(LIBFT_PATH) all; \
	} & \
	$(SPINNERLIB)

$(OBJ_PATH)%.o : %.c
	@$(CC) $(CFLAGS) -c $< -o $@

$(OBJ_PATH):
	@mkdir -p $(OBJ_PATH)

clean:
	@rm -rf $(OBJ_PATH)
	@make clean -C $(LIBFT_PATH)
	@echo "$(BGREEN)cleaned like the blackhole you're getting if you DON'T GET TO COOKING$(WHITE)"

fclean: clean
	@rm -f $(NAME) $(NAME2)
	@rm -f $(LIBFT)

re: fclean $(NAME) $(NAME2)

.PHONY: all clean fclean re