package at.agoracon.oim;

import java.io.*;
import java.text.ParseException;

import com.thortech.xl.crypto.tcCryptoException;
import com.thortech.xl.crypto.tcCryptoUtil;

public class Crypto
{
    public static void main(String[] args) 
	throws tcCryptoException, IOException, ParseException
    {
	String l, sep = ":";

	System.out.println("Decrypting stdin, stop with Ctrl-Z...");

	BufferedReader in = new BufferedReader(new InputStreamReader(System.in));

	while ((l = in.readLine()) != null && l.length() != 0) {
	    if (l.contains(sep)) {
		String[] parts = l.split(sep, 2);
		System.out.println(parts[0] + ":" + tcCryptoUtil.decrypt(parts[1], 
			    "DBSecretKey"));
	    } else {
		throw new ParseException("String " + l + " does not contain " + sep, l.length());
	    }
	}
    }

}
