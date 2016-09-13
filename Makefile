OS := $(shell uname)

CC := gcc

CFLAGS := -g -Wall -O3 -DLINUX -Isrc

SOFLAGS := -g -DLINUX -shared -fPIC -Isrc

LDFLAGS := -Wl,-rpath,bin,-rpath,-lstdc++
ifneq ($(OS), Darwin)
	LDFLAGS := $(LDFLAGS),-lrt
endif

TARGET = chacha20

# vpath indicate the searching path of the according file type
vpath %.c src
vpath %.h src

all: lib$(TARGET).so lib$(TARGET).a $(TARGET)_test $(TARGET)_example

$(TARGET)_test: test/$(TARGET)_test.c $(TARGET).c
	$(CC) test/$(TARGET)_test.c $(CFLAGS) $(LDFLAGS) -o $@
	./$@
	rm -rf ./$@

$(TARGET)_example: example/$(TARGET)_example.c $(TARGET).c
	$(CC) $^ $(CFLAGS) $(LDFLAGS) -o $@
	./$@
	rm -rf ./$@

lib%.a: %.c
	ar rcs $@ $^

lib%.so: %.c
	$(CC) $^ $(SOFLAGS) -o $@

.PHONY : clean
clean :
	rm -rf $(TARGET)_test
	rm -rf $(TARGET)_example
	rm -rf lib$(TARGET).so
	rm -rf lib$(TARGET).a
	rm -rf *.dSYM
