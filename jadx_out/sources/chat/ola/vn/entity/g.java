package chat.ola.vn.entity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class g {
    private long A;
    private int B;
    private int C;
    private int D;
    private short E;
    private short F;
    private short G;
    private short H;
    private byte I;
    private boolean J;
    private boolean K;
    private boolean L;
    private boolean M;
    private boolean N;
    public k a;
    protected w b;
    public boolean c;
    public List<chat.ola.vn.message.f> d;
    public o e;
    private List<d> f;
    private d g;
    private h h;
    private String i;
    private String j;
    private String k;
    private String l;
    private String m;
    private String n;
    private String o;
    private String p;
    private String q;
    private String r;
    private String s;
    private String t;
    private String u;
    private String[] v;
    private long w;
    private long x;
    private long y;
    private long z;

    public g() {
        this.f = null;
        this.g = null;
        this.a = null;
        this.h = null;
        this.b = null;
        this.s = null;
        this.t = null;
        this.u = null;
        this.A = 0L;
        this.G = (short) 0;
        this.H = (short) 0;
        this.I = (byte) 0;
        this.J = false;
        this.K = true;
        this.L = true;
        this.M = true;
        this.N = true;
        this.c = false;
        this.d = null;
        this.e = null;
    }

    public g(f fVar) {
        this.f = null;
        this.g = null;
        this.a = null;
        this.h = null;
        this.b = null;
        this.s = null;
        this.t = null;
        this.u = null;
        this.A = 0L;
        this.G = (short) 0;
        this.H = (short) 0;
        this.I = (byte) 0;
        this.J = false;
        this.K = true;
        this.L = true;
        this.M = true;
        this.N = true;
        this.c = false;
        this.d = null;
        this.e = null;
        if (fVar.d != null) {
            this.k = fVar.d.toString();
        }
        this.y = fVar.c;
        this.w = fVar.h;
        this.x = fVar.g;
        this.l = fVar.e;
        this.j = fVar.f;
        this.b = fVar.j;
        this.H = (short) 0;
        this.D = fVar.t;
        this.B = fVar.r;
        this.v = fVar.i;
        this.G = fVar.c();
    }

    public static boolean a(short s) {
        switch (s) {
            case 0:
            case 1:
            case 2:
            case 3:
            case 4:
            case 6:
            case 9:
            case 10:
            case 11:
                return true;
            case 5:
            case 7:
            case 8:
            default:
                return false;
        }
    }

    public long A() {
        return this.A;
    }

    public w B() {
        return this.b;
    }

    public String C() {
        return this.s;
    }

    public int D() {
        return this.C;
    }

    public String[] E() {
        return this.v;
    }

    public String F() {
        return this.t;
    }

    public String a() {
        return this.j;
    }

    public void a(byte b) {
        this.I = b;
    }

    public void a(int i) {
        this.B = i;
        if (this.B < 0) {
            this.B = 0;
        }
    }

    public void a(long j) {
        this.w = j;
    }

    public void a(d dVar) {
        this.g = dVar;
    }

    public void a(h hVar) {
        this.h = hVar;
    }

    public void a(w wVar) {
        this.b = wVar;
    }

    public void a(String str) {
        this.j = str;
    }

    public void a(List<d> list) {
        this.f = list;
    }

    public void a(boolean z) {
        this.J = z;
    }

    public void a(String[] strArr) {
        try {
            ArrayList arrayList = new ArrayList(strArr.length);
            HashMap map = new HashMap(strArr.length);
            for (int i = 0; i < strArr.length; i++) {
                if (map.get(strArr[i]) == null) {
                    map.put(strArr[i], strArr[i]);
                    arrayList.add(strArr[i]);
                }
            }
            if (arrayList.size() > 0) {
                this.v = new String[arrayList.size()];
                for (int i2 = 0; i2 < this.v.length; i2++) {
                    this.v[i2] = (String) arrayList.get(i2);
                }
            }
        } catch (Throwable unused) {
            this.v = strArr;
        }
    }

    public String b() {
        return this.k;
    }

    public void b(int i) {
        this.D = i;
    }

    public void b(long j) {
        this.y = j;
    }

    public void b(String str) {
        this.k = str;
    }

    public void b(short s) {
        this.F = s;
    }

    public String c() {
        return this.l;
    }

    public void c(int i) {
        this.C = i;
        if (this.C < 0) {
            this.C = 0;
        }
    }

    public void c(long j) {
        this.x = j;
    }

    public void c(String str) {
        this.l = str;
    }

    public void c(short s) {
        this.G = s;
    }

    public long d() {
        return this.w;
    }

    public void d(long j) {
        this.z = j;
    }

    public void d(String str) {
        this.m = str;
    }

    public void d(short s) {
        this.H = s;
    }

    public long e() {
        return this.y;
    }

    public void e(long j) {
        this.A = j;
    }

    public void e(String str) {
        this.i = str;
    }

    public void e(short s) {
        this.E = s;
    }

    public int f() {
        return this.B;
    }

    public void f(String str) {
        this.u = str;
    }

    public int g() {
        return this.D;
    }

    public void g(String str) {
        this.n = str;
    }

    public short h() {
        return this.F;
    }

    public void h(String str) {
        this.o = str;
    }

    public short i() {
        return this.G;
    }

    public void i(String str) {
        this.p = str;
    }

    public void j(String str) {
        this.q = str;
    }

    public boolean j() {
        return this.J;
    }

    public short k() {
        return this.H;
    }

    public void k(String str) {
        this.r = str;
    }

    public void l(String str) {
        this.s = str;
    }

    public boolean l() {
        return (k() == 3 || k() == 4 || k() == 5 || k() == 6 || k() == 9 || k() == 10) ? false : true;
    }

    public String m() {
        return this.i;
    }

    public void m(String str) {
        this.t = str;
    }

    public long n() {
        return this.x;
    }

    public short o() {
        return this.E;
    }

    public byte p() {
        return this.I;
    }

    public String q() {
        return this.u;
    }

    public List<d> r() {
        return this.f;
    }

    public d s() {
        return this.g;
    }

    public String t() {
        return this.n;
    }

    public String u() {
        return this.o;
    }

    public long v() {
        return this.z;
    }

    public String w() {
        return this.p;
    }

    public h x() {
        return this.h;
    }

    public String y() {
        return this.q;
    }

    public String z() {
        return this.r;
    }
}
