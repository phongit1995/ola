package chat.ola.vn.util;

import android.content.Context;
import android.widget.Toast;
import chat.ola.vn.OlaApplication;

/* JADX INFO: loaded from: classes.dex */
public class j {
    private static long a;
    private static long b;

    public static void a(long j) {
        b = j;
    }

    public static void a(Context context, int i) {
        a(context, i, true);
    }

    private static void a(Context context, int i, boolean z) {
        try {
            if (OlaApplication.e()) {
                return;
            }
            long jCurrentTimeMillis = System.currentTimeMillis();
            if (z || jCurrentTimeMillis - a >= b) {
                a = jCurrentTimeMillis;
                Toast.makeText(context, context.getString(i, ""), 0).show();
            }
        } catch (Throwable unused) {
        }
    }

    private static void a(Context context, int i, boolean z, Object... objArr) {
        try {
            if (OlaApplication.e()) {
                return;
            }
            long jCurrentTimeMillis = System.currentTimeMillis();
            if (z || jCurrentTimeMillis - a >= b) {
                a = jCurrentTimeMillis;
                Toast.makeText(context, context.getString(i, objArr), 0).show();
            }
        } catch (Throwable unused) {
        }
    }

    public static void a(Context context, int i, Object... objArr) {
        a(context, i, false, objArr);
    }

    public static void a(Context context, String str) {
        a(context, str, false);
    }

    private static void a(Context context, String str, boolean z) {
        try {
            if (OlaApplication.e()) {
                return;
            }
            long jCurrentTimeMillis = System.currentTimeMillis();
            if (z || jCurrentTimeMillis - a >= b) {
                a = jCurrentTimeMillis;
                Toast.makeText(context, str, 0).show();
            }
        } catch (Throwable unused) {
        }
    }

    public static void b(Context context, int i) {
        a(context, i, false);
    }

    private static void b(Context context, int i, boolean z) {
        try {
            if (OlaApplication.e()) {
                return;
            }
            long jCurrentTimeMillis = System.currentTimeMillis();
            if (z || jCurrentTimeMillis - a >= b) {
                a = jCurrentTimeMillis;
                Toast.makeText(context, context.getString(i), 1).show();
            }
        } catch (Throwable unused) {
        }
    }

    private static void b(Context context, int i, boolean z, Object... objArr) {
        try {
            if (OlaApplication.e()) {
                return;
            }
            long jCurrentTimeMillis = System.currentTimeMillis();
            if (z || jCurrentTimeMillis - a >= b) {
                a = jCurrentTimeMillis;
                Toast.makeText(context, context.getString(i, objArr), 1).show();
            }
        } catch (Throwable unused) {
        }
    }

    public static void b(Context context, int i, Object... objArr) {
        a(context, i, true, objArr);
    }

    public static void b(Context context, String str) {
        a(context, str, true);
    }

    private static void b(Context context, String str, boolean z) {
        try {
            if (OlaApplication.e()) {
                return;
            }
            long jCurrentTimeMillis = System.currentTimeMillis();
            if (z || jCurrentTimeMillis - a >= b) {
                a = jCurrentTimeMillis;
                Toast.makeText(context, str, 1).show();
            }
        } catch (Throwable unused) {
        }
    }

    public static void c(Context context, int i) {
        b(context, i, false);
    }

    public static void c(Context context, int i, Object... objArr) {
        b(context, i, false, objArr);
    }

    public static void c(Context context, String str) {
        b(context, str, true);
    }

    public static void d(Context context, int i) {
        b(context, i, true);
    }

    public static void d(Context context, int i, Object... objArr) {
        b(context, i, true, objArr);
    }
}
