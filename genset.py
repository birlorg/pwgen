#!/usr/bin/env python3

words = []
with open('eff_large_wordlist.txt','r') as fd:
    for line in fd.readlines():
        key, word = line.strip().split()
        words.append(word)
print('words = {"',end='')
print('","'.join(words),end='')
print('"}')
