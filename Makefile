CC := gcc

CFLAGS := -g -Wall -O3 -DLINUX -Isrc

SOFLAGS := -g -DLINUX -shared -fPIC -Isrc

LDFLAGS := -Wl,-rpath,bin,-rpath,-Lbin,-lstdc++

# vpath indicate the searching path of the according file type
vpath %.c src
vpath %.h src
vpath %.so bin
vpath % bin

chacha20_test: test/chacha20_test.c chacha20.c
	$(CC) test/chacha20_test.c $(CFLAGS) $(LDFLAGS) -o $@
	mv $@ bin/

chacha20_example: example/chacha20_example.c chacha20.c
	$(CC) $^ $(CFLAGS) $(LDFLAGS) -o $@
	mv $@ bin/

lib%.a: %.c
	ar rcs $@ $^
	mv $@ bin/

lib%.so: %.c
	$(CC) $^ $(SOFLAGS) -o $@
	mv $@ bin/

.PHONY : clean
clean :
	rm -rf bin/*
	rm -rf *.dSYM
