all: quandrax.exe

quandrax.exe: quandrax.cpp
	g++ -pedantic quandrax.cpp -o quandrax.exe