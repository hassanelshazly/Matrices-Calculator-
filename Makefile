
#------------------------------------------------------------------------------
# Makefile used to build the project
#
# Use: make [TARGET]
#
# Build Targets:
# 	   clean   :  remove all the gemerted files from
# 				  the complier
#	   All     :  The whole project
#      main.out:  The whole project
#	   %.o     :  %.cpp
#
# Platform Overrides:
#      <Put a description of the supported Overrides here
#
#------------------------------------------------------------------------------
SRC_DIR = src
OBJ_DIR = obj

SOURCES  := $(wildcard ${SRC_DIR}/*.cpp)
INCLUDES := include

CC 		 = g++
CPPFLAGS = -I$(INCLUDES) -MMD -MP

OBJS := $(SOURCES:.cpp=.o)
OBJS := $(patsubst ${SRC_DIR}/%,${OBJ_DIR}/%,$(OBJS))
	
DEPS   = $(OBJS:.o=.d)
TARGET = main

# Rule for genertaing .o files 
$(OBJ_DIR)/%.o : $(SRC_DIR)/%.cpp
	$(CC) -c $(CPPFLAGS) -o $@  $<

# Rule for genertaing main.out file 
$(TARGET).out :$(OBJS)	
	$(CC)    $(CPPFLAGS) -o $@  $<
	
-include $(DEPS)  

.PHONY: all
all : $(TARGET).out

.PHONY: clean
clean : 
	rm -rf $(OBJS) $(DEPS) $(TARGET).out