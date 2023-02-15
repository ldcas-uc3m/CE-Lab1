#!/bin/bash

# extract hashes
unshadow data/usuario_12_passwd data/usuario_12_shadow > hashes.hash

# erase the pot
rm ~/.john/john.pot


# generate the dictionary
cewl -v -d 2 https://www.lab.inf.uc3m.es -w dictionaries/lab-inf-uc3m

cat dictionaries/* >> tmp_dictionary
sort tmp_dictionary | uniq  > dictionary  # remove duplicates
rm tmp_dictionary

# rules
john --rules --wordlist=dictionary --stdout | sort | uniq > rule_dictionary

# run
john --wordlist=rule_dictionary --max-length=15 hashes.hash

# run with GPU (mighht need to install driver for OpenCL)
# john --format=raw-MD5-opencl --wordlist=rule_dictionary --max-length=15 hashes.hash

# copy the pot 
john --show hashes.hash