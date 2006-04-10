CFLAGS	:=	-Wall -Wno-char-subscripts -O2 -s

ifneq (,$(findstring MINGW,$(shell uname -s)))
	exeext		:= .exe
endif

ifneq (,$(findstring Linux,$(shell uname -s)))
	CFLAGS += -static
endif

tools	:=	$(patsubst %.c,%$(exeext),$(wildcard *.c)) \
		$(patsubst %.cpp,%$(exeext),$(wildcard *.cpp))


all:	$(tools)

clean:
	@rm -f $(tools)

gbfs$(exeext)	:	gbfs.c
	$(CC) $< -o $@ $(CFLAGS) -liberty

%$(exeext)	:: %.c
	$(CC) $< -o $@ $(CFLAGS)

%$(exeext)	:: %.cpp
	$(CXX) $< -o $@ $(CFLAGS)

install:
	cp  $(tools) $(PREFIX)
