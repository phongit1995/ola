package chat.ola.vn;

import android.annotation.SuppressLint;

/* JADX INFO: loaded from: classes.dex */
@SuppressLint({"UseSparseArrays"})
public class b {
    private static b a;
    private String[] b;
    private String[] c;
    private String[] d;

    private b() {
    }

    public static b d() {
        if (a == null) {
            a = new b();
        }
        return a;
    }

    public String[] a() {
        if (this.b == null) {
            this.b = OlaApplication.a().getResources().getStringArray(R.array.time_label);
        }
        return this.b;
    }

    public String[] b() {
        if (this.c == null) {
            this.c = OlaApplication.a().getResources().getStringArray(R.array.time_label_plural);
        }
        return this.c;
    }

    public String[] c() {
        if (this.d == null) {
            this.d = OlaApplication.a().getResources().getStringArray(R.array.date_label);
        }
        return this.d;
    }
}
