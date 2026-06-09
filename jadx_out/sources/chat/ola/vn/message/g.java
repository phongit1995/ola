package chat.ola.vn.message;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.activity.OlaBottomTabActivity;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Random;
import java.util.concurrent.CopyOnWriteArrayList;

/* JADX INFO: loaded from: classes.dex */
public class g extends BaseAdapter {
    List<chat.ola.vn.p.f> a;
    List<f> h;
    List<f> i;
    private LayoutInflater r;
    private chat.ola.vn.e.g u;
    private o x;
    private chat.ola.vn.e.h y;
    List<f> b = null;
    List<f> c = null;
    List<f> d = null;
    List<f> e = null;
    List<f> f = null;
    List<f> g = null;
    Map<String, f> j = null;
    List<f> k = null;
    List<f> l = null;
    List<f> m = null;
    private int p = 0;
    private f q = null;
    List<chat.ola.vn.g.a> n = null;
    private String s = null;
    private Object t = new Object();
    private long v = 0;
    private boolean w = false;
    private byte o = 0;

    private LayoutInflater G() {
        if (this.r == null) {
            this.r = (LayoutInflater) OlaApplication.a().getSystemService("layout_inflater");
        }
        return this.r;
    }

    private void H() {
        boolean z;
        if (this.n == null) {
            this.n = new ArrayList(1000);
        }
        this.n.clear();
        this.n.add(new chat.ola.vn.g.f());
        if (B() || C()) {
            this.n.add(new chat.ola.vn.g.g());
        }
        this.n.add(new chat.ola.vn.g.c());
        chat.ola.vn.g.b bVar = new chat.ola.vn.g.b();
        bVar.a(true);
        this.n.add(bVar);
        if (this.c != null && this.c.size() > 0) {
            this.n.add(new chat.ola.vn.g.e(OlaApplication.a(R.string.string_birthday).toUpperCase(Locale.US)));
            int size = this.c.size();
            for (int i = 0; i < size; i++) {
                chat.ola.vn.g.d dVar = new chat.ola.vn.g.d(this.c.get(i));
                if (i == 0) {
                    dVar.b(true);
                }
                if (i == size - 1) {
                    dVar.a(true);
                }
                this.n.add(dVar);
            }
        }
        if (this.b != null && this.b.size() > 0) {
            this.n.add(new chat.ola.vn.g.e(OlaApplication.a(R.string.string_new_friends).toUpperCase(Locale.US)));
            int size2 = this.b.size();
            for (int i2 = 0; i2 < size2; i2++) {
                chat.ola.vn.g.d dVar2 = new chat.ola.vn.g.d(this.b.get(i2));
                dVar2.c(true);
                if (i2 == 0) {
                    dVar2.b(true);
                }
                if (i2 == size2 - 1) {
                    dVar2.a(true);
                }
                this.n.add(dVar2);
            }
        }
        if (this.d != null && this.d.size() > 0) {
            this.n.add(new chat.ola.vn.g.e(OlaApplication.a(R.string.string_utilities).toUpperCase(Locale.US)));
            int size3 = this.d.size();
            for (int i3 = 0; i3 < size3; i3++) {
                chat.ola.vn.g.d dVar3 = new chat.ola.vn.g.d(this.d.get(i3));
                if (i3 == 0) {
                    dVar3.b(true);
                }
                if (i3 == size3 - 1) {
                    dVar3.a(true);
                }
                this.n.add(dVar3);
            }
        }
        if (this.i != null && this.i.size() > 0) {
            if (this.u == null) {
                this.u = new chat.ola.vn.e.g();
            }
            Collections.sort(this.i, this.u);
            this.w = false;
            if (this.i.get(0).g() == 2) {
                this.n.add(new chat.ola.vn.g.e(OlaApplication.a(R.string.string_online).toUpperCase(Locale.US)));
                z = true;
            } else {
                z = false;
            }
            int size4 = this.i.size();
            chat.ola.vn.g.d dVar4 = null;
            boolean z2 = z;
            int i4 = 0;
            boolean z3 = false;
            while (i4 < size4) {
                f fVar = this.i.get(i4);
                if (fVar.g() != 2 && !z3) {
                    if (dVar4 != null) {
                        dVar4.a(true);
                    }
                    this.n.add(new chat.ola.vn.g.e(OlaApplication.a(R.string.string_friend).toUpperCase(Locale.US)));
                    z3 = true;
                    z2 = true;
                }
                dVar4 = new chat.ola.vn.g.d(fVar);
                dVar4.b(z2);
                this.n.add(dVar4);
                i4++;
                z2 = false;
            }
        }
        try {
            this.n.get(this.n.size() - 1).a(false);
        } catch (Throwable unused) {
        }
        notifyDataSetChanged();
    }

    private f a(f fVar, List<f> list, boolean z) {
        f fVarF = f(fVar.j(), fVar.k());
        if (fVarF != null) {
            if (!list.contains(fVarF)) {
                list.add(fVarF);
            }
            if (z) {
                fVarF.a(fVar);
            }
            return fVarF;
        }
        if (this.j == null) {
            this.j = new HashMap();
        }
        this.j.put(fVar.y(), fVar);
        list.add(fVar);
        return fVar;
    }

    private f a(String str, short s, boolean z, boolean z2) {
        f fVarD;
        if (z && s != 5 && s != 7) {
            try {
                OlaApplication.b.a(str, s, z2);
            } catch (Throwable unused) {
            }
        }
        try {
            if (this.k != null && this.j != null && (fVarD = d(str, s)) != null) {
                fVarD.B = true;
                if (!this.k.remove(fVarD)) {
                    int i = 0;
                    int size = this.k.size();
                    while (true) {
                        if (i >= size) {
                            break;
                        }
                        if (chat.ola.vn.util.m.a(this.k.get(i).y(), fVarD.y())) {
                            this.k.remove(i);
                            break;
                        }
                        i++;
                    }
                }
                if (fVarD.u() == 0) {
                    fVarD.A = null;
                }
                if (this.a != null) {
                    Iterator<chat.ola.vn.p.f> it2 = this.a.iterator();
                    while (it2.hasNext()) {
                        it2.next().c(fVarD);
                    }
                }
                if (OlaApplication.c != null) {
                    OlaApplication.c.b(fVarD);
                }
                c();
                i((f) null);
                if (z) {
                    fVarD.C();
                }
                try {
                    chat.ola.vn.h.b.b(chat.ola.vn.h.a(), p());
                } catch (Throwable unused2) {
                }
                return fVarD;
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
        return null;
    }

    private f b(f fVar, boolean z) {
        if (fVar == null) {
            return null;
        }
        if (this.j == null) {
            this.j = new HashMap();
        }
        f fVarD = d(fVar.j(), fVar.k());
        if (fVarD != null) {
            return fVarD;
        }
        if (this.k == null) {
            this.k = new ArrayList();
        }
        f fVarA = a(fVar, this.k, false);
        fVarA.A = this;
        if (z) {
            c();
        }
        if (fVar.k() == 0) {
            chat.ola.vn.entity.x xVar = new chat.ola.vn.entity.x();
            xVar.a = (byte) 0;
            xVar.c = "@" + fVarA.j();
            xVar.b = fVarA.e;
            chat.ola.vn.g.a(xVar);
        }
        if (this.a != null) {
            Iterator<chat.ola.vn.p.f> it2 = this.a.iterator();
            while (it2.hasNext()) {
                it2.next().b(fVarA);
            }
        }
        return fVarA;
    }

    private f g(String str) {
        try {
            f fVarH = h(str);
            if (fVarH == null) {
                return null;
            }
            if (this.i.contains(fVarH)) {
                return fVarH;
            }
            return null;
        } catch (Throwable unused) {
            return null;
        }
    }

    private f h(String str) {
        try {
            if (chat.ola.vn.util.m.a(str) || this.j == null) {
                return null;
            }
            return this.j.get(str);
        } catch (Throwable unused) {
            return null;
        }
    }

    private f l(f fVar) {
        if (fVar == null) {
            return null;
        }
        if (this.i == null) {
            this.i = new ArrayList(1000);
        }
        f fVarA = a(fVar, this.i, true);
        fVarA.G = true;
        fVarA.A = this;
        chat.ola.vn.entity.x xVar = new chat.ola.vn.entity.x();
        xVar.a = (byte) 0;
        xVar.c = "@" + fVarA.j();
        xVar.b = fVarA.e;
        chat.ola.vn.g.a(xVar);
        return fVarA;
    }

    private void m(f fVar) {
        if (fVar == null) {
            return;
        }
        if (this.b == null) {
            this.b = new ArrayList();
        }
        a(fVar, this.b, true);
    }

    public int A() {
        try {
            return this.g.size();
        } catch (Throwable unused) {
            return 0;
        }
    }

    public boolean B() {
        try {
            if (this.f != null) {
                return this.f.size() > 0;
            }
            return false;
        } catch (Throwable unused) {
            return false;
        }
    }

    public boolean C() {
        try {
            if (this.g != null) {
                return this.g.size() > 0;
            }
            return false;
        } catch (Throwable unused) {
            return false;
        }
    }

    public void D() {
        if (this.e == null || this.e.size() <= 0) {
            return;
        }
        try {
            String[] strArr = new String[this.e.size()];
            String[] strArr2 = new String[this.e.size()];
            for (int i = 0; i < strArr2.length; i++) {
                strArr[i] = this.e.get(i).p();
                strArr2[i] = this.e.get(i).b();
            }
            OlaApplication.b.a(strArr, strArr2, (short) 0);
        } catch (Throwable unused) {
        }
    }

    public int E() {
        if (this.m != null) {
            return this.m.size();
        }
        return 0;
    }

    public String F() {
        return this.s;
    }

    public f a(int i) {
        try {
            return this.c.get(i);
        } catch (Throwable unused) {
            return null;
        }
    }

    public f a(long j) {
        if (this.q == null) {
            return null;
        }
        if (chat.ola.vn.util.m.b(this.q.j(), j + "")) {
            return this.q;
        }
        return null;
    }

    public f a(long j, String str) {
        try {
            this.q = new f(j + "", (short) 4);
            this.q.c(str);
            this.q.A = this;
            return this.q;
        } catch (Throwable unused) {
            return null;
        }
    }

    public f a(f fVar) {
        if (fVar == null) {
            return null;
        }
        return fVar.k() == 4 ? fVar : a(fVar.j(), fVar.k(), false, false);
    }

    public f a(f fVar, boolean z) {
        if (fVar == null) {
            return null;
        }
        return a(fVar.j(), fVar.k(), z);
    }

    public f a(String str, short s) {
        return a(str, s, true, true);
    }

    public f a(String str, short s, boolean z) {
        return a(str, s, true, z);
    }

    public void a() {
        try {
            OlaApplication.b.x();
            int size = this.k.size();
            if (this.k != null) {
                while (this.k.size() > 0 && size > 0) {
                    size--;
                    f fVar = this.k.get(0);
                    a(fVar.j(), fVar.k(), false, false);
                }
            }
            g();
            h();
        } catch (Throwable unused) {
        }
    }

    public void a(byte b) {
        try {
            if (this.o != b) {
                this.o = b;
                if (this.a != null) {
                    Iterator<chat.ola.vn.p.f> it2 = this.a.iterator();
                    while (it2.hasNext()) {
                        it2.next().c(n());
                    }
                }
            }
        } catch (Throwable unused) {
        }
    }

    void a(d dVar, byte b, byte b2) {
        if (this.a != null) {
            Iterator<chat.ola.vn.p.f> it2 = this.a.iterator();
            while (it2.hasNext()) {
                it2.next().a(dVar, b, b2);
            }
        }
    }

    void a(f fVar, int i, String str, List<d> list) {
        if (this.a != null) {
            Iterator<chat.ola.vn.p.f> it2 = this.a.iterator();
            while (it2.hasNext()) {
                it2.next().a(fVar, i, str, list);
            }
        }
    }

    void a(f fVar, d dVar) {
        if (this.a != null) {
            Iterator<chat.ola.vn.p.f> it2 = this.a.iterator();
            while (it2.hasNext()) {
                it2.next().a(fVar, dVar);
            }
        }
    }

    void a(f fVar, List<d> list) {
        if (this.a != null) {
            Iterator<chat.ola.vn.p.f> it2 = this.a.iterator();
            while (it2.hasNext()) {
                it2.next().a(fVar, list);
            }
        }
    }

    public void a(chat.ola.vn.p.f fVar) {
        if (fVar == null) {
            return;
        }
        if (this.a == null) {
            this.a = new CopyOnWriteArrayList();
        }
        int i = 0;
        int size = this.a.size();
        while (true) {
            if (i >= size) {
                break;
            }
            if (chat.ola.vn.util.m.b(this.a.get(i).i_(), fVar.i_())) {
                this.a.remove(i);
                break;
            }
            i++;
        }
        this.a.add(fVar);
    }

    public void a(Short sh, int i) {
        Iterator<chat.ola.vn.p.f> it2 = this.a.iterator();
        while (it2.hasNext()) {
            it2.next().b(sh, i);
        }
    }

    public void a(String str) {
        if (str == null) {
            return;
        }
        try {
            if (this.g.remove(str)) {
                return;
            }
            for (f fVar : this.g) {
                if (chat.ola.vn.util.m.b(fVar.j(), str)) {
                    this.g.remove(fVar);
                    return;
                }
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public void a(String str, f fVar) {
        try {
            f fVarRemove = this.j.remove(fVar.y());
            if (fVarRemove != null) {
                this.j.put(str, fVarRemove);
            } else {
                this.j.put(str, fVar);
            }
        } catch (Throwable unused) {
        }
    }

    public void a(String str, String str2) {
        if (str == null) {
            return;
        }
        try {
            if (!this.f.remove(str)) {
                Iterator<f> it2 = this.f.iterator();
                while (true) {
                    if (!it2.hasNext()) {
                        break;
                    }
                    f next = it2.next();
                    if (chat.ola.vn.util.m.b(next.j(), str)) {
                        this.f.remove(next);
                        break;
                    }
                }
            }
            if (this.h == null) {
                this.h = new ArrayList();
            }
            boolean z = true;
            Iterator<f> it3 = this.h.iterator();
            while (true) {
                if (!it3.hasNext()) {
                    break;
                } else if (chat.ola.vn.util.m.b(it3.next().j(), str)) {
                    z = false;
                    break;
                }
            }
            if (z) {
                f fVar = new f(str, (short) 0);
                fVar.h(str2);
                this.h.add(fVar);
                chat.ola.vn.h.b.c(chat.ola.vn.h.a(), this.h);
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public void a(List<f> list) {
        if (list != null) {
            try {
                if (list.size() == 0) {
                    return;
                }
                OlaApplication.b.b(list);
                for (f fVar : list) {
                    a(fVar.j(), fVar.k(), false, false);
                }
            } catch (Throwable unused) {
            }
        }
    }

    public void a(List<f> list, String str) {
        synchronized (this.t) {
            if (chat.ola.vn.util.m.a(this.s)) {
                if (list != null && list.size() != 0) {
                    if (this.k != null) {
                        this.k.clear();
                    }
                }
                this.s = "null";
                if (this.k != null) {
                    this.k.clear();
                    h();
                    if (this.a != null) {
                        Iterator<chat.ola.vn.p.f> it2 = this.a.iterator();
                        while (it2.hasNext()) {
                            it2.next().C();
                        }
                    }
                }
                return;
            }
            if (list != null && list.size() != 0) {
                if (this.k == null) {
                    this.k = new ArrayList(list.size());
                }
                int i = 0;
                for (f fVar : list) {
                    f fVarB = b(fVar, false);
                    int iZ = fVar.z();
                    if (iZ > 0) {
                        i += iZ;
                        fVarB.D();
                        fVarB.a(iZ);
                        if (fVarB.H() && fVarB.G) {
                            try {
                                OlaApplication.c.a(fVarB, OlaApplication.e());
                            } catch (Throwable unused) {
                            }
                        }
                    }
                    fVarB.S = fVar.S;
                    fVarB.B = false;
                }
                if (i > 0) {
                    try {
                        chat.ola.vn.util.c.b.a(i);
                    } catch (Throwable unused2) {
                    }
                }
                c();
                this.s = str;
                return;
            }
            this.s = "null";
        }
    }

    public boolean a(Context context, View view, int i, long j) {
        try {
            return this.n.get(i).a(context, view, i, j);
        } catch (Throwable unused) {
            return false;
        }
    }

    public f b(int i) {
        try {
            return this.x.F().get(i);
        } catch (Throwable unused) {
            return null;
        }
    }

    public f b(f fVar) {
        if (fVar == null) {
            return null;
        }
        return a(fVar.j(), fVar.k());
    }

    public f b(String str) {
        try {
            f fVarH = h(str);
            if (fVarH != null) {
                if (this.k.contains(fVarH)) {
                    return fVarH;
                }
                return null;
            }
            for (f fVar : this.k) {
                if (chat.ola.vn.util.m.b(fVar.y(), str)) {
                    if (this.j == null) {
                        this.j = new HashMap();
                    }
                    this.j.put(str, fVar);
                    return fVar;
                }
            }
            return null;
        } catch (Throwable unused) {
            return null;
        }
    }

    public f b(String str, short s) {
        return a(str, s, false, false);
    }

    public f b(String str, short s, boolean z) {
        f fVarD = d(str, s);
        return (fVarD == null && z) ? c(str, s) : fVarD;
    }

    public List<String> b() {
        ArrayList arrayList = new ArrayList();
        for (f fVar : this.i) {
            if (!arrayList.contains(fVar.j())) {
                arrayList.add(fVar.j());
            }
        }
        if (this.k != null) {
            for (f fVar2 : this.k) {
                if (!arrayList.contains(fVar2.j())) {
                    arrayList.add(fVar2.j());
                }
            }
        }
        return arrayList;
    }

    public void b(Context context, View view, int i, long j) {
        try {
            this.n.get(i).b(context, view, i, j);
        } catch (Throwable unused) {
        }
    }

    void b(f fVar, d dVar) {
        if (this.a != null) {
            Iterator<chat.ola.vn.p.f> it2 = this.a.iterator();
            while (it2.hasNext()) {
                it2.next().b(fVar, dVar);
            }
        }
    }

    public void b(chat.ola.vn.p.f fVar) {
        if (fVar == null || this.a == null) {
            return;
        }
        int size = this.a.size();
        for (int i = 0; i < size; i++) {
            if (chat.ola.vn.util.m.b(this.a.get(i).i_(), fVar.i_())) {
                this.a.remove(i);
                return;
            }
        }
    }

    public void b(List<f> list) {
        if (this.d == null) {
            this.d = new ArrayList();
        }
        this.d.clear();
        if (list != null && list.size() > 0) {
            Iterator<f> it2 = list.iterator();
            while (it2.hasNext()) {
                a(it2.next(), this.d, true);
            }
        }
        H();
    }

    public f c(int i) {
        try {
            return chat.ola.vn.c.x.v ? this.l.get(i) : this.k.get(i);
        } catch (Throwable unused) {
            return null;
        }
    }

    public f c(f fVar) {
        return b(fVar, true);
    }

    public f c(String str, short s) {
        if (chat.ola.vn.util.m.a(str)) {
            return null;
        }
        f fVarD = d(str, s);
        if (fVarD == null) {
            fVarD = new f(str, s);
        }
        return b(fVarD, true);
    }

    public void c() {
        try {
            if (this.y == null) {
                this.y = new chat.ola.vn.e.h();
            }
            if (!chat.ola.vn.c.x.v) {
                Collections.sort(this.k, this.y);
                return;
            }
            if (this.x == null) {
                this.x = new o();
            }
            List<f> arrayList = this.x.c;
            if (arrayList == null) {
                arrayList = new ArrayList<>();
            }
            arrayList.clear();
            if (this.l == null) {
                this.l = new ArrayList(1000);
            }
            this.l.clear();
            try {
                for (f fVar : this.k) {
                    if (fVar.k() != 0 || fVar.W()) {
                        this.l.add(fVar);
                    } else {
                        arrayList.add(fVar);
                    }
                }
                this.x.a(arrayList);
                if (arrayList.size() > 0) {
                    this.l.add(this.x);
                }
                Collections.sort(this.l, this.y);
            } catch (Throwable unused) {
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public void c(List<f> list) {
        if (this.c == null) {
            this.c = new ArrayList();
        }
        this.c.clear();
        if (list != null && list.size() > 0) {
            Iterator<f> it2 = list.iterator();
            while (it2.hasNext()) {
                a(it2.next(), this.c, true);
            }
        }
        H();
    }

    public boolean c(String str) {
        try {
            return h(f.b(str, (short) 0)).G;
        } catch (Throwable unused) {
            return false;
        }
    }

    public int d() {
        try {
            return this.c.size();
        } catch (Throwable unused) {
            return 0;
        }
    }

    public f d(int i) {
        if (this.m != null) {
            return this.m.get(i);
        }
        return null;
    }

    public f d(String str) {
        return e(str, (short) 0);
    }

    public f d(String str, short s) {
        if (chat.ola.vn.util.m.a(str)) {
            return null;
        }
        return s == 4 ? this.q : b(f.b(str, s));
    }

    public void d(f fVar) {
        if (fVar == null) {
            return;
        }
        try {
            f fVarE = e(fVar.j(), fVar.k());
            if (fVarE != null) {
                fVarE.G = false;
                this.i.remove(fVarE);
                try {
                    if (!this.k.contains(fVarE)) {
                        this.j.remove(fVarE.y());
                    }
                } catch (Throwable unused) {
                    this.j.remove(fVarE.y());
                }
                try {
                    this.b.remove(fVarE);
                } catch (Throwable unused2) {
                }
                H();
                notifyDataSetChanged();
            }
        } catch (Throwable unused3) {
        }
    }

    public void d(List<f> list) {
        if (this.i == null) {
            this.i = new ArrayList();
        }
        this.i.clear();
        if (list != null && list.size() > 0) {
            Iterator<f> it2 = list.iterator();
            while (it2.hasNext()) {
                l(it2.next());
            }
        }
        H();
    }

    public f e(int i) {
        int size = 0;
        try {
            size = 0 + this.f.size();
            return this.f.get(i);
        } catch (Throwable unused) {
            try {
                return this.g.get(i - size);
            } catch (Throwable unused2) {
                return null;
            }
        }
    }

    public f e(f fVar) {
        boolean z = e(fVar.j(), fVar.k()) == null;
        f fVarL = l(fVar);
        if (z) {
            m(fVarL);
            H();
        }
        return fVarL;
    }

    public f e(String str) {
        f fVarH = h(f.b(str, (short) 2));
        if (fVarH == null || !this.m.contains(fVarH)) {
            return null;
        }
        return fVarH;
    }

    public f e(String str, short s) {
        return g(f.b(str, s));
    }

    public List<f> e() {
        if (this.i != null) {
            return new ArrayList(this.i);
        }
        return null;
    }

    public void e(List<f> list) {
        synchronized (this.t) {
            if (this.k == null || this.k.isEmpty()) {
                if (list != null && list.size() != 0) {
                    if (this.k != null) {
                        this.k.clear();
                    } else {
                        this.k = new ArrayList(list.size());
                    }
                    for (f fVar : list) {
                        final f fVarB = b(fVar, false);
                        int iZ = fVar.z();
                        if (iZ > 0) {
                            final int i = iZ + 0;
                            fVarB.a(iZ);
                            try {
                                OlaApplication.a(new Runnable() { // from class: chat.ola.vn.message.g.1
                                    @Override // java.lang.Runnable
                                    public void run() {
                                        if (fVarB.S != null) {
                                            chat.ola.vn.util.c.b.a(fVarB, fVarB.S);
                                        } else {
                                            chat.ola.vn.util.c.b.a(i);
                                        }
                                    }
                                }, 3000L);
                            } catch (Throwable unused) {
                            }
                        }
                        fVarB.B = false;
                    }
                    c();
                    return;
                }
                if (this.k != null) {
                    this.k.clear();
                }
                h();
            }
        }
    }

    public f f(int i) {
        try {
            return this.g.get(i);
        } catch (Throwable unused) {
            return null;
        }
    }

    public f f(String str, short s) {
        try {
            if (chat.ola.vn.util.m.a(str)) {
                return null;
            }
            return h(f.b(str, s));
        } catch (Throwable unused) {
            return null;
        }
    }

    public void f() {
        a("admob-native", (short) 6);
    }

    public void f(String str) {
        try {
            this.m.remove(e(str));
        } catch (Throwable unused) {
        }
    }

    public void f(List<String> list) {
    }

    public boolean f(f fVar) {
        try {
            if (this.a == null) {
                return false;
            }
            for (chat.ola.vn.p.f fVar2 : this.a) {
                if (fVar2.H()) {
                    return fVar2.g(fVar);
                }
            }
            return false;
        } catch (Throwable unused) {
            return false;
        }
    }

    public void g() {
        try {
            if (this.k != null) {
                try {
                    for (f fVar : this.k) {
                        if (fVar.k() == 5 && (fVar instanceof h)) {
                            return;
                        }
                    }
                } catch (Throwable unused) {
                }
                List<chat.ola.vn.entity.k> listM = chat.ola.vn.h.v.m();
                if (listM == null || listM.size() <= 0) {
                    return;
                }
                chat.ola.vn.entity.k kVar = listM.get(new Random(System.nanoTime()).nextInt(listM.size()));
                if (chat.ola.vn.util.b.k(OlaApplication.a(), kVar.m)) {
                    return;
                }
                h hVar = new h(kVar);
                c(hVar);
                if (this.a != null) {
                    Iterator<chat.ola.vn.p.f> it2 = this.a.iterator();
                    while (it2.hasNext()) {
                        it2.next().b(hVar);
                    }
                }
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    void g(f fVar) {
        if (this.a != null) {
            Iterator<chat.ola.vn.p.f> it2 = this.a.iterator();
            while (it2.hasNext()) {
                it2.next().e(fVar);
            }
        }
    }

    public void g(List<f> list) {
        this.e = new ArrayList(list);
        try {
            if (OlaApplication.b.h()) {
                D();
            }
        } catch (Throwable unused) {
        }
    }

    @Override // android.widget.Adapter
    public int getCount() {
        try {
            return this.n.size();
        } catch (Throwable unused) {
            return 0;
        }
    }

    @Override // android.widget.Adapter
    public Object getItem(int i) {
        try {
            return this.n.get(i);
        } catch (Throwable unused) {
            return null;
        }
    }

    @Override // android.widget.Adapter
    public long getItemId(int i) {
        return i;
    }

    @Override // android.widget.BaseAdapter, android.widget.Adapter
    public int getItemViewType(int i) {
        try {
            return this.n.get(i).a();
        } catch (Throwable unused) {
            return 7;
        }
    }

    @Override // android.widget.Adapter
    public View getView(int i, View view, ViewGroup viewGroup) {
        try {
            chat.ola.vn.g.a aVar = this.n.get(i);
            if (view == null) {
                view = aVar.a(G());
            }
            chat.ola.vn.g.h hVarA = aVar.a(view, (chat.ola.vn.g.h) view.getTag());
            view.setTag(hVarA);
            if (hVarA != null) {
                hVarA.a(i);
            }
        } catch (Throwable unused) {
        }
        return view;
    }

    @Override // android.widget.BaseAdapter, android.widget.Adapter
    public int getViewTypeCount() {
        return 8;
    }

    public void h() {
        boolean z;
        boolean z2 = false;
        short s = 1;
        try {
            z = false;
            for (f fVar : this.k) {
                try {
                    if (fVar.k() == 5) {
                        if (fVar instanceof m) {
                            z2 = true;
                        } else if (chat.ola.vn.util.m.b(fVar.j(), "hi")) {
                            z = true;
                        }
                        if (z2 && z) {
                            break;
                        }
                    }
                } catch (Throwable unused) {
                }
            }
        } catch (Throwable unused2) {
            z = false;
        }
        if (!z2) {
            try {
                m mVar = new m();
                c(mVar);
                if (this.a != null) {
                    Iterator<chat.ola.vn.p.f> it2 = this.a.iterator();
                    while (it2.hasNext()) {
                        it2.next().b(mVar);
                    }
                }
            } catch (Throwable th) {
                th.printStackTrace();
                return;
            }
        }
        if (z) {
            return;
        }
        f fVar2 = new f("hi", s) { // from class: chat.ola.vn.message.g.2
            @Override // chat.ola.vn.message.f
            public String w() {
                String strW = super.w();
                try {
                    return chat.ola.vn.util.m.a(strW) ? OlaApplication.a(R.string.string_chat_with_incognito) : strW;
                } catch (Throwable unused3) {
                    return strW;
                }
            }
        };
        fVar2.c("Chat ROBOT");
        c(fVar2);
        if (this.a != null) {
            Iterator<chat.ola.vn.p.f> it3 = this.a.iterator();
            while (it3.hasNext()) {
                it3.next().b(fVar2);
            }
        }
    }

    void h(f fVar) {
        if (this.a != null) {
            Iterator<chat.ola.vn.p.f> it2 = this.a.iterator();
            while (it2.hasNext()) {
                it2.next().f(fVar);
            }
        }
    }

    public void h(List<f> list) {
        this.g = new ArrayList(list);
        H();
    }

    public int i() {
        try {
            return this.x.F().size();
        } catch (Throwable unused) {
            return 0;
        }
    }

    void i(f fVar) {
        int iZ = 0;
        if (fVar != null) {
            try {
                if (fVar.k() == 4) {
                    try {
                        ((OlaBottomTabActivity) OlaBottomTabActivity.c()).G();
                        return;
                    } catch (Throwable unused) {
                        return;
                    }
                }
            } catch (Throwable unused2) {
                return;
            }
        }
        if (this.k != null) {
            Iterator<f> it2 = this.k.iterator();
            while (it2.hasNext()) {
                iZ += it2.next().z();
            }
        }
        if (this.a != null) {
            Iterator<chat.ola.vn.p.f> it3 = this.a.iterator();
            while (it3.hasNext()) {
                it3.next().c(iZ);
            }
        }
        if (this.p != iZ) {
            this.p = iZ;
            OlaApplication.b(this.p);
            if (this.p == 0) {
                chat.ola.vn.util.c.b.a(OlaApplication.a());
            }
        }
    }

    public void i(List<f> list) {
        this.f = new ArrayList(list.size());
        int size = list.size();
        for (int i = 0; i < size; i++) {
            f fVar = list.get(i);
            f fVarH = h(fVar.y());
            if (fVarH == null) {
                Iterator<f> it2 = this.e.iterator();
                while (true) {
                    if (it2.hasNext()) {
                        f next = it2.next();
                        if (chat.ola.vn.util.o.b(next.p(), fVar.p())) {
                            f fVarA = a(fVar, this.f, false);
                            fVarA.c(next.b());
                            fVarA.h(next.p());
                            break;
                        }
                    }
                }
            } else {
                Iterator<f> it3 = this.e.iterator();
                while (true) {
                    if (it3.hasNext()) {
                        f next2 = it3.next();
                        if (chat.ola.vn.util.o.b(next2.p(), fVar.p())) {
                            if (e(fVarH.j(), fVarH.k()) == null) {
                                a(fVarH, this.f, false);
                            }
                            fVarH.c(next2.b());
                            fVarH.h(next2.p());
                        }
                    }
                }
            }
        }
        Collections.sort(this.f, new chat.ola.vn.e.f());
        H();
    }

    public int j() {
        try {
            return chat.ola.vn.c.x.v ? this.l.size() : this.k.size();
        } catch (Throwable unused) {
            return 0;
        }
    }

    void j(f fVar) {
        if (this.a != null) {
            Iterator<chat.ola.vn.p.f> it2 = this.a.iterator();
            while (it2.hasNext()) {
                it2.next().d(fVar);
            }
        }
        notifyDataSetChanged();
    }

    public void j(List<f> list) {
        if (this.m == null) {
            this.m = new ArrayList();
        }
        this.m.clear();
        if (list == null || list.size() <= 0) {
            return;
        }
        Iterator<f> it2 = list.iterator();
        while (it2.hasNext()) {
            a(it2.next(), this.m, true);
        }
    }

    public void k() {
        a((byte) 0);
        try {
            this.s = null;
            if (this.i != null) {
                this.i.clear();
                this.i = null;
            }
            if (this.b != null) {
                this.b.clear();
                this.b = null;
            }
            if (this.c != null) {
                this.c.clear();
                this.c = null;
            }
            if (this.d != null) {
                this.d.clear();
                this.d = null;
            }
            if (this.e != null) {
                this.e.clear();
                this.e = null;
            }
            if (this.f != null) {
                this.f.clear();
                this.f = null;
            }
            if (this.g != null) {
                this.g.clear();
                this.g = null;
            }
            if (this.j != null) {
                this.j.clear();
                this.j = null;
            }
            if (this.k != null) {
                this.k.clear();
                this.k = null;
            }
            if (this.m != null) {
                this.m.clear();
                this.m = null;
            }
            H();
        } catch (Throwable unused) {
        }
    }

    public void k(f fVar) {
        if (this.m == null) {
            this.m = new ArrayList();
        }
        if (fVar == null) {
            return;
        }
        a(fVar, this.m, true);
    }

    public void k(List<f> list) {
        this.h = list;
    }

    public void l() {
        try {
            OlaApplication.a(new Runnable() { // from class: chat.ola.vn.message.g.3
                @Override // java.lang.Runnable
                public void run() {
                    g.this.k();
                }
            });
        } catch (Throwable unused) {
        }
    }

    public byte m() {
        return this.o;
    }

    public boolean n() {
        return this.o == 3;
    }

    public List<f> o() {
        try {
            ArrayList arrayList = null;
            for (f fVar : this.k) {
                if (fVar.H() && fVar.z() > 0 && fVar.G) {
                    if (arrayList == null) {
                        arrayList = new ArrayList();
                    }
                    arrayList.add(fVar);
                }
            }
            return arrayList;
        } catch (Throwable unused) {
            return null;
        }
    }

    public List<f> p() {
        if (this.k != null) {
            return new ArrayList(this.k);
        }
        return null;
    }

    public int q() {
        int iZ = 0;
        if (this.k != null) {
            for (f fVar : this.k) {
                if (fVar.W()) {
                    iZ += fVar.z();
                }
            }
        }
        return iZ;
    }

    public void r() {
        if (this.w) {
            this.v = System.currentTimeMillis();
            H();
        }
    }

    public void s() {
        if (System.currentTimeMillis() - this.v < 180000) {
            this.w = true;
        } else {
            this.v = System.currentTimeMillis();
            H();
        }
    }

    public void t() {
        if (this.k != null) {
            c();
            if (this.a != null) {
                Iterator<chat.ola.vn.p.f> it2 = this.a.iterator();
                while (it2.hasNext()) {
                    it2.next().c(this.k);
                }
            }
        }
    }

    void u() {
        if (this.a != null) {
            Iterator<chat.ola.vn.p.f> it2 = this.a.iterator();
            while (it2.hasNext()) {
                it2.next().a_();
            }
        }
    }

    public void v() {
        try {
            this.q.C();
        } catch (Throwable th) {
            this.q = null;
            throw th;
        }
        this.q = null;
    }

    public int w() {
        if (this.f != null) {
            return this.f.size();
        }
        return 0;
    }

    public List<f> x() {
        ArrayList arrayList;
        if (this.f != null) {
            arrayList = new ArrayList(this.f.size());
            arrayList.addAll(this.f);
        } else {
            arrayList = null;
        }
        if (this.g != null) {
            if (arrayList == null) {
                arrayList = new ArrayList(this.g.size());
            }
            arrayList.addAll(this.g);
        }
        return arrayList;
    }

    public List<f> y() {
        if (this.g != null) {
            return new ArrayList(this.g);
        }
        return null;
    }

    public void z() {
    }
}
