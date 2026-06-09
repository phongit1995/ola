package chat.ola.vn.entry;

import android.content.Context;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.activity.OlaBottomTabActivity;
import chat.ola.vn.util.m;

/* JADX INFO: loaded from: classes.dex */
public class e {
    protected byte a;
    protected int b;
    protected String c;
    protected String d;
    protected String e;
    protected int f;
    protected int g;
    protected String h;
    protected int i;
    protected String j;
    protected String k;
    protected boolean l;
    private int m;
    private int n;
    private String o;
    private boolean p;

    public e() {
        this.a = (byte) 0;
        this.n = -1;
        this.d = null;
        this.e = null;
        this.f = 0;
        this.g = 1;
        this.i = 0;
        this.p = false;
        this.l = false;
    }

    public e(int i, int i2, int i3) {
        this.a = (byte) 0;
        this.n = -1;
        this.d = null;
        this.e = null;
        this.f = 0;
        this.g = 1;
        this.i = 0;
        this.p = false;
        this.l = false;
        this.m = i;
        this.b = i2;
        this.f = i3;
    }

    public e(int i, String str, String str2) {
        this.a = (byte) 0;
        this.n = -1;
        this.d = null;
        this.e = null;
        this.f = 0;
        this.g = 1;
        this.i = 0;
        this.p = false;
        this.l = false;
        this.m = i;
        this.d = str;
        this.c = str2;
    }

    public static e a(int i, int i2, int i3) {
        return new e(i, i2, i3);
    }

    private final void c(boolean z) {
        if (z) {
            if (this.g != 2) {
                this.g = 1;
            }
            if (!this.p) {
                this.p = z;
                chat.ola.vn.h.v.k();
                try {
                    chat.ola.vn.h.v.g();
                    ((OlaBottomTabActivity) chat.ola.vn.c.c()).I();
                    return;
                } catch (Throwable unused) {
                    return;
                }
            }
        }
        this.p = z;
    }

    public void a(byte b) {
        this.a = b;
    }

    public void a(int i) {
        this.n = i;
    }

    public void a(String str) {
        this.d = str;
    }

    public void a(boolean z) {
        this.l = z;
    }

    public boolean a() {
        return this.l;
    }

    public final boolean a(Context context) {
        this.l = true;
        boolean zB = b(context);
        if (zB) {
            c(true);
        }
        return zB;
    }

    public String b() {
        return this.c;
    }

    public void b(int i) {
        this.g = i;
    }

    public void b(String str) {
        this.o = str;
    }

    public final void b(boolean z) {
        if (z && this.g != 2) {
            this.g = 1;
        }
        this.p = z;
    }

    public boolean b(Context context) {
        return false;
    }

    public void c(int i) {
        this.i = i;
    }

    public void c(String str) {
        this.j = str;
    }

    public boolean c() {
        return !m() && this.g == 2;
    }

    public int d() {
        return this.m;
    }

    public void d(String str) {
        this.e = str;
    }

    public int e() {
        return this.n;
    }

    public boolean equals(Object obj) {
        e eVar = (e) obj;
        return (d() + "#" + g()).equalsIgnoreCase(eVar.d() + "#" + eVar.g());
    }

    public String f() {
        return this.f != 0 ? OlaApplication.a(this.f) : this.d;
    }

    public String g() {
        return this.o;
    }

    public String h() {
        if (!m() || this.g == 2) {
            return this.j;
        }
        return null;
    }

    public int i() {
        return this.b == 0 ? R.drawable.ola_logo_trans : this.b;
    }

    public String j() {
        if (m.a(this.h)) {
            return null;
        }
        return this.h + ":" + this.i;
    }

    public String k() {
        return this.h;
    }

    public int l() {
        return this.i;
    }

    public boolean m() {
        return this.p;
    }

    public String n() {
        return this.e;
    }

    public byte o() {
        return this.a;
    }

    public String p() {
        return this.k;
    }
}
