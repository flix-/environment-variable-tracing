# static
CC = wllvm
CFLAGS = -g -O0 -fPIC
# dynamic
#CC = gcc
#CFLAGS = --coverage -g -O0 -fPIC

LDFLAGS = -shared
TARGET = sample.so

CC_TEST = gcc
CFLAGS_TEST = --coverage -g -O0
LDFLAGS_TEST = -ldl
TARGET_TEST = unit-test

all: $(TARGET)

$(TARGET): config.o util.o api.o
	$(CC) $(CFLAGS) $(LDFLAGS) config.o util.o api.o -o $(TARGET)
	extract-bc $(TARGET) -o sample.bc
	llvm-dis sample.bc

config.o: config/config.c
	$(CC) -c $(CFLAGS) config/config.c -o config.o

util.o: util/util.c
	$(CC) -c $(CFLAGS) util/util.c -o util.o

api.o: api/api.c
	$(CC) -c $(CFLAGS) api/api.c -o api.o

test: unit-test.o
	$(CC_TEST) $(CFLAGS_TEST) $(LDFLAGS_TEST) unit-test.o -o $(TARGET_TEST)
	./unit-test
	lcov -c -d . -o dynamic-trace.txt

unit-test.o: test/unit-test.c
	$(CC_TEST) -c $(CFLAGS_TEST) test/unit-test.c -o unit-test.o


clean:
	rm -f sample.so *.o *.bc .*.bc *.ll *.gcda *.gcno .*.gcno dynamic-trace.txt unit-test

