package com.facebook.accountkit.internal;

import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.support.annotation.Nullable;
import android.util.Base64;
import java.nio.charset.Charset;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/* JADX INFO: loaded from: classes.dex */
public class PackageUtils {
    @Nullable
    public static String computePackageHash(Context context, String str) {
        return computePackageHash(context, str, 0);
    }

    @Nullable
    public static String computePackageHash(Context context, String str, int i) throws NoSuchAlgorithmException {
        byte[] packageSig = getPackageSig(context, str);
        if (packageSig == null) {
            return null;
        }
        return Base64.encodeToString(packageSig, i);
    }

    @Nullable
    private static byte[] getPackageSig(Context context, String str) throws NoSuchAlgorithmException {
        try {
            PackageInfo packageInfo = context.getPackageManager().getPackageInfo(str, 64);
            MessageDigest messageDigest = MessageDigest.getInstance("SHA-256");
            messageDigest.update((str + " " + packageInfo.signatures[0].toCharsString()).trim().getBytes(Charset.forName("US-ASCII")));
            return messageDigest.digest();
        } catch (PackageManager.NameNotFoundException | NoSuchAlgorithmException unused) {
            return null;
        }
    }
}
