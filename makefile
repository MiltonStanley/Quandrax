cc= g++ -g -Wall

build: quandrax.exe
	rm -f *.o quandrax

quandrax.exe: quandrax.o player.o
	${cc} -o quandrax.exe quandrax.o player.o

quandrax.o: quandrax.cpp
	${cc} -c quandrax.cpp

player.o: player.cpp
	${cc} -c player.cpp