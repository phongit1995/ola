package com.mg.ola.common.widget.date;

/* JADX INFO: loaded from: classes2.dex */
class d {
    public static int a(String str) {
        int i = 0;
        for (int i2 = 0; i2 < str.length(); i2++) {
            i = a(str.charAt(i2)) ? i + 1 : i + 2;
        }
        return i;
    }

    public static boolean a(int i) {
        return (i >= 32 && i <= 127) || i == 13 || i == 10;
    }
}
