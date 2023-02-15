# Lab 1: Password Cracking
By Luis Daniel Casais Mezquida  
Cybersecurity Engineering 22/23  
Bachelor's Degree in Computer Science and Engineering, grp. 89  
Universidad Carlos III de Madrid

# Project statement
The goal of this lab is to understand how password cracking tools work and to learn how to use a very popular tool, John The Ripper.  
You were assigned a password file with 10 passwords of a Linux system (`src/data/`). Your goal is to find as many passwords as possible.

Some advice:
- Use as many dictionaries as you like. You can download them from well-known sites
(e.g., see links in the [Password Village](https://passwordvillage.org/)).
- No password is longer than 15 characters, though most are much shorter. The longest passwords are dictionary-based.
- Use `cewl` to generate dictionaries from webpages related to your environment.
- Create rules and patterns similar to what people use in real passwords.
- You won’t need weeks of computation if you use the tool wisely but the process will take some time, so start soo.

# Installation and execution
First install JohnTheRipper and cewl through your package manager.  
For APT:
```
sudo apt install john cewl
```

To run it:
```bash
bash run.sh
```


# Extra info
You can generate secure password hashes with `mkpasswd` (part of the `whois` package).  
To install it in APT:
```bash
sudo apt install whois
```
Example of use:
```bash
mkpasswd --method=SHA-512 caca
```

You can find some good tutorials [here](https://openwall.info/wiki/john/tutorials), but I recommend [Milo Serdov's tutorial](https://miloserdov.org/?p=4961)
