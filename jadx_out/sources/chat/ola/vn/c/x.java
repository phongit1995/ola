package chat.ola.vn.c;

import android.net.Uri;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.entity.aa;
import java.util.Calendar;
import java.util.Locale;

/* JADX INFO: loaded from: classes.dex */
public class x {
    private static String A = null;
    private static Calendar B = null;
    public static long a = 0;
    public static Boolean b = null;
    public static String c = null;
    public static String d = null;
    public static Short e = null;
    public static long f = 900000;
    public static long g = 180000;
    public static boolean h = true;
    public static int i = 5;
    public static short j = 2;
    public static byte k = 0;
    public static byte l = 0;
    public static byte m = 0;
    public static byte n = 0;
    public static byte o = 0;
    public static byte p = 0;
    public static boolean q = true;
    public static boolean r = true;
    public static boolean s = false;
    public static boolean t = true;
    public static boolean u = true;
    public static boolean v = false;
    public static boolean w = true;
    public static boolean x = true;
    public static boolean y = false;
    private static String z;

    public static void a(String str) {
        try {
            z = str;
            chat.ola.vn.e.a().o(z);
        } catch (Throwable unused) {
        }
    }

    public static boolean a() {
        return chat.ola.vn.h.i();
    }

    public static void b(String str) {
        if (chat.ola.vn.util.m.a(str)) {
            str = "default";
        }
        A = str;
        chat.ola.vn.e.a().d(str);
        OlaApplication.c();
    }

    public static boolean b() {
        return false;
    }

    public static String c() {
        try {
            if (z == null) {
                z = chat.ola.vn.e.a().u();
            }
        } catch (Throwable unused) {
        }
        return z;
    }

    public static Uri d() {
        try {
            if (!chat.ola.vn.util.m.b(c(), "ola")) {
                return chat.ola.vn.util.c.a.j;
            }
        } catch (Throwable unused) {
        }
        return chat.ola.vn.util.c.a.i;
    }

    public static boolean e() {
        if (B == null) {
            B = Calendar.getInstance();
        }
        B.setTimeInMillis(System.currentTimeMillis());
        int i2 = B.get(11);
        int i3 = B.get(12);
        switch (n) {
            case 2:
                if (i2 < 12 || i2 > 13) {
                    return true;
                }
                if (i2 == 13 && i3 > 30) {
                    return true;
                }
            case 1:
                return false;
            case 3:
                if (i2 <= 6 || i2 >= 22) {
                    return i2 == 6 && i3 > 30;
                }
                return true;
            case 4:
                if (i2 >= 12 && i2 <= 13) {
                    return i2 == 13 && i3 > 30;
                }
                if (i2 <= 6 || i2 >= 22) {
                    return i2 == 6 && i3 > 30;
                }
                return true;
            case 5:
                return i2 < 8 || i2 > 17;
            default:
                return true;
        }
    }

    public static boolean f() {
        if (B == null) {
            B = Calendar.getInstance();
        }
        B.setTimeInMillis(System.currentTimeMillis());
        int i2 = B.get(11);
        int i3 = B.get(12);
        switch (o) {
            case 2:
                if (i2 < 12 || i2 > 13) {
                    return true;
                }
                if (i2 == 13 && i3 > 30) {
                    return true;
                }
            case 1:
                return false;
            case 3:
                if (i2 <= 6 || i2 >= 22) {
                    return i2 == 6 && i3 > 30;
                }
                return true;
            case 4:
                if (i2 >= 12 && i2 <= 13) {
                    return i2 == 13 && i3 > 30;
                }
                if (i2 <= 6 || i2 >= 22) {
                    return i2 == 6 && i3 > 30;
                }
                return true;
            case 5:
                return i2 < 8 || i2 > 17;
            default:
                return true;
        }
    }

    public static void g() {
        if ((j & 16384) != 16384) {
            j = (short) 2;
        }
        k = (byte) 0;
        m = (byte) 2;
        n = (byte) 3;
        h = true;
        o = (byte) 0;
        q = true;
        l = (byte) 0;
        c = null;
        t = true;
        p = (byte) 0;
    }

    public static void h() {
        try {
            aa aaVar = new aa();
            aaVar.a = "usersettings";
            aaVar.b = chat.ola.vn.h.b.f();
            OlaApplication.b.a("set", new aa[]{aaVar}, (short) 0);
        } catch (Throwable unused) {
        }
    }

    public static String i() {
        try {
            if (A == null) {
                A = chat.ola.vn.e.a().l();
            }
            String language = A;
            if (chat.ola.vn.util.m.b(language, "default")) {
                language = Locale.getDefault().getLanguage();
            }
            return chat.ola.vn.util.m.b(language, "vi") ? "vi" : "en";
        } catch (Throwable unused) {
            return "en";
        }
    }
}
