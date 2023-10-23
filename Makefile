# Define the source directory and binary directory
SRC_DIR := src
BIN_DIR := bin
INC_DIR := inc
PROG_NAME := surfpsi

# List of source files (automatically detect .c or .cpp files)
SRC_FILES := $(wildcard $(SRC_DIR)/*.c) $(wildcard $(SRC_DIR)/*.cpp)

# Define the compiler and compiler flags
CC := gcc  # Change this to g++ if using C++
CFLAGS := -Wall -Wextra

# Create a list of object files in the binary directory
OBJ_FILES := $(patsubst $(SRC_DIR)/%.c, $(BIN_DIR)/%.o, $(SRC_FILES))
# Alternatively, if you're using C++, replace the .c extension with .cpp:
# OBJ_FILES := $(patsubst $(SRC_DIR)/%.cpp, $(BIN_DIR)/%.o, $(SRC_FILES))

# Create a list of dependency files in the binary directory
DEP_FILES := $(patsubst $(SRC_DIR)/%.c, $(BIN_DIR)/%.d, $(SRC_FILES))
# Alternatively, if you're using C++, replace the .c extension with .cpp:
# DEP_FILES := $(patsubst $(SRC_DIR)/%.cpp, $(BIN_DIR)/%.d, $(SRC_FILES))

# The default target builds the executable
all: $(BIN_DIR)/$(PROG_NAME)

# Rule to build the executable from object files
$(BIN_DIR)/$(PROG_NAME): $(OBJ_FILES)
	$(CC) $(CFLAGS) $^ -o $@

# Rule to compile source files into object files and generate dependency files
$(BIN_DIR)/%.o: $(SRC_DIR)/%.c | $(BIN_DIR)
	$(CC) $(CFLAGS) -c $< -o $@
	$(CC) -MM -MT $(BIN_DIR)/$*.o -MF $(BIN_DIR)/$*.d $<

# Include the generated dependency files
-include $(DEP_FILES)

# Create the binary directory if it doesn't exist
$(BIN_DIR):
	mkdir -p $(BIN_DIR)

# Clean up object files, dependency files, and the executable
clean:
	rm -rf $(BIN_DIR)

.PHONY: all clean
