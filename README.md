# hscompile
This repository contains a compiler and runtime for MNRL files
using Hyperscan as a CPU back-end.  There is also support for compiling Pearl Compatible Regular Expressions (PCREs) to MNRL files.

*Note:* Only hStates are currently supported.

## Required Packages

- Now supports up to gcc-8 
- cmake >= 2.6
- Hyperscan 4.4 source (submodule)
- Boost >= 1.57
- MNRL (submodule)

## Building
To successfully build `hscompile`, you must first build Hyperscan and the MNRL C++ APIs:

```bash
git clone --recurse-submodules https://github.com/tjt7a/hscompile.git
```

```bash
cd lib/hyperscan_for_hscompile
mkdir build
cd build
cmake .. -DFAT_RUNTIME=off
make
```

For the MNRL C++ APIs:

```bash
cd lib/mnrl/C++
make
```

Now you can use `cmake` to generate a Makefile and build.  You must provide paths to Hyperscan (`HS_SOURCE_DIR`) and MNRL (`MNRL_SOURCE_DIR`), and you can override the default Hyperscan build path with `HS_BUILD_DIR`.

```bash
cd hscompile 
mkdir build
cd build

cmake -DHS_SOURCE_DIR=../lib/hyperscan_for_hscompile -DMNRL_SOURCE_DIR=../lib/mnrl/C++ ..

make
```
