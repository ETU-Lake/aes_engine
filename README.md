# ETU Lake AES Engine

## Project Setup
1. Create a project named `aes_engine` in **Vivado 2018.3** using the board **ZedBoard Zynq Evaluation and Development Kit (xc7z020clg484-1)**.
2. Initialize a git repository in the `aes_engine.srcs` directory.
3. Set the remote to the project repo.
4. Checkout to a new branch with the relevant module name as the branch name. Refer to the 1st point of the *Module Conventions*.

## Module Conventions
* All AES step modules will have no capitalization, spaces and non-alphabetical characters. The results are given below:
    * KeyExpansion: `keyexpansion`
    * S-Box: `sbox`
    * SubBytes: `subbytes`
    * ShiftRows: `shiftrows`
    * MixColumns: `mixcolumns`
    * AddRoundKey: `addroundkey`
* All module I/O specifications are to follow the following:
    * If applicable, the block state is to be the first input with the name `state`.
    * If applicable, the user key is to be second input after `state` (first if it doesn't exist) with the name `key`.
    * If applicable, the clock and reset signals are to be the last input with the names `clk` and `rst` in given order.
    * If applicable, the start input signal will be named `start` and be placed before `clk` if it exists.
    * If applciable, the end output signal will be named `end` and be the first output.
* All testbenches are to use the following additional rules:
    * Test modules are to be named `test_[MODULENAME]` where `[MODULENAME]` is the step module being tested.
    * Test modules are to not have any I/O.
* Because of the project requirements, the higher level module is exempt from these conventions except the testbench convention.

## License
This repository is licensed under BSD-3-Clause. Refer to LICENSE.md for more details.
