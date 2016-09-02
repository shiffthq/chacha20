CC := gcc

CFLAGS := -g -Wall -O3 -DLINUX -Isrc

SOFLAGS := -g -DLINUX -shared -fPIC -Isrc

LDFLAGS := -Wl,-rpath,bin,-rpath,-Lbin,-lrt,-lstdc++

# vpath indicate the searching path of the according file type
vpath %.c src
vpath %.h src
vpath %.so bin
vpath % bin

chacha20_test: test/chacha20_test.c chacha20.c
	$(CC) test/chacha20_test.c $(CFLAGS) $(LDFLAGS) -o $@
	./$@
	rm -rf ./$@

chacha20_example: example/chacha20_example.c chacha20.c
	$(CC) $^ $(CFLAGS) $(LDFLAGS) -o $@
	./$@
	rm -rf ./$@

lib%.a: %.c
	ar rcs $@ $^

lib%.so: %.c
	$(CC) $^ $(SOFLAGS) -o $@

.PHONY : clean
clean :
	rm -rf chacha20_test
	rm -rf chacha20_example
	rm -rf libchacha20.so
	rm -rf libchacha20.a
	rm -rf *.dSYM
