

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
			printf "\r$(WHITE)Main Make on the way... $$c"; \
			i=$$(expr $$i + 1); \
			sleep 0.1; \
		done; \
		printf "\r\033[K$(WHITE)Main program is $(BGREEN)ready! ✅\033[0m\n"; \
		echo "$(BGREEN)Full Build Fini!.$(WHITE)"; \
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
			printf "\r$(WHITE)Libft Make on the way... $$c"; \
			i=$$(expr $$i + 1); \
			sleep 0.1; \
		done; \
		printf "\r\033[K$(WHITE)Libft is $(BGREEN)ready! ✅\033[0m\n"; \
	)



all:$(NAME)

$(NAME): $(LIBFT) $(OBJ_PATH) $(OBJ)
	@{ \
		cp $(LIBFT) $(NAME) && \
		ar -rcs $(NAME) $(OBJ) $(OBJ2); \
	} & \
	$(SPINNER)

$(LIBFT):
	@{ \
		make -C $(LIBFT_PATH) all; \
	} & \
	$(SPINNER2)

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