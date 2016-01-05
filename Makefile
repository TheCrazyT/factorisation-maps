all:
	$(CXX) -o out/factorisation.exe main.cpp

mingw:
	CC=D:\\MinGW64\\bin\\gcc.exe CXX=D:\\MinGW64\\bin\\g++.exe make all
