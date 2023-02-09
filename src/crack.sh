#!/bin/bash

# cewl -v -d 2 https://www.lab.inf.uc3m.es


# extract hashes
unshadow data/usuario_12_passwd data/usuario_12_shadow > hashes

# erase the pot
rm ~/.john/john.pot

# run
john --wordlist=dictionary --rules > output

# copy the pot 