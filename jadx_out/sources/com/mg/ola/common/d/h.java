package com.mg.ola.common.d;

/* JADX INFO: loaded from: classes2.dex */
public class h {
    private static final char[] a = {12593, 12594, 12596, 12599, 12600, 12601, 12609, 12610, 12611, 12613, 12614, 12615, 12616, 12617, 12618, 12619, 12620, 12621, 12622};

    private static boolean a(char c) {
        return c >= 44032 && c <= 55203;
    }

    public static boolean a(String str, String str2) {
        if (str == null || str2 == null || str2.length() > str.length()) {
            return false;
        }
        int i = 0;
        int i2 = 0;
        do {
            if (a(str.charAt(i)) && b(str2.charAt(i2))) {
                if (str2.charAt(i2) != c(str.charAt(i))) {
                    if (i2 > 0) {
                        break;
                    }
                    i++;
                }
                i++;
                i2++;
            } else {
                if (str2.charAt(i2) != str.charAt(i)) {
                    if (i2 > 0) {
                        break;
                    }
                    i++;
                }
                i++;
                i2++;
            }
            if (i >= str.length()) {
                break;
            }
        } while (i2 < str2.length());
        return i2 == str2.length();
    }

    private static boolean b(char c) {
        for (char c2 : a) {
            if (c == c2) {
                return true;
            }
        }
        return false;
    }

    private static char c(char c) {
        return a[(c - 44032) / 588];
    }
}
