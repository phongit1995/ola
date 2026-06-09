package chat.ola.vn.pickercontacts;

import chat.ola.vn.c.x;

/* JADX INFO: loaded from: classes.dex */
public class a {
    public static String a = ".default";
    public static String b = ".avatar";

    public static String a() {
        switch (x.m) {
            case 0:
                return ".rect";
            case 1:
                return ".circle";
            case 2:
                return ".tube";
            case 3:
                return ".heart";
            default:
                return "";
        }
    }

    public static String a(Character ch) {
        return a() + a + "." + ch;
    }

    public static String a(String str) {
        return a() + b + "." + str;
    }
}
