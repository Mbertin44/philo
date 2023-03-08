# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: momo <momo@student.42.fr>                  +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/03/01 09:26:09 by momo              #+#    #+#              #
#    Updated: 2023/03/01 13:46:19 by momo             ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME		=	philo
NAME_BONUS	=	philo_bonus
BONUS_PATH	=	src_bonus/
LIBFT_PATH	=	libft
LIBFT		=	libft/libft.a
SRCS_PATH	=	src/
# ARG			=	infile "/bin/cat" "grep e" "wc -l" outfile

CC		=	gcc
CFLAGS	=	-g -Wall -Werror -Wextra
RM		=	rm -f

SRCS		=	$(SRCS_PATH)philo.c

# SRCS_BONUS	=	$(BONUS_PATH)pipex_bonus.c				\
# 				$(BONUS_PATH)path_bonus.c				\
# 				$(BONUS_PATH)pipe_and_fork_bonus.c		\
# 				$(BONUS_PATH)pipex_utils_bonus.c		\
# 				$(BONUS_PATH)check_and_redirect_bonus.c	\
# 				$(BONUS_PATH)check_fd_bonus.c			\
# 				$(BONUS_PATH)security_bonus.c			\
# 				$(BONUS_PATH)get_next_line_bonus.c		\

OBJS			= 	${SRCS:.c=.o}
OBJS_BONUS		= 	${SRCS_BONUS:.c=.o}

.c.o:
				@$(CC) $(CFLAGS) -c $< -o $(<:.c=.o)

all:	do_libft $(NAME)

$(NAME):	$(OBJS)
			@echo "Compiling $(NAME) sources"
			@$(CC) $(OBJS) $(LIBFT) $(CFLAGS) -o $(NAME)
			@echo "Done !"

do_libft:
	@$(MAKE) -C $(LIBFT_PATH)

# Removes objects
clean:
				@echo "Removing $(NAME) objects..."
				@$(RM) $(OBJS) $(OBJS_BONUS)
				@echo "Removing libft objects..."
				@make clean -C $(LIBFT_PATH)
				@echo "$(NAME) objects successfully deleted."
				@echo "libft objects successfully deleted."

# Removes objects and executable
fclean: 		clean
				@echo "Removing $(NAME) program..."
				@$(RM) $(NAME)
				@echo "Removing $(NAME_BONUS) program..."
				@$(RM) $(NAME_BONUS)
				@echo "Removing libft archive..."
				@$(RM) $(LIBFT)
				@echo "Executable(s) and archive(s) successfully deleted."

exe:			$(NAME)
				@./philo
# valgrind --leak-check=full --show-leak-kinds=all --track-fds=yes --trace-children=yes ./philo $(ARG)

# Removes objects and executable then remakes all
re: 			fclean all

re_bonus: 		fclean bonus

.PHONY:			all clean fclean bonus re


# ------------------------------- BONUS -------------------------------------

bonus:	do_libft $(NAME_BONUS)

$(NAME_BONUS):	$(OBJS_BONUS)
				@echo "Compiling $(NAME_BONUS) sources"
				@$(CC) $(OBJS_BONUS) $(LIBFT) $(CFLAGS) -o $(NAME_BONUS)
				@echo "Done !"

exe_bonus:		$(bonus)
				valgrind --leak-check=full --show-leak-kinds=all --track-fds=yes --trace-children=yes ./philo $(ARG)