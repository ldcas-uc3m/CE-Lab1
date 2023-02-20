#!/bin/bash

JOHN_PATH=$HOME"/src/john/run/john"
JOHN_CONF_PATH=$HOME"/src/john/run/john.conf"
JOHN_POT_PATH=$HOME"/src/john/run/john.pot"


# extract hashes
unshadow data/usuario_12_passwd data/usuario_12_shadow > hashes.hash

# erase the pot
rm $JOHN_POT_PATH

# copy the configuration
cp $JOHN_CONF_PATH tmp/john.conf

sed -i '4193 i .include "custom_rules.conf"' $JOHN_CONF_PATH

# generate the dictionaries
cewl -v -d 2 https://www.lab.inf.uc3m.es -w dictionaries/lab-inf-uc3m

wget -P dictionaries/ https://github.com/brannondorsey/naive-hashcat/releases/download/data/rockyou.txt

cat dictionaries/* >> tmp_dictionary
sort tmp_dictionary | uniq  > dictionary  # remove duplicates
rm tmp_dictionary

# rules
$JOHN_PATH --rules=Custom --wordlist=dictionary --stdout | sort | uniq > rule_dictionary

# run
$JOHN_PATH --wordlist=rule_dictionary --max-length=15 hashes.hash

# run with GPU (might need to install driver for OpenCL)
# $JOHN_PATH --format=sha512crypt-opencl --wordlist=rule_dictionary --max-length=15 hashes.hash

# copy the pot 
$JOHN_PATH --show hashes.hash > output

# restore old john conf
cp tmp/john.conf $JOHN_CONF_PATH