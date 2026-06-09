package chat.ola.vn.entity;

import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class l {
    public String a;
    public String b;
    public String c;
    public String d;
    public long f;
    public int g;
    public int h;
    public short i;
    public short j;
    public String e = null;
    public boolean k = false;
    public List<i> l = null;

    public static String a(String str, int i, int i2) {
        if (str == null) {
            return null;
        }
        if (i != 0) {
            str = str + "&w=" + i;
        }
        if (i2 == 0) {
            return str;
        }
        return str + "&h=" + i2;
    }

    public String a(int i, int i2) {
        if (this.c == null) {
            return null;
        }
        String str = this.c;
        if (i != 0) {
            str = str + "&w=" + i;
        }
        if (i2 == 0) {
            return str;
        }
        return str + "&h=" + i2;
    }

    public boolean a() {
        short s = this.i;
        if (s == 5) {
            return true;
        }
        switch (s) {
            case 1:
            case 2:
            case 3:
                return true;
            default:
                return false;
        }
    }
}
