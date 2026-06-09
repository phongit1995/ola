package chat.ola.vn.r.a;

import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.activity.OlaBottomTabActivity;
import chat.ola.vn.c.x;
import chat.ola.vn.entity.aa;
import chat.ola.vn.entity.af;
import chat.ola.vn.entity.g;
import chat.ola.vn.entity.q;
import chat.ola.vn.h;
import chat.ola.vn.util.m;
import com.mg.ola.common.d.i;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Stack;

/* JADX INFO: loaded from: classes.dex */
public class e {
    public static String a = null;
    public static int b = 0;
    public static long c = 0;
    public static boolean e = false;
    public static boolean f = false;
    private static Map<String, g> h = new HashMap();
    private static int y = -1;
    private static int z = -1;
    private List<af> i;
    private List<chat.ola.vn.entry.b> k;
    private List<chat.ola.vn.entry.b> l;
    private Stack<chat.ola.vn.entry.a> q;
    private List<d> s;
    private int v;
    private int w;
    private int j = 1;
    private g m = null;
    private String n = null;
    private chat.ola.vn.entry.b o = null;
    private boolean p = false;
    private short r = 0;
    private List<String> t = new ArrayList();
    private int u = 0;
    public long d = 0;
    public boolean g = false;
    private byte x = 0;
    private chat.ola.vn.me.a A = null;

    public e() {
        this.i = null;
        this.k = null;
        this.l = null;
        this.q = null;
        y = -1;
        z = -1;
        this.k = new ArrayList();
        this.l = new ArrayList();
        this.q = new Stack<>();
        this.i = new ArrayList();
        this.s = new ArrayList(5);
    }

    public static void a(final q qVar) {
        if (qVar == null) {
            return;
        }
        try {
            OlaApplication.a(new Runnable() { // from class: chat.ola.vn.r.a.e.2
                @Override // java.lang.Runnable
                public void run() {
                    try {
                        g gVar = (g) e.h.get(qVar.c);
                        if (gVar != null) {
                            gVar.a(qVar.d);
                            gVar.c(qVar.e);
                            gVar.c(qVar.f);
                            gVar.a(qVar.a);
                            chat.ola.vn.c.c().j();
                        }
                    } catch (Throwable unused) {
                    }
                }
            });
        } catch (Throwable unused) {
        }
    }

    private static chat.ola.vn.entry.b b(g gVar) {
        String strB;
        chat.ola.vn.entry.b bVar = new chat.ola.vn.entry.b(gVar);
        bVar.h = i.a(gVar.d(), chat.ola.vn.b.d().c(), chat.ola.vn.b.d().a(), chat.ola.vn.b.d().b());
        String strA = gVar.a();
        if (strA == null) {
            return bVar;
        }
        if (m.b(strA, "rss")) {
            strB = OlaApplication.a(R.string.general_tab_rss);
        } else if (m.b(strA, h.a())) {
            strB = x.d != null ? x.d : h.a();
        } else {
            chat.ola.vn.message.f fVarF = h.t.f(strA, (short) 0);
            strB = fVarF != null ? fVarF.b() : bVar.b.w();
        }
        bVar.a(strB);
        return bVar;
    }

    public static List<chat.ola.vn.entry.b> b(List<g> list) {
        try {
            ArrayList arrayList = new ArrayList();
            int size = list.size();
            for (int i = 0; i < size; i++) {
                g gVar = list.get(i);
                if (gVar.k() == 4 || gVar.k() == 5 || gVar.k() == 3) {
                    y = i;
                } else if (gVar.k() == 9) {
                    z = i;
                }
                arrayList.add(b(gVar));
            }
            return arrayList;
        } catch (Throwable th) {
            th.printStackTrace();
            return null;
        }
    }

    public static g d(String str) {
        try {
            if (!m.a(str)) {
                return null;
            }
            g gVar = new g();
            gVar.d((short) 10);
            gVar.a(0L);
            return gVar;
        } catch (Throwable unused) {
            return null;
        }
    }

    public static void e(List<g> list) {
        try {
            for (g gVar : list) {
                h.put("" + gVar.e(), gVar);
            }
        } catch (Throwable unused) {
        }
    }

    public static void f(final List<q> list) {
        if (list == null) {
            return;
        }
        try {
            OlaApplication.a(new Runnable() { // from class: chat.ola.vn.r.a.e.3
                @Override // java.lang.Runnable
                public void run() {
                    try {
                        for (q qVar : list) {
                            g gVar = (g) e.h.get(qVar.c);
                            if (gVar != null) {
                                gVar.a(qVar.d);
                                gVar.c(qVar.e);
                                gVar.c(qVar.f);
                                gVar.a(qVar.a);
                            }
                        }
                        chat.ola.vn.c.c().j();
                    } catch (Throwable unused) {
                    }
                }
            });
        } catch (Throwable unused) {
        }
    }

    public static void z() {
        try {
            h.clear();
        } catch (Throwable unused) {
        }
    }

    public short a() {
        return this.r;
    }

    public void a(int i) {
        int i2 = this.j;
        this.j = i;
        if (i == 1 && this.k != null) {
            this.k.clear();
        }
        Iterator<d> it2 = this.s.iterator();
        while (it2.hasNext()) {
            it2.next().a(i2, i);
        }
    }

    public void a(g gVar) {
        int i;
        try {
            ArrayList arrayList = new ArrayList();
            chat.ola.vn.entry.b bVarB = b(gVar);
            arrayList.add(bVarB);
            if (this.k == null) {
                y = -1;
                z = -1;
                this.k = new ArrayList();
            }
            try {
                int size = this.k.size();
                i = 0;
                for (int i2 = 0; i2 < size; i2++) {
                    try {
                        if (this.k.get(i2).d() != 9) {
                            break;
                        }
                        i++;
                    } catch (Throwable unused) {
                    }
                }
            } catch (Throwable unused2) {
                i = 0;
            }
            this.k.add(i, bVarB);
            Iterator<d> it2 = this.s.iterator();
            while (it2.hasNext()) {
                it2.next().a(arrayList, this.k);
            }
        } catch (Throwable unused3) {
        }
    }

    /* JADX WARN: Removed duplicated region for block: B:30:0x0071  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public void a(chat.ola.vn.entity.g r8, java.util.List<chat.ola.vn.entity.g> r9) {
        /*
            r7 = this;
            if (r8 != 0) goto L3
            return
        L3:
            java.util.List<chat.ola.vn.entry.b> r0 = r7.l
            if (r0 != 0) goto Le
            java.util.ArrayList r0 = new java.util.ArrayList
            r0.<init>()
            r7.l = r0
        Le:
            chat.ola.vn.entity.g r0 = r7.m
            if (r0 == 0) goto L8a
            chat.ola.vn.entity.g r0 = r7.m
            long r0 = r0.e()
            long r2 = r8.e()
            int r4 = (r0 > r2 ? 1 : (r0 == r2 ? 0 : -1))
            if (r4 != 0) goto L8a
            r8 = 0
            if (r9 == 0) goto L71
            int r0 = r9.size()     // Catch: java.lang.Throwable -> L71
            if (r0 <= 0) goto L71
            java.util.List r9 = b(r9)     // Catch: java.lang.Throwable -> L71
            java.util.Iterator r8 = r9.iterator()     // Catch: java.lang.Throwable -> L72
        L31:
            boolean r0 = r8.hasNext()     // Catch: java.lang.Throwable -> L72
            if (r0 == 0) goto L63
            java.lang.Object r0 = r8.next()     // Catch: java.lang.Throwable -> L72
            chat.ola.vn.entry.b r0 = (chat.ola.vn.entry.b) r0     // Catch: java.lang.Throwable -> L72
            java.util.List<chat.ola.vn.entry.b> r1 = r7.l     // Catch: java.lang.Throwable -> L72
            java.util.Iterator r1 = r1.iterator()     // Catch: java.lang.Throwable -> L72
        L43:
            boolean r2 = r1.hasNext()     // Catch: java.lang.Throwable -> L72
            if (r2 == 0) goto L31
            java.lang.Object r2 = r1.next()     // Catch: java.lang.Throwable -> L72
            chat.ola.vn.entry.b r2 = (chat.ola.vn.entry.b) r2     // Catch: java.lang.Throwable -> L72
            chat.ola.vn.entity.g r2 = r2.b     // Catch: java.lang.Throwable -> L72
            long r2 = r2.e()     // Catch: java.lang.Throwable -> L72
            chat.ola.vn.entity.g r4 = r0.b     // Catch: java.lang.Throwable -> L72
            long r4 = r4.e()     // Catch: java.lang.Throwable -> L72
            int r6 = (r2 > r4 ? 1 : (r2 == r4 ? 0 : -1))
            if (r6 != 0) goto L43
            r8.remove()     // Catch: java.lang.Throwable -> L72
            goto L43
        L63:
            if (r9 == 0) goto L72
            int r8 = r9.size()     // Catch: java.lang.Throwable -> L72
            if (r8 <= 0) goto L72
            java.util.List<chat.ola.vn.entry.b> r8 = r7.l     // Catch: java.lang.Throwable -> L72
            r8.addAll(r9)     // Catch: java.lang.Throwable -> L72
            goto L72
        L71:
            r9 = r8
        L72:
            java.util.List<chat.ola.vn.r.a.d> r8 = r7.s
            java.util.Iterator r8 = r8.iterator()
        L78:
            boolean r0 = r8.hasNext()
            if (r0 == 0) goto Lb6
            java.lang.Object r0 = r8.next()
            chat.ola.vn.r.a.d r0 = (chat.ola.vn.r.a.d) r0
            java.util.List<chat.ola.vn.entry.b> r1 = r7.l
            r0.b(r9, r1)
            goto L78
        L8a:
            r7.m = r8
            r0 = 0
            r9.add(r0, r8)
            if (r9 == 0) goto L9e
            int r0 = r9.size()
            if (r0 <= 0) goto L9e
            java.util.List r9 = b(r9)
            r7.l = r9
        L9e:
            java.util.List<chat.ola.vn.r.a.d> r9 = r7.s
            java.util.Iterator r9 = r9.iterator()
        La4:
            boolean r0 = r9.hasNext()
            if (r0 == 0) goto Lb6
            java.lang.Object r0 = r9.next()
            chat.ola.vn.r.a.d r0 = (chat.ola.vn.r.a.d) r0
            java.util.List<chat.ola.vn.entry.b> r1 = r7.l
            r0.a(r8, r1)
            goto La4
        Lb6:
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.r.a.e.a(chat.ola.vn.entity.g, java.util.List):void");
    }

    public void a(chat.ola.vn.entry.a aVar) {
        if (aVar == null) {
            return;
        }
        try {
            if (this.q == null) {
                this.q = new Stack<>();
            }
            if (this.q.size() >= 6) {
                this.q.remove(0);
            }
            if (!this.q.isEmpty()) {
                chat.ola.vn.entry.a aVarPeek = this.q.peek();
                if ((aVarPeek.b == null && aVar.b == null) || m.b(aVarPeek.b, aVar.b)) {
                    this.q.pop();
                }
            }
            this.q.push(aVar);
        } catch (Throwable unused) {
        }
    }

    public void a(chat.ola.vn.me.a aVar) {
        a(aVar, true);
    }

    public void a(chat.ola.vn.me.a aVar, boolean z2) {
        this.A = aVar;
        if (z2) {
            chat.ola.vn.h.b.a(h.a(), aVar);
        }
    }

    public void a(d dVar) {
        if (dVar == null) {
            return;
        }
        int i = 0;
        int size = this.s.size();
        while (true) {
            if (i >= size) {
                break;
            }
            if (m.b(this.s.get(i).C(), dVar.C())) {
                this.s.remove(i);
                break;
            }
            i++;
        }
        this.s.add(dVar);
    }

    public void a(String str, short s, List<g> list) {
        y = -1;
        z = -1;
        this.k = b(list);
        this.n = str;
        this.j = 0;
        this.p = false;
        Iterator<d> it2 = this.s.iterator();
        while (it2.hasNext()) {
            it2.next().e(this.k);
        }
    }

    public void a(List<af> list) {
        if (list != null) {
            try {
                if (list.size() == 0) {
                    return;
                }
                if (this.i == null) {
                    this.i = new ArrayList();
                } else {
                    this.i.clear();
                }
                this.i.addAll(list);
                Iterator<d> it2 = this.s.iterator();
                while (it2.hasNext()) {
                    it2.next().d(this.i);
                }
            } catch (Throwable unused) {
            }
        }
    }

    public void a(boolean z2) {
        this.p = z2;
    }

    public boolean a(chat.ola.vn.entry.b bVar) {
        if (this.k != null) {
            Iterator<chat.ola.vn.entry.b> it2 = this.k.iterator();
            while (it2.hasNext()) {
                chat.ola.vn.entry.b next = it2.next();
                if (next.b != null) {
                    if (next.b.p() == 0) {
                        if (next.b.e() == bVar.b.e()) {
                            it2.remove();
                            Iterator<d> it3 = this.s.iterator();
                            while (it3.hasNext()) {
                                it3.next().a(next, this.k);
                            }
                            return true;
                        }
                    } else if (m.b(next.b.m(), bVar.b.m())) {
                        it2.remove();
                        Iterator<d> it4 = this.s.iterator();
                        while (it4.hasNext()) {
                            it4.next().a(next, this.k);
                        }
                        return true;
                    }
                }
            }
        }
        if (this.l == null) {
            return false;
        }
        Iterator<chat.ola.vn.entry.b> it5 = this.l.iterator();
        while (it5.hasNext()) {
            chat.ola.vn.entry.b next2 = it5.next();
            if (next2.b != null && next2.b.e() == bVar.b.e()) {
                next2.b.d();
                it5.remove();
                Iterator<d> it6 = this.s.iterator();
                while (it6.hasNext()) {
                    it6.next().b(next2, this.l);
                }
                return true;
            }
        }
        return false;
    }

    public boolean a(String str) {
        if (m.a(str) || m.b(str, "my diary") || m.b(str, "mariage diary")) {
            return true;
        }
        if (!str.startsWith("#") && str.length() <= 2) {
            return true;
        }
        if (this.i == null) {
            return false;
        }
        for (af afVar : this.i) {
            if (!m.b(afVar.b(), "#apk") && !m.b(afVar.b(), "#ola") && !m.b(afVar.b(), "#hai") && !m.b(afVar.b(), "#daptrung") && m.b(afVar.b(), str)) {
                return true;
            }
        }
        return false;
    }

    public String b(String str) {
        if (this.i == null) {
            return "";
        }
        if (m.a(str)) {
            return OlaApplication.a(R.string.string_homepage);
        }
        for (af afVar : this.i) {
            if (m.b(str, afVar.b())) {
                return afVar.a();
            }
        }
        return "";
    }

    public List<af> b() {
        try {
            if (this.i == null) {
                this.i = new ArrayList();
            }
            ArrayList arrayList = new ArrayList(this.i);
            Iterator it2 = arrayList.iterator();
            while (it2.hasNext()) {
                af afVar = (af) it2.next();
                if (m.b(afVar.b(), "rs")) {
                    afVar.a(R.drawable.ic_indicate_rss);
                } else if (m.b(afVar.b(), "me")) {
                    afVar.a(R.drawable.ic_indicate_public);
                } else if (m.b(afVar.b(), "lk")) {
                    afVar.a(R.drawable.ic_section_like);
                } else if (m.b(afVar.b(), "#daptrung")) {
                    afVar.a(R.drawable.ic_indicate_broken_egg);
                } else if (m.b(afVar.b(), "#apk")) {
                    afVar.a(R.drawable.ic_indicate_android);
                } else if (m.b(afVar.b(), "#ola")) {
                    afVar.a(R.drawable.ic_indicate_me);
                } else if (m.b(afVar.b(), "#hai")) {
                    afVar.a(R.drawable.ic_indicate_funny);
                } else if (m.b(afVar.b(), "my diary")) {
                    afVar.a(R.drawable.ic_indicate_note);
                } else if (m.b(afVar.b(), "mariage diary")) {
                    afVar.a(R.drawable.ic_indicate_box);
                }
                if (m.b(afVar.b(), "tl") || m.b(afVar.b(), "md") || m.b(afVar.b(), "av")) {
                    it2.remove();
                }
            }
            return arrayList;
        } catch (Throwable unused) {
            return new ArrayList();
        }
    }

    public void b(int i) {
        this.v = i;
    }

    public void b(chat.ola.vn.entry.a aVar) {
        try {
            y = -1;
            z = -1;
            this.k = aVar.a;
            try {
                int size = this.k.size();
                for (int i = 0; i < size; i++) {
                    chat.ola.vn.entry.b bVar = this.k.get(i);
                    if (bVar.b.k() == 4 || bVar.b.k() == 5 || bVar.b.k() == 3) {
                        y = i;
                    } else if (bVar.b.k() == 9) {
                        z = i;
                    }
                }
            } catch (Throwable unused) {
            }
            this.n = aVar.b;
            this.j = 0;
            this.p = false;
            Iterator<d> it2 = this.s.iterator();
            while (it2.hasNext()) {
                it2.next().a(aVar, this.k);
            }
        } catch (Throwable unused2) {
        }
    }

    public void b(d dVar) {
        if (dVar == null) {
            return;
        }
        int size = this.s.size();
        for (int i = 0; i < size; i++) {
            if (m.b(this.s.get(i).C(), dVar.C())) {
                this.s.remove(i);
                return;
            }
        }
    }

    public void b(String str, short s, List<g> list) {
        y = -1;
        z = -1;
        this.k = b(list);
        this.n = str;
        this.j = 0;
        this.p = false;
        if (str == null) {
            try {
                int iU = h.u.u();
                if (iU > 0) {
                    if (this.k != null) {
                        chat.ola.vn.entry.b bVarA = chat.ola.vn.entry.b.a();
                        if (this.k.size() > iU) {
                            this.k.add(iU + 1, bVarA);
                        } else {
                            this.k.add(bVarA);
                        }
                    }
                    chat.ola.vn.util.c.b.a(OlaApplication.a(), 117);
                    h.u.d(0);
                    try {
                        ((OlaBottomTabActivity) chat.ola.vn.c.c()).I();
                    } catch (Throwable unused) {
                    }
                }
                this.d = this.k.get(1).b.e();
            } catch (Throwable unused2) {
            }
        }
        Iterator<d> it2 = this.s.iterator();
        while (it2.hasNext()) {
            it2.next().e(this.k);
        }
    }

    public int c() {
        if (this.j == 1 && j() > 0) {
            this.j = 0;
        }
        return this.j;
    }

    public void c(int i) {
        this.w = i;
    }

    public void c(String str) {
        try {
            if (m.a(str)) {
                return;
            }
            if (!str.startsWith("#")) {
                str = "#" + str;
            }
            if (this.t.contains(str)) {
                return;
            }
            this.t.add(str);
            Iterator<d> it2 = this.s.iterator();
            while (it2.hasNext()) {
                it2.next().g(str);
            }
            chat.ola.vn.entity.x xVar = new chat.ola.vn.entity.x();
            xVar.c = str;
            xVar.a = (byte) 1;
            chat.ola.vn.g.a(xVar);
        } catch (Throwable unused) {
        }
    }

    public void c(List<g> list) {
        List<chat.ola.vn.entry.b> listB;
        if (list == null || list.size() == 0 || (listB = b(list)) == null || listB.size() == 0) {
            return;
        }
        this.k.addAll(listB);
        Iterator<d> it2 = this.s.iterator();
        while (it2.hasNext()) {
            it2.next().a(listB, this.k);
        }
    }

    public chat.ola.vn.entry.a d() {
        if (this.q == null || this.q.isEmpty()) {
            return null;
        }
        return this.q.pop();
    }

    public void d(int i) {
        if (this.u != i) {
            this.u = i;
            if (i > 0 && OlaApplication.e()) {
                chat.ola.vn.util.c.b.b(i);
            }
            Iterator<d> it2 = this.s.iterator();
            while (it2.hasNext()) {
                it2.next().d(i);
            }
        }
    }

    public void d(List<String> list) {
        this.t.clear();
        if (list != null) {
            this.t.addAll(list);
            for (String str : list) {
                chat.ola.vn.entity.x xVar = new chat.ola.vn.entity.x();
                xVar.c = str;
                xVar.a = (byte) 1;
                chat.ola.vn.g.a(xVar);
            }
            Iterator<d> it2 = this.s.iterator();
            while (it2.hasNext()) {
                it2.next().f(this.t);
            }
        }
    }

    public void e() {
        try {
            OlaApplication.a(new Runnable() { // from class: chat.ola.vn.r.a.e.1
                @Override // java.lang.Runnable
                public void run() {
                    int unused = e.y = -1;
                    int unused2 = e.z = -1;
                    e.this.k = new ArrayList();
                    e.this.l = new ArrayList();
                    e.this.q = new Stack();
                    e.this.t.clear();
                    e.this.m = null;
                    e.this.r = (short) 0;
                    e.this.p = false;
                    e.this.g = false;
                    e.this.n = null;
                    e.this.u = 0;
                    e.this.j = 1;
                    e.this.A = null;
                    Iterator it2 = e.this.s.iterator();
                    while (it2.hasNext()) {
                        ((d) it2.next()).E();
                    }
                    if (e.this.s != null) {
                        e.this.s.clear();
                    }
                }
            });
        } catch (Throwable unused) {
        }
    }

    public chat.ola.vn.entry.b f() {
        return this.o;
    }

    public String g() {
        return this.n;
    }

    public CharSequence h() {
        String strG = g();
        if (a(strG)) {
            return b(strG);
        }
        if (m.b(strG, "rss")) {
            return OlaApplication.a(R.string.general_tab_rss);
        }
        try {
            chat.ola.vn.message.f fVarE = h.t.e(strG, (short) 0);
            if (fVarE != null) {
                return fVarE.L();
            }
        } catch (Throwable unused) {
        }
        return strG;
    }

    public List<chat.ola.vn.entry.b> i() {
        if (this.k != null) {
            return new ArrayList(this.k);
        }
        return null;
    }

    public int j() {
        try {
            return this.k.size() + 0;
        } catch (Throwable unused) {
            return 0;
        }
    }

    public long k() {
        try {
            chat.ola.vn.entry.b bVar = this.k.get(this.k.size() - 1);
            return bVar.d() != 2 ? bVar.b.e() : this.k.get(this.k.size() - 2).b.e();
        } catch (Throwable unused) {
            return 0L;
        }
    }

    public long l() {
        try {
            return this.k.get(this.k.size() - 1).b.n();
        } catch (Throwable unused) {
            return 0L;
        }
    }

    public boolean m() {
        return this.p;
    }

    public void n() {
        if (this.l != null) {
            this.m = null;
            this.l.clear();
        }
        Iterator<d> it2 = this.s.iterator();
        while (it2.hasNext()) {
            it2.next().D();
        }
    }

    public long o() {
        if (this.m != null) {
            return this.m.e();
        }
        return 0L;
    }

    public long p() {
        try {
            g gVar = this.l.get(this.l.size() - 1).b;
            if (gVar != null) {
                return gVar.e();
            }
            return 0L;
        } catch (Throwable unused) {
            return 0L;
        }
    }

    public List<chat.ola.vn.entry.b> q() {
        if (this.l != null) {
            return new ArrayList(this.l);
        }
        return null;
    }

    public int r() {
        return this.v;
    }

    public int s() {
        return this.w;
    }

    public void t() {
        try {
            if (this.g) {
                List<chat.ola.vn.entry.g> listA = h.w.a();
                ArrayList arrayList = null;
                int size = (listA == null || listA.size() <= 0) ? 0 : listA.size() + 0;
                if (size > 0) {
                    arrayList = new ArrayList(size);
                    if (listA != null) {
                        try {
                            if (listA.size() > 0) {
                                int iMin = Math.min(listA.size(), 50);
                                for (int i = 0; i < iMin; i++) {
                                    arrayList.add(listA.get(i));
                                }
                            }
                        } catch (Throwable unused) {
                        }
                    }
                }
                aa aaVar = new aa();
                aaVar.a = "mehistory";
                if (arrayList == null || arrayList.size() <= 0) {
                    OlaApplication.b.b("bmk", new aa[]{aaVar}, (short) 0);
                } else {
                    aaVar.b = chat.ola.vn.h.b.b(arrayList);
                    OlaApplication.b.a("bmk", new aa[]{aaVar}, (short) 0);
                }
            }
        } catch (Throwable unused2) {
        }
    }

    public int u() {
        return this.u;
    }

    public List<String> v() {
        return this.t;
    }

    public boolean w() {
        try {
            if (y < 0) {
                return true;
            }
            return this.k.size() - y >= 15;
        } catch (Throwable unused) {
            return true;
        }
    }

    public boolean x() {
        try {
            if (z < 0) {
                return true;
            }
            return this.k.size() - z >= 30;
        } catch (Throwable unused) {
            return true;
        }
    }

    public chat.ola.vn.me.a y() {
        return this.A;
    }
}
