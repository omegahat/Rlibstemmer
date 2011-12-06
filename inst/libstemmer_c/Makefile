include mkinc.mak
CFLAGS=-Iinclude -fPIC
all: libstemmer.o 
#stemwords

ifndef RANLIB
RANLIB=ranlib
endif

libstemmer.o: $(snowball_sources:.c=.o)
	$(AR) -cru $@ $^
	$(RANLIB) $@

stemwords: examples/stemwords.o libstemmer.o
	$(CC) -o $@ $^
clean:
	rm -f stemwords *.o src_c/*.o runtime/*.o libstemmer/*.o
