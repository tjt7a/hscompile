HYPERSCAN = /home/kaa2nx/AP/hyperscan
MNRL = /home/kaa2nx/AP/MNRL/C++
BOOST = /opt/boost_1_57_0

IDIR = ./include
SRCDIR = ./src

CC = gcc 
CXX = g++ 
AR = ar
LD = ld

CFLAGS = -fopenmp -I$(IDIR) -iquote $(HYPERSCAN)/src -iquote $(HYPERSCAN)/build --std=c99
CXXFLAGS = -fopenmp -I$(IDIR) -I$(BOOST)/include -iquote $(HYPERSCAN)/src -iquote $(HYPERSCAN)/build -I$(MNRL)/include --std=c++11
LDFLAGS = -fopenmp
STATICLIB = $(HYPERSCAN)/build/lib/libhs.a $(MNRL)/libmnrl.a

_DEPS = *.h
_OBJ_HSCOMPILE = hscompile.o hs_compile_mnrl.o parse_symbol_set.o
_OBJ_HSRUN = hsrun.o
_OBJ_PCRE2MNRL = pcre2mnrl.o hs_pcre_mnrl.o dump_charclass.o

ODIR = ./build

DEPS = $(patsubst %,$(IDIR)/%,$(_DEPS))
OBJ_HSCOMPILE = $(patsubst %,$(ODIR)/%,$(_OBJ_HSCOMPILE))
OBJ_HSRUN = $(patsubst %,$(ODIR)/%,$(_OBJ_HSRUN))
OBJ_PCRE2MNRL = $(patsubst %,$(ODIR)/%,$(_OBJ_PCRE2MNRL))

all: hscompile hsrun pcre2mnrl

debug: CXXFLAGS += -DDEBUG -g
debug: CFLAGS += -DDEBUG -g
debug: hscompile hsrun pcre2mnrl

hscompile: $(OBJ_HSCOMPILE)
	$(CXX) $(LDFLAGS) $^ $(STATICLIB) -o $(ODIR)/$@
    
hsrun: $(OBJ_HSRUN)
	$(CXX) $(LDFLAGS) $^ $(STATICLIB) -o $(ODIR)/$@
    
pcre2mnrl: $(OBJ_PCRE2MNRL)
	$(CXX) $(LDFLAGS) $^ $(STATICLIB) -o $(ODIR)/$@

$(ODIR)/%.o: $(SRCDIR)/%.cpp $(DEPS)
	@pwd
	@mkdir -p $(ODIR)
	$(CXX) $(CXXFLAGS) -c -o $@ $<

$(ODIR)/%.o: $(SRCDIR)/%.c $(DEPS)
	@pwd
	@mkdir -p $(ODIR)
	$(CC) $(CFLAGS) -c -o $@ $<
	
.PHONY: clean

clean:
	rm -f $(ODIR)/*.o $(ODIR)/hscompile $(ODIR)/hsrun $(ODIR)/pcre2mnrl
	rmdir $(ODIR)