package chat.ola.vn.entity;

import android.view.View;
import android.widget.ListView;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class e {
    private int A;
    private e B;
    private int D;
    private List<String> E;
    private boolean F;
    private int G;
    private int H;
    private short I;
    private String J;
    private List<e> K;
    private int L;
    private int M;
    private e N;
    private e O;
    private List<e> P;
    private List<e> Q;
    private String R;
    private int S;
    private long a;
    private String b;
    private String c;
    private String d;
    private String e;
    private String f;
    private String g;
    private String h;
    private String i;
    private String j;
    private String k;
    private long l;
    private int m;
    private int n;
    private int o;
    private long p;
    private List<e> q;
    private List<e> r;
    private List<e> s;
    private List<e> t;
    private List<chat.ola.vn.entry.b> u;
    private int z;
    private boolean v = false;
    private boolean w = false;
    private boolean x = true;
    private boolean y = true;
    private long C = 0;

    public String A() {
        return this.j;
    }

    public long B() {
        return this.l;
    }

    public int C() {
        return this.m;
    }

    public int D() {
        return this.n;
    }

    public int E() {
        return this.o;
    }

    public long F() {
        return this.p;
    }

    public short G() {
        return this.I;
    }

    public long H() {
        try {
            if (this.u == null || this.u.isEmpty()) {
                return 0L;
            }
            return this.u.get(this.u.size() - 1).b.e();
        } catch (Throwable unused) {
        }
        return 0L;
    }

    public void I() {
        this.z = -1;
        this.A = -1;
    }

    public String J() {
        return this.J;
    }

    public List<e> K() {
        return this.K;
    }

    public int L() {
        return this.L;
    }

    public int M() {
        return this.M;
    }

    public e N() {
        return this.N;
    }

    public e O() {
        return this.O;
    }

    public List<e> P() {
        return this.Q;
    }

    public String Q() {
        return this.R;
    }

    public int R() {
        return this.S;
    }

    public String a(int i, int i2) {
        String str;
        if (chat.ola.vn.util.m.a(this.e)) {
            str = null;
        } else {
            if (i > 400) {
                return this.e;
            }
            str = this.e;
        }
        if (!chat.ola.vn.util.m.a(this.f)) {
            if (i > 300 || chat.ola.vn.h.I) {
                return this.f;
            }
            str = this.f;
        }
        return !chat.ola.vn.util.m.a(this.g) ? this.g : str == null ? this.h : str;
    }

    public void a(int i) {
        this.G = i;
    }

    public void a(long j) {
        this.a = j;
    }

    public void a(ListView listView) {
        try {
            this.z = listView.getFirstVisiblePosition();
            View childAt = listView.getChildAt(this.z);
            this.A = childAt != null ? childAt.getTop() : 0;
        } catch (Throwable unused) {
        }
    }

    public void a(e eVar) {
        this.b = eVar.b;
        this.c = eVar.c;
        this.d = eVar.d;
        if (!chat.ola.vn.util.m.a(eVar.e)) {
            this.e = eVar.e;
        }
        if (!chat.ola.vn.util.m.a(eVar.f)) {
            this.f = eVar.f;
        }
        if (!chat.ola.vn.util.m.a(eVar.g)) {
            this.g = eVar.g;
        }
        if (!chat.ola.vn.util.m.a(eVar.h)) {
            this.h = eVar.h;
        }
        if (!chat.ola.vn.util.m.a(eVar.k)) {
            this.k = eVar.k;
        }
        if (!chat.ola.vn.util.m.a(eVar.i)) {
            this.i = eVar.i;
        }
        if (!chat.ola.vn.util.m.a(eVar.j)) {
            this.j = eVar.j;
        }
        if (eVar.l != 0) {
            this.l = eVar.l;
        }
        if (eVar.m != 0) {
            this.m = eVar.m;
        }
        if (eVar.n != 0) {
            this.n = eVar.n;
        }
        if (eVar.p != 0) {
            this.p = eVar.p;
        }
        if (eVar.q != null) {
            this.q = eVar.q;
        }
        if (eVar.r != null) {
            this.r = eVar.r;
        }
        if (eVar.t != null) {
            this.t = eVar.t;
        }
        if (eVar.I != 0) {
            this.I = eVar.I;
        }
        if (eVar.P != null) {
            this.P = eVar.P;
        }
        if (eVar.u != null) {
            this.u = eVar.u;
        }
        if (eVar.J != null) {
            this.J = eVar.J;
        }
        if (eVar.R != null) {
            this.R = eVar.R;
        }
        if (eVar.E != null) {
            this.E = eVar.E;
        }
        if (eVar.Q != null) {
            this.Q = eVar.Q;
        }
        if (eVar.n != 0) {
            this.n = eVar.n;
        }
        if (eVar.D != 0) {
            this.D = eVar.D;
        }
        if (eVar.Q != null) {
            this.Q = eVar.Q;
        }
        this.H = eVar.H;
        this.F = eVar.F;
        this.G = eVar.G;
    }

    public void a(String str) {
        this.h = str;
    }

    public void a(List<chat.ola.vn.entry.b> list) {
        this.u = list;
    }

    public void a(short s) {
        this.I = s;
    }

    public void a(boolean z) {
        this.F = z;
    }

    public boolean a() {
        return this.F;
    }

    public int b() {
        return this.G;
    }

    public void b(int i) {
        this.H = i;
    }

    public void b(int i, int i2) {
        this.z = i;
        this.A = i2;
    }

    public void b(long j) {
        this.l = j;
    }

    public void b(final ListView listView) {
        listView.post(new Runnable() { // from class: chat.ola.vn.entity.e.1
            @Override // java.lang.Runnable
            public void run() {
                if (e.this.z >= 0 || e.this.A >= 0) {
                    listView.setSelectionFromTop(e.this.z, e.this.A);
                }
            }
        });
    }

    public void b(e eVar) {
        this.o = eVar.o;
        this.v = eVar.v;
        this.w = eVar.w;
        this.x = eVar.x;
        this.y = eVar.y;
        this.C = eVar.C;
        this.a = eVar.a;
        this.F = eVar.F;
        this.G = eVar.G;
        this.R = eVar.R;
        a(eVar);
    }

    public void b(String str) {
        this.k = str;
    }

    public void b(List<chat.ola.vn.entry.b> list) {
        if (list == null) {
            return;
        }
        if (this.u == null) {
            this.u = new ArrayList();
        }
        this.u.addAll(list);
    }

    public void b(boolean z) {
        this.v = z;
        if (z) {
            this.C = System.currentTimeMillis();
        }
    }

    public int c() {
        return this.H;
    }

    public void c(int i) {
        this.D = i;
    }

    public void c(long j) {
        this.p = j;
    }

    public void c(e eVar) {
        this.B = eVar;
    }

    public void c(String str) {
        this.e = str;
    }

    public void c(List<e> list) {
        this.P = list;
    }

    public void c(boolean z) {
        this.x = z;
    }

    public long d() {
        return this.a;
    }

    public void d(int i) {
        this.m = i;
    }

    public void d(e eVar) {
        if (this.t == null) {
            this.t = new ArrayList();
        }
        this.t.add(eVar);
    }

    public void d(String str) {
        this.f = str;
    }

    public void d(List<String> list) {
        this.E = list;
    }

    public void d(boolean z) {
        this.y = z;
    }

    public String e() {
        return this.h;
    }

    public void e(int i) {
        this.n = i;
    }

    public void e(e eVar) {
        if (this.r == null) {
            this.r = new ArrayList();
        }
        this.r.add(eVar);
    }

    public void e(String str) {
        this.g = str;
    }

    public void e(List<e> list) {
        this.t = list;
    }

    public void e(boolean z) {
        this.w = z;
    }

    public List<chat.ola.vn.entry.b> f() {
        return this.u;
    }

    public void f(int i) {
        this.o = i;
    }

    public void f(e eVar) {
        if (this.s == null) {
            this.s = new ArrayList();
        }
        this.s.add(eVar);
    }

    public void f(String str) {
        this.b = str;
    }

    public void f(List<e> list) {
        this.q = list;
    }

    public e g(int i) {
        if (this.q == null) {
            return null;
        }
        return this.q.get(i);
    }

    public List<e> g() {
        return this.P;
    }

    public void g(e eVar) {
        this.N = eVar;
    }

    public void g(String str) {
        this.c = str;
    }

    public void g(List<e> list) {
        this.r = list;
    }

    public String h() {
        return this.k;
    }

    public void h(int i) {
        this.L = i;
    }

    public void h(e eVar) {
        this.O = eVar;
    }

    public void h(String str) {
        this.d = str;
    }

    public void h(List<e> list) {
        this.s = list;
    }

    public int i() {
        return this.D;
    }

    public void i(int i) {
        this.M = i;
    }

    public void i(String str) {
        this.j = str;
    }

    public void i(List<e> list) {
        if (this.r == null) {
            this.r = new ArrayList();
        }
        this.r.addAll(list);
    }

    public List<String> j() {
        return this.E;
    }

    public void j(int i) {
        this.S = i;
    }

    public void j(String str) {
        this.J = str;
    }

    public void j(List<e> list) {
        if (list == null) {
            return;
        }
        if (this.K == null) {
            this.K = new ArrayList();
        }
        this.K.addAll(list);
    }

    public void k(String str) {
        this.R = str;
    }

    public void k(List<e> list) {
        this.K = list;
    }

    public boolean k() {
        if (System.currentTimeMillis() - this.C > 10000) {
            this.v = false;
        }
        return this.v;
    }

    public e l() {
        if (this.B == null && this.t != null && !this.t.isEmpty()) {
            this.B = this.t.get(0);
        }
        return this.B;
    }

    public void l(List<e> list) {
        this.Q = list;
    }

    public List<e> m() {
        return this.t;
    }

    public boolean n() {
        return this.x;
    }

    public boolean o() {
        return this.y;
    }

    public boolean p() {
        return this.w;
    }

    public String q() {
        return this.e;
    }

    public String r() {
        return this.f;
    }

    public String s() {
        return this.g;
    }

    public String t() {
        return this.b;
    }

    public int u() {
        if (this.q == null) {
            return 0;
        }
        return this.q.size();
    }

    public List<e> v() {
        return this.q;
    }

    public List<e> w() {
        if (this.s != null && this.r == null) {
            Iterator<e> it2 = this.s.iterator();
            while (it2.hasNext()) {
                i(it2.next().w());
            }
        }
        return this.r;
    }

    public List<e> x() {
        return this.s;
    }

    public String y() {
        return this.c;
    }

    public String z() {
        return this.d;
    }
}
