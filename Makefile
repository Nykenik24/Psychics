TARGET = psychics

SRC_DIR = src
INC_DIR = include
BUILD_DIR = build
OBJ_DIR = $(BUILD_DIR)/obj
TESTS_DIR = tests

CC = gcc
CFLAGS = -Wall -Wextra -I$(INC_DIR) -O2

SRC_FILES := $(wildcard $(SRC_DIR)/*.c)
OBJ_FILES := $(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.o, $(SRC_FILES))

LIB_FILE = $(BUILD_DIR)/lib$(TARGET).a
DEMO_SRC = $(TESTS_DIR)/demo.c
DEMO_EXE = $(BUILD_DIR)/demo

all: $(LIB_FILE)

$(LIB_FILE): $(OBJ_FILES)
	@mkdir -p $(BUILD_DIR)
	ar rcs $@ $^

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(OBJ_DIR)
	$(CC) $(CFLAGS) -c $< -o $@

demo: $(DEMO_SRC) $(LIB_FILE)
	@mkdir -p $(BUILD_DIR)
	$(CC) $(CFLAGS) -o $(DEMO_EXE) $(DEMO_SRC) $(LIB_FILE)

clean:
	rm -rf $(BUILD_DIR)

.PHONY: all clean demo


