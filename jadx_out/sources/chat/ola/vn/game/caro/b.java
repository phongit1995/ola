package chat.ola.vn.game.caro;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class b {
    public static int a = 40;
    public static int b = 40;
    private int c;
    private int d;
    private int[][] e;
    private a f;
    private c g;
    private boolean h;
    private boolean i;
    private short j;

    public int a() {
        return this.c;
    }

    public void a(int i, int i2, short s) {
        try {
            this.e[i][i2] = s;
            this.f = new a(i, i2, s);
            if (this.g != null) {
                this.g.a(new a(i, i2, s));
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public void a(c cVar) {
        this.g = cVar;
    }

    public void a(boolean z) {
        this.h = z;
    }

    public int b() {
        return this.d;
    }

    public void b(boolean z) {
        this.i = z;
    }

    public List<a> c() {
        try {
            ArrayList arrayList = new ArrayList(0);
            for (int i = 0; i < this.c; i++) {
                for (int i2 = 0; i2 < this.d; i2++) {
                    if (this.e[i][i2] == a.b) {
                        arrayList.add(new a(i, i2, a.b));
                    }
                }
            }
            return arrayList;
        } catch (Throwable unused) {
            return null;
        }
    }

    public List<a> d() {
        try {
            ArrayList arrayList = new ArrayList(0);
            for (int i = 0; i < this.c; i++) {
                for (int i2 = 0; i2 < this.d; i2++) {
                    if (this.e[i][i2] == a.a) {
                        arrayList.add(new a(i, i2, a.a));
                    }
                }
            }
            return arrayList;
        } catch (Throwable unused) {
            return null;
        }
    }

    public a e() {
        return this.f;
    }

    public boolean f() {
        return this.h;
    }

    public boolean g() {
        return this.i;
    }

    public void h() {
        if (this.g != null) {
            this.g.B();
        }
        i();
    }

    public void i() {
        this.e = (int[][]) null;
        this.c = 0;
        this.d = 0;
        this.f = null;
        this.g = null;
    }

    public void j() {
        this.e = (int[][]) Array.newInstance((Class<?>) int.class, this.c, this.d);
        this.f = null;
    }

    public int[][] k() {
        return this.e;
    }

    public short l() {
        return this.j;
    }
}
