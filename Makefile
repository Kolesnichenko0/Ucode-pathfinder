OBJS_FOLDER = obj
INCS_FOLDER = inc
SRCS_FOLDER = src
LIB_FOLDER = libmx
LIB = $(LIB_FOLDER)/libmx.a
NAME = pathfinder
NAME_LIB = MX
INCS := $(wildcard $(INCS_FOLDER)/*.h)
SRCS := $(wildcard $(SRCS_FOLDER)/*.c)
OBJS := $(patsubst $(SRCS_FOLDER)/%.c, $(OBJS_FOLDER)/%.o, $(SRCS))
CC = clang
CFLAGS = -std=c11 -Wall -Wextra -Werror -Wpedantic

.PHONY: all install clean uninstall reinstall

all: install

install: $(NAME_LIB) $(NAME)

$(NAME_LIB):
	make -sC $(LIB_FOLDER)

$(NAME): $(OBJS_FOLDER) $(OBJS) $(LIB)
	$(CC) $(CFLAGS) $(OBJS) -L $(LIB_FOLDER) -lmx -o $@

$(OBJS_FOLDER):
	mkdir $(OBJS_FOLDER)

$(OBJS_FOLDER)/%.o:$(SRCS_FOLDER)/%.c $(INCS)
	$(CC) $(CFLAGS) -I $(LIB_FOLDER)/$(INCS_FOLDER) -I $(INCS_FOLDER) -c $< -o $@

uninstall: clean
	rm -f $(NAME) $(LIB)

clean:
	make -sC $(LIB_FOLDER) $@
	rm -rf $(OBJS_FOLDER)

reinstall: uninstall all
