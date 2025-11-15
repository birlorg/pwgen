# pwgen

This generates a nice human password of 6 words and 2 numbers seperated by a .
example: Staunch.Starch.Mayflower.Connected.Revocable.Puritan.49

This code is compiled via [redbean](https://redbean.dev/) so it runs natively on six OSes for both AMD64 and ARM64. So basically everywhere.

If you have problems running the binary in releases, see [redbeans install section](https://redbean.dev/#install) below the actual installation which you can skip, it has platform specific notes that might be useful. Feel free to send a patch updating this for your particular platform.

### security

It's not high-security, but it's reasonable-ish security.
We pull from /dev/random if it exists, otherwise we use the current time as our random seed generation.
Again, not perfect, but reasonable-ish for it to just work, which is more important.

The [wordlist](https://www.eff.org/files/2016/07/18/eff_large_wordlist.txt) comes from the [EFF](https://www.eff.org)'s [passphrase wordlist](https://www.eff.org/document/passphrase-wordlists). It's compiled into the binary. You don't have to do anything.

Originally this was written in python and you had to download the wordlist yourself. (see pwgen.py) Idea originally from [diceware](https://diceware.readthedocs.io/en/stable/readme.html) I got tired of working that hard, so I built it in redbean.
