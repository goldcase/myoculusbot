EXEC_NAME=JumpingSumoReceiveStream #output filename

SDK_DIR=../../../ARSDKBuildUtils
IDIR=./
CC=gcc -g
CFLAGS=-I$(IDIR) -I $(SDK_DIR)/Targets/Unix/Install/include

OBJDIR=obj
LDIR = $(SDK_DIR)/Targets/Unix/Install/lib

EXTERNAL_LIB=-lncurses

LIBS=-L$(SDK_DIR)/Targets/Unix/Install/lib -larsal -larcommands -larnetwork -larnetworkal -lardiscovery -larstream $(EXTERNAL_LIB)
LIBS_DBG=-L$(SDK_DIR)/Targets/Unix/Install/lib -larsal_dbg -larcommands_dbg -larnetwork_dbg -larnetworkal_dbg -lardiscovery_dbg -larstream_dbg $(EXTERNAL_LIB)

_DEPS = JumpingSumoReceiveStream.h ihm.h
DEPS = $(patsubst %,$(IDIR)/%,$(_DEPS))

_OBJ = JumpingSumoReceiveStream.o ihm.o
OBJ = $(patsubst %,$(OBJDIR)/%,$(_OBJ))

FIFO = video_fifo

all: $(EXEC_NAME)
	@[ -p $(FIFO) ] || mkfifo $(FIFO)

$(OBJDIR)/%.o: %.c $(DEPS)
	@ [ -d $(OBJDIR) ] || mkdir $(OBJDIR)
	@ $(CC) -c -o $@ $< $(CFLAGS)

$(EXEC_NAME): $(OBJ)
	@ gcc -o $@ $^ $(CFLAGS) $(LIBS)

.PHONY: clean

clean:
	@ rm -f $(OBJDIR)/*.o *~ core $(INCDIR)/*~
	@ rm -rf $(OBJDIR)
	@ rm -f $(FIFO)

run:
	LD_LIBRARY_PATH=$(LDIR) ./$(EXEC_NAME)
