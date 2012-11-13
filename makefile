cc= g++ -g -Wall

build: quandrax.exe
	rm -f *.o quandrax

quandrax.exe: quandrax.o player.o province.o world.o
	${cc} -o quandrax.exe quandrax.o player.o province.o world.o

quandrax.o: quandrax.cpp
	${cc} -c quandrax.cpp

player.o: player.cpp
	${cc} -c player.cpp

province.o: province.cpp
	${cc} -c province.cpp

world.o: world.cpp
	${cc} -c world.cpp