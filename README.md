OIM: Encrypt and Decrypt User Passwords
=======================================

Decryption
----------

This program uses the shipped Oracle classes for encryption or decrption
of user passwords stored in the OIM database.

The SQL script `export.sql` creates the file `users.lst` where
each line consists of the user login and the encrypted password,
separated by colon.  The second colon in each line is part of the
encrpyted password.

Run the script with someting like:

    $ sqlplus my_oim@my_db @export.sql

Then run the decryption:

    $ ./decrypt.sh users.lst

On STDOUT you will get the user logins with the decrypted passwords,
separator is again colon.

Encryption
----------

Encryption works analogue, but is not implemented at moment.
