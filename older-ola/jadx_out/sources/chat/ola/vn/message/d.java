package chat.ola.vn.message;

import chat.ola.vn.OlaApplication;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class d {
    protected f a;
    protected byte b;
    protected byte c;
    protected String d;
    protected String e;
    protected String f;
    protected CharSequence g;
    protected String h;
    protected String i;
    protected String j;
    protected String k;
    protected String l;
    protected String m;
    protected String n;
    protected long o;
    public Long p;
    protected long q;
    protected short r;
    protected short s;
    protected short t;
    protected byte u;
    public boolean v;
    public boolean w;
    public boolean x;
    protected Runnable y;
    private List<String> z;

    public d() {
        this.b = (byte) 0;
        this.c = (byte) 0;
        this.f = null;
        this.g = null;
        this.o = System.currentTimeMillis();
        this.p = null;
        this.q = 0L;
        this.u = (byte) 0;
        this.v = false;
        this.w = false;
        this.x = false;
        this.z = null;
        this.y = null;
        this.l = a();
    }

    public d(byte b) {
        this();
        this.b = b;
    }

    public d(d dVar, byte b, byte b2) {
        this();
        if (dVar != null) {
            a(dVar);
        }
        this.b = b;
        this.c = b2;
    }

    private String a() {
        return "client." + System.nanoTime();
    }

    public static boolean g(String str) {
        try {
            return str.startsWith("client.");
        } catch (Throwable unused) {
            return false;
        }
    }

    public String A() {
        return this.n;
    }

    public String B() {
        return this.k;
    }

    public String a(int i) {
        try {
            try {
                return this.z.get(i);
            } catch (Throwable unused) {
                return null;
            }
        } catch (Throwable unused2) {
            if (this.a.k() == 0 && this.u == 3) {
                return this.a.d;
            }
            return null;
        }
    }

    public void a(byte b) {
        if (this.u == 3 || this.u == b) {
            return;
        }
        this.u = b;
    }

    public void a(byte b, boolean z) {
        byte b2 = this.u;
        if (this.u == 3) {
            return;
        }
        if ((h() || b != 3) && this.u != b) {
            byte b3 = this.u;
            this.u = b;
            if (z && b2 == 2) {
                try {
                    if (this.b == 1 && b == 3) {
                        OlaApplication.b.a(this.a.j(), this.a.k(), this.l, b);
                    }
                } catch (Throwable unused) {
                }
            }
            if (this.a != null) {
                this.a.a(this, b3, this.u);
            }
        }
    }

    public void a(long j) {
        this.o = j;
    }

    void a(d dVar) {
        this.d = dVar.i();
        this.e = dVar.j();
        this.f = dVar.k();
        this.g = dVar.l();
        if (dVar.c() != null) {
            this.h = dVar.c();
            this.i = dVar.v();
        }
        if (!chat.ola.vn.util.m.a(dVar.r())) {
            this.m = dVar.r();
        }
        this.o = dVar.m();
        this.s = dVar.n();
        this.t = dVar.o();
        this.q = dVar.t();
        this.u = dVar.q();
        this.v = dVar.v;
        if (!chat.ola.vn.util.m.a(dVar.n)) {
            this.n = dVar.n;
        }
        if (!this.w) {
            this.w = dVar.w;
        }
        if (!this.x) {
            this.x = dVar.x;
        }
        if (this.p == null) {
            this.p = dVar.p;
        }
    }

    public void a(Runnable runnable) {
        this.y = runnable;
    }

    public void a(List<String> list) {
        this.z = list;
    }

    public void a(short s) {
        this.s = s;
    }

    public void b(byte b) {
        a(b, true);
    }

    public void b(long j) {
        this.q = j;
    }

    public void b(String str) {
        this.h = str;
    }

    public void b(short s) {
        this.t = s;
    }

    public boolean b() {
        return true;
    }

    public String c() {
        return this.h;
    }

    public void c(String str) {
        if (this.z == null) {
            this.z = new ArrayList();
        }
        if (this.z.contains(str)) {
            return;
        }
        this.z.add(str);
    }

    public void c(short s) {
        this.r = s;
    }

    public byte d() {
        return this.b;
    }

    public void d(String str) {
        this.d = str;
    }

    public byte e() {
        return this.c;
    }

    public void e(String str) {
        this.e = str;
    }

    public f f() {
        return this.a;
    }

    public void f(String str) {
        this.i = chat.ola.vn.util.i.g(str);
        if (chat.ola.vn.util.m.a(this.i)) {
            this.h = chat.ola.vn.util.i.d(str);
            if (chat.ola.vn.util.m.a(this.h)) {
                this.j = chat.ola.vn.util.i.e(str);
                if (chat.ola.vn.util.m.a(this.j)) {
                    this.k = chat.ola.vn.util.i.f(str);
                }
            }
        }
        this.f = str;
        try {
            this.g = this.b == 1 ? chat.ola.vn.util.i.c(chat.ola.vn.util.i.d(str, "")) : chat.ola.vn.util.i.b(chat.ola.vn.util.i.d(str, ""));
        } catch (Throwable unused) {
            this.g = str;
        }
    }

    public void g() {
        if (this.b != 1 || this.u == 3) {
            return;
        }
        byte b = this.u;
        this.u = (byte) 3;
        try {
            OlaApplication.b.a(this.a.j(), this.a.k(), this.l, this.u);
        } catch (Throwable unused) {
        }
        if (this.a != null) {
            this.a.a(this, b, this.u);
        }
    }

    public void h(String str) {
        if (chat.ola.vn.util.m.b(this.l, str)) {
            return;
        }
        String str2 = this.l;
        this.l = str;
        try {
            this.a.b(str2, this);
        } catch (Throwable unused) {
        }
    }

    protected boolean h() {
        return true;
    }

    public String i() {
        return this.d;
    }

    public void i(String str) {
        this.m = str;
    }

    public String j() {
        return this.e;
    }

    public void j(String str) {
        this.i = str;
    }

    public String k() {
        return this.f;
    }

    public void k(String str) {
        this.j = str;
    }

    public CharSequence l() {
        return this.g;
    }

    public void l(String str) {
        this.n = str;
    }

    public long m() {
        return this.o;
    }

    public void m(String str) {
        this.k = str;
    }

    public short n() {
        return this.s;
    }

    public short o() {
        return this.t;
    }

    public String p() {
        if (this.l == null) {
            this.l = a();
        }
        return this.l;
    }

    public byte q() {
        return this.u;
    }

    public String r() {
        return this.m;
    }

    public short s() {
        return this.r;
    }

    public long t() {
        return this.q;
    }

    public List<String> u() {
        return this.z;
    }

    public String v() {
        return this.i;
    }

    public boolean w() {
        return false;
    }

    public boolean x() {
        return e() == 2;
    }

    public String y() {
        return this.j;
    }

    public Runnable z() {
        return this.y;
    }
}
