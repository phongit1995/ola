package chat.ola.vn.r;

import chat.ola.vn.OlaApplication;
import chat.ola.vn.c.x;
import chat.ola.vn.e.d;
import chat.ola.vn.entity.aa;
import chat.ola.vn.entity.t;
import chat.ola.vn.m.j;
import chat.ola.vn.util.m;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class b {
    private List<t> a;
    private List<t> b;
    private long e = 0;
    private boolean d = false;
    private boolean c = false;

    public t a(String str) {
        if (this.a == null) {
            return null;
        }
        for (t tVar : this.a) {
            if (m.a(str, tVar.o())) {
                return tVar;
            }
        }
        return null;
    }

    public void a(t tVar) {
        if (a(tVar.o()) == null) {
            if (this.a == null) {
                this.a = new ArrayList();
            }
            this.a.add(tVar);
        }
        Collections.sort(this.a, new d());
    }

    public void a(List<t> list) {
        this.c = true;
        if (this.a == null) {
            this.a = list;
        } else {
            this.a.clear();
            this.a.addAll(list);
        }
    }

    public void a(boolean z) {
        this.c = z;
    }

    public boolean a() {
        return this.d;
    }

    public t b(String str) {
        if (this.b == null) {
            return null;
        }
        for (t tVar : this.b) {
            if (m.a(str, tVar.o())) {
                return tVar;
            }
        }
        return null;
    }

    public void b(t tVar) {
        if (tVar.m() == -1 && x.t) {
            if (b(tVar.o()) == null) {
                if (this.b == null) {
                    this.b = new ArrayList();
                }
                this.b.add(tVar);
            }
            Collections.sort(this.b, new d());
        }
    }

    public void b(List<t> list) {
        this.d = true;
        if (this.b == null) {
            this.b = list;
        } else {
            this.b.clear();
            this.b.addAll(list);
        }
    }

    public void b(boolean z) {
        this.d = z;
    }

    public boolean b() {
        return this.c;
    }

    public List<t> c() {
        return this.a;
    }

    public void c(t tVar) {
        try {
            if (this.b != null) {
                Iterator<t> it2 = this.b.iterator();
                while (it2.hasNext()) {
                    if (m.a(it2.next().o(), tVar.o())) {
                        it2.remove();
                        return;
                    }
                }
            }
        } catch (Exception unused) {
        }
    }

    public List<t> d() {
        return this.b;
    }

    public void d(t tVar) {
        try {
            if (this.a != null) {
                Iterator<t> it2 = this.a.iterator();
                while (it2.hasNext()) {
                    if (m.a(it2.next().o(), tVar.o())) {
                        it2.remove();
                        return;
                    }
                }
            }
        } catch (Exception unused) {
        }
    }

    public void e() {
        if (this.a != null) {
            this.a.clear();
        }
    }

    public void f() {
        if (this.b != null) {
            this.b.clear();
        }
    }

    public void g() {
        try {
            j.c().e();
        } catch (Throwable unused) {
        }
    }

    public void h() {
        if (b()) {
            try {
                byte[] bArrC = chat.ola.vn.h.b.c(this.a);
                aa aaVar = new aa();
                aaVar.a = "rssbookmark";
                if (bArrC != null && bArrC.length != 0) {
                    aaVar.b = bArrC;
                    OlaApplication.b.a("rss", new aa[]{aaVar}, (short) 0);
                    return;
                }
                OlaApplication.b.b("rss", new aa[]{aaVar}, (short) 0);
            } catch (Throwable unused) {
            }
        }
    }

    public void i() {
        if (System.currentTimeMillis() - this.e >= 30000 && a()) {
            try {
                byte[] bArrC = chat.ola.vn.h.b.c(this.b);
                aa aaVar = new aa();
                aaVar.a = "rsshistory";
                if (bArrC == null || bArrC.length == 0) {
                    OlaApplication.b.b("rss", new aa[]{aaVar}, (short) 0);
                } else {
                    aaVar.b = bArrC;
                    OlaApplication.b.a("rss", new aa[]{aaVar}, (short) 0);
                }
            } catch (Throwable unused) {
            }
            this.e = System.currentTimeMillis();
        }
    }

    public void j() {
        try {
            this.c = false;
            this.d = false;
            e();
            f();
        } catch (Throwable unused) {
        }
    }
}
