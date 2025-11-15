#!/usr/bin/env python3
import random
import string

def load(p='/usr/share/dict/eff_large_wordlist.txt'):
        """load word list
        sourced from: https://www.eff.org/deeplinks/2016/07/new-wordlists-random-passphrases
        this should do the trick:
        curl -Lo - https://www.eff.org/files/2016/07/18/eff_large_wordlist.txt > /usr/share/dict/eff_large_wordlist.txt

        The list will be returned as a dictionary, the 5 digit(integer) of the dice roll as the key and the word as the value.
        """
        words = {}
        with open(p,'r') as fd:
                while True:
                        line = fd.readline()
                        if line:
                                key, word = line.strip().split()
                                #print(key,word)
                                words[int(key)] = word
                        else:
                                break
                return words
def genword(words):
        """ generate 1 word from wordlist using fake dice to use the diceware scheme.
        """
        r = random.SystemRandom()
        key = ''
        for i in range(5):
                key += str(r.randrange(1, 7))
        word = words[int(key)]
        return word
def pwgen():
        """use SystemRandom and wordlist if possible.
        """
        pw = ''
        try:
                words = load('/usr/local/eff_large_wordlist.txt')
        except:
                words = {}
        r = random.SystemRandom()
        # ensure we have a large word list(> 7k words)
        if len(words) > 7000:
                for i in range(6):
                        pw += genword(words).capitalize()+'.'
                pw += r.choice(string.digits)
                pw += r.choice(string.digits)
        else:
                choices = string.digits+string.ascii_letters+'.'
                for i in range(64):
                        pw += r.choice(choices)
        return pw

if __name__ == "__main__":
        print(pwgen())
