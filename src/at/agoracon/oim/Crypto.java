package at.agoracon.oim;

import java.io.*;
import java.text.ParseException;

import com.thortech.xl.crypto.tcCryptoException;
import com.thortech.xl.crypto.tcCryptoUtil;

public class Crypto
{
    private static String key = "DBSecretKey";
    private static String sep = ":";

    // public ---------------------------------------------------------
    //
    public static void main(String[] args) 
    throws tcCryptoException, IOException, ParseException
    {
        Boolean modeEncrypt = false,
                modeMarker = false,
                modeHelp = false;
        String  line,
                input,
                result;
        BufferedReader in = new BufferedReader(new InputStreamReader(System.in));

        // set run modes
        //
        for (int i = 0; i < args.length; i++)
        {
            switch (args[i])
            {
                case "-e":  modeEncrypt = true;
                            break;
                case "-d":  modeEncrypt = false;
                            break;
                case "-m":  modeMarker = true;
                            break;
                case "-h":  modeHelp = true;
                            break;
            }
        }
        if (modeHelp == true)
        {
            printHelp();
            return;
        }

        System.err.printf("%s stdin, stop with EOF or Ctrl-Z...\n",
                (modeEncrypt ? "Encrypting" : "Decrypting"));

        // main loop
        //
        while ((line = in.readLine()) != null && line.length() != 0)
        {
            if (modeMarker)
            {
                String[] parts = line.split(sep, 2);
                result = parts[0] + sep;
                input  = parts[1];
            }
            else
            {
                result = "";
                input  = line;
            }

            result += ( modeEncrypt ? encrypt(input) : decrypt(input) );

            System.out.println(result);
        }
    }

    // private ------------------------------------------------------
    //
    private static void printHelp()
    {
        System.out.println(
                "Encryption/decryption of STDIN using the OIM instance key"
              + "In marker mode you can prepend each record with a marker"
              + "that will be present in output row:"
              + "<marker>:<data>"
              + ""
              + "Options:"
              + "    -d     decrypt"
              + "    -e     encrypt"
              + "    -m     marker mode");
    }

    private static String decrypt(String enc)
    throws tcCryptoException
    {
        return tcCryptoUtil.decrypt(enc, key);
    }

    private static String encrypt(String plain)
    throws tcCryptoException
    {
        return tcCryptoUtil.encrypt(plain, key);
    }

}
