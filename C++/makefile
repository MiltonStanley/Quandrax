cc= g++ -g -Wall

build: quandrax.exe
# This works from command line, but NOT my IDE
	rm -f *.o quandrax

# can always CLI "make windows" as needed
windows: quandrax.exe
	del -f *.o quandrax
	
quandrax.exe: quandrax.o player.o province.o
	${cc} -o quandrax.exe quandrax.o player.o province.o
	
quandrax.o: quandrax.cpp
	${cc} -c quandrax.cpp

player.o: player.cpp
	${cc} -c player.cpp

province.o: province.cpp
	${cc} -c province.cpp