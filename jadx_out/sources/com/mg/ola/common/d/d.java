package com.mg.ola.common.d;

import java.io.File;

/* JADX INFO: loaded from: classes2.dex */
public class d {
    private static final char a = File.separatorChar;

    public static String a(String str) {
        return d(b(str));
    }

    private static String a(String str, int i) {
        int iH;
        if (str == null || (iH = h(str)) < 0) {
            return null;
        }
        int iC = c(str);
        int i2 = i + iC;
        return (iH >= str.length() || iC < 0 || iH >= i2) ? "" : str.substring(iH, i2);
    }

    static boolean a() {
        return a == '\\';
    }

    private static boolean a(char c) {
        return c == '/' || c == '\\';
    }

    public static String b(String str) {
        if (str == null) {
            return null;
        }
        return str.substring(c(str) + 1);
    }

    public static int c(String str) {
        if (str == null) {
            return -1;
        }
        return Math.max(str.lastIndexOf(47), str.lastIndexOf(92));
    }

    public static String d(String str) {
        if (str == null) {
            return null;
        }
        int iE = e(str);
        return iE == -1 ? str : str.substring(0, iE);
    }

    public static int e(String str) {
        int iLastIndexOf;
        if (str != null && c(str) <= (iLastIndexOf = str.lastIndexOf(46))) {
            return iLastIndexOf;
        }
        return -1;
    }

    public static String f(String str) {
        if (str == null) {
            return null;
        }
        int iE = e(str);
        return iE == -1 ? "" : str.substring(iE + 1);
    }

    public static String g(String str) {
        return a(str, 1);
    }

    public static int h(String str) {
        int iMin;
        if (str == null) {
            return -1;
        }
        int length = str.length();
        if (length == 0) {
            return 0;
        }
        char cCharAt = str.charAt(0);
        if (cCharAt == ':') {
            return -1;
        }
        if (length == 1) {
            if (cCharAt == '~') {
                return 2;
            }
            return a(cCharAt) ? 1 : 0;
        }
        if (cCharAt == '~') {
            int iIndexOf = str.indexOf(47, 1);
            int iIndexOf2 = str.indexOf(92, 1);
            if (iIndexOf == -1 && iIndexOf2 == -1) {
                return length + 1;
            }
            if (iIndexOf == -1) {
                iIndexOf = iIndexOf2;
            }
            if (iIndexOf2 == -1) {
                iIndexOf2 = iIndexOf;
            }
            iMin = Math.min(iIndexOf, iIndexOf2);
        } else {
            char cCharAt2 = str.charAt(1);
            if (cCharAt2 == ':') {
                char upperCase = Character.toUpperCase(cCharAt);
                if (upperCase < 'A' || upperCase > 'Z') {
                    return -1;
                }
                return (length == 2 || !a(str.charAt(2))) ? 2 : 3;
            }
            if (!a(cCharAt) || !a(cCharAt2)) {
                return a(cCharAt) ? 1 : 0;
            }
            int iIndexOf3 = str.indexOf(47, 2);
            int iIndexOf4 = str.indexOf(92, 2);
            if ((iIndexOf3 == -1 && iIndexOf4 == -1) || iIndexOf3 == 2 || iIndexOf4 == 2) {
                return -1;
            }
            if (iIndexOf3 == -1) {
                iIndexOf3 = iIndexOf4;
            }
            if (iIndexOf4 == -1) {
                iIndexOf4 = iIndexOf3;
            }
            iMin = Math.min(iIndexOf3, iIndexOf4);
        }
        return iMin + 1;
    }
}
