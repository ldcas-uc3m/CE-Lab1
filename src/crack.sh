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

# base dictionary
cat dictionaries/hotmail.txt >> tmp_dictionary
cat dictionaries/top-500-worst-passwords >> tmp_dictionary
sort tmp_dictionary | uniq  > dictionary  # remove duplicates
rm tmp_dictionary

# rules

# pre-rule dictionary
cat dictionaries/lab-inf-uc3m > tmp_dictionary
cat dictionaries/spanish-names >> tmp_dictionary
sort tmp_dictionary | uniq  > pre_rule_dictionary
rm tmp_dictionary


$JOHN_PATH --rules=Custom --wordlist=pre_rule_dictionary --stdout | sort | uniq > rule_dictionary

# run
$JOHN_PATH --wordlist=rule_dictionary --max-length=15 hashes.hash

# run with GPU (mighht need to install driver for OpenCL)
# $JOHN_PATH --format=raw-MD5-opencl --wordlist=rule_dictionary --max-length=15 hashes.hash

# copy the pot 
$JOHN_PATH --show output

# restore old john conf
cp tmp/john.conf $JOHN_CONF_PATH