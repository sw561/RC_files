CC=g++
CFLAGS = -Wall -Wextra -pedantic -O3 -std=c++11

main: main.o
	$(CC) $(CFLAGS) $^ -o $@

%.o: %.cpp
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f *.o
