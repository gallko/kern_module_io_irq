CC := $(CROSS_COMPILE)gcc
LD :=  $(CROSS_COMPILE)ld

EXTRA_CFLAGS += \
	-DVERSION=\"$(VERSION)\" \
	-DDRIVER_NAME=\"$(NAME)\" \
	$(FLAGS) \
	$(INCLUDE)

MODULE_OBJ := $(SRC)

all:
	@echo NAME = $(NAME)
	@echo KERNEL_DIR = $(KERNEL_DIR)
	@echo TOP_DIR = $(TOP_DIR)
	@echo INCLUDE = $(INCLUDE)
	@echo SRC = $(SRC)
	@echo CC = $(CC)
	@echo LD = $(LD)
	@echo VERSION = \"$(VERSION)\"
	@echo TOP_DIR = \"$(TOP_DIR)\"
	@echo EXTRA_CFLAGS = \"$(EXTRA_CFLAGS)\"
	@echo CFLAGS = \"$(FLAGS)\"
	$(MAKE) -C $(KERNEL_DIR) M=$(TOP_DIR) CC=$(CC) LD=$(LD) modules

clean:
	$(MAKE) -C $(KERNEL_DIR) M=$(TOP_DIR) CC=$(CC) LD=$(LD) clean

module := $(NAME)
obj-m += $(NAME).o
$(NAME)-objs := $(MODULE_OBJ)