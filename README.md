OIM: Encrypt and Decrypt User Passwords
=======================================

This program uses the shipped Oracle classes for encryption or decryption
of user passwords stored in the OIM database.  The encryption key is taken 
from the current OIM instance, load the environment before using the tool.

Program is shipped as source code and automatically compiled and recompiled 
on source code changes.

Usage
-----

The data to encrypt/decrypt is read from stdin, output written to stdout and
system message are written to stderr.  There may be exceptions to this, caused 
by the used OIM java classes.

The program startup will take some time and is postponed until the first
encrypt/decrypt action (lazy load).

    oimcrypt <flags>

    flags:
      -d    decrypt
      -e    encrypt
      -m    records are prefixed with marker



Run as a Service
----------------

In case you are dealing with many rows, Unix is your friend:

    $ mkfifo in out                 # session one
    $ oimcrypt -e -m <in >out &

    $ cat out                       # session two

    $ cat >in                       # session one
    plaintextpassword
    anotherone
    foo
    Ctrl-D


Retrieve OIM Passwords
----------------------

The SQL script `export.sql` creates the file `users.lst` where
each line consists of the user login and the encrypted password,
separated by colon.  The second colon in each line is part of the
encrpyted password.

Run the script with someting like:

    $ sqlplus my_oim@my_db @export.sql

Then run the decryption:

    $ ./oimcrypt -d -m <users.lst >users.plain


OIM Bulk Migration
==================

There are two possible motivations for working with OIM password decryption: to
hack a system or to migrate a system.  Migrations will use the OIM bulk load
programs, therefore this 
