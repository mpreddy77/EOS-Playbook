#!/bin/bash
thisScriptDir="$( cd "$( echo "${BASH_SOURCE[0]%/*}/" )"; pwd )"
echo "Current cwd -> " $thisScriptDir

eos_working_directory='/tmp/eosio'
echo "Creating eosio working dir @ " $eos_working_directory
mkdir -p $eos_working_directory 
cd $eos_working_directory

#clone latest eos source
git clone https://github.com/eosio/eos --recursive

#Build programs... /eos/programs eosiocpp, cleos, keos and nodeos binaries
#Build also symlinks to eosiocpp, cleos, keos and nodeos from /usr/local/eosio/bin/
cd eos && sh ./eosio_build.sh darwin

#Once build is complete, navigate to build folder and run unit tests
cd $eos_working_directory/eos/build && make test