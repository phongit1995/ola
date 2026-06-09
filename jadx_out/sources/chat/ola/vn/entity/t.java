package chat.ola.vn.entity;

import android.annotation.SuppressLint;
import android.view.View;
import android.widget.ListView;
import chat.ola.vn.OlaApplication;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Random;

/* JADX INFO: loaded from: classes.dex */
@SuppressLint({"DefaultLocale"})
public class t extends ad {
    private boolean A;
    private String B;
    private long C;
    private boolean u;
    private List<t> v;
    private List<chat.ola.vn.entry.c> w;
    private List<chat.ola.vn.entry.b> x;
    private String y;
    private long z;

    public t(ad adVar) {
        this(adVar, null);
    }

    public t(ad adVar, List<t> list) {
        this.z = -1L;
        this.A = true;
        a(adVar);
        this.v = list;
    }

    public t(String str) {
        this.z = -1L;
        this.A = true;
        this.d = str;
        this.u = false;
    }

    public static List<t> c(List<ad> list) {
        if (list == null || list.isEmpty()) {
            return null;
        }
        ArrayList arrayList = new ArrayList();
        Iterator<ad> it2 = list.iterator();
        while (it2.hasNext()) {
            arrayList.add(new t(it2.next()));
        }
        return arrayList;
    }

    public long a() {
        return this.z;
    }

    public t a(int i) {
        if (this.v == null) {
            return null;
        }
        return this.v.get(i);
    }

    public void a(long j) {
        this.C = j;
    }

    public void a(ListView listView) {
        int top = 0;
        try {
            View childAt = listView.getChildAt(0);
            if (childAt != null) {
                top = childAt.getTop();
            }
            this.s = top;
            this.t = listView.getFirstVisiblePosition();
        } catch (Throwable unused) {
        }
    }

    public void a(ad adVar) {
        this.c = adVar.p();
        this.d = adVar.o();
        this.e = adVar.q();
        this.f = adVar.u();
        this.k = adVar.r();
        this.n = adVar.s();
        this.o = adVar.t();
        this.q = adVar.v();
        this.g = adVar.n();
        this.h = adVar.h();
        this.j = adVar.x();
        this.i = adVar.w();
        this.r = adVar.m();
        this.l = adVar.y();
        this.p = adVar.z();
        this.m = adVar.A();
        this.a = adVar.B();
        this.b = adVar.b;
        this.s = adVar.s;
        this.t = adVar.t;
        if (adVar instanceof t) {
            this.w = ((t) adVar).w;
        }
    }

    public void a(String str) {
        this.y = str;
    }

    public void a(List<t> list) {
        this.v = list;
    }

    public void a(boolean z) {
        this.u = z;
    }

    public boolean a(long j, List<g> list) {
        if (r() != j) {
            return false;
        }
        List<chat.ola.vn.entry.b> listB = chat.ola.vn.r.a.e.b(list);
        if (listB == null) {
            return true;
        }
        if (this.x == null) {
            this.x = listB;
            return true;
        }
        this.x.addAll(listB);
        return true;
    }

    public boolean a(g gVar, List<g> list) {
        if (r() != gVar.e()) {
            return false;
        }
        this.x = chat.ola.vn.r.a.e.b(list);
        return true;
    }

    public void b(long j) {
        this.z = j;
    }

    public void b(final ListView listView) {
        try {
            listView.postDelayed((this.s == 0 || this.t == 0) ? new Runnable() { // from class: chat.ola.vn.entity.t.2
                @Override // java.lang.Runnable
                public void run() {
                    try {
                        listView.setSelection(0);
                    } catch (Throwable unused) {
                    }
                }
            } : new Runnable() { // from class: chat.ola.vn.entity.t.1
                @Override // java.lang.Runnable
                public void run() {
                    try {
                        if (t.this.t >= 0) {
                            listView.setSelectionFromTop(t.this.t, t.this.s);
                        } else {
                            listView.setSelection(0);
                        }
                    } catch (Throwable unused) {
                    }
                }
            }, 250L);
        } catch (Throwable unused) {
        }
    }

    public void b(String str) {
        this.B = str;
    }

    public void b(List<t> list) {
        if (list != null) {
            if (this.v != null) {
                this.v.addAll(list);
            } else {
                this.v = new ArrayList(list);
            }
        }
    }

    public void b(boolean z) {
        this.A = z;
    }

    public boolean b() {
        return this.u;
    }

    public boolean b(g gVar, List<g> list) {
        return a(gVar.e(), list);
    }

    public void c() {
        try {
            this.x.clear();
        } catch (Throwable unused) {
        }
    }

    public List<chat.ola.vn.entry.b> d() {
        return this.x;
    }

    public List<chat.ola.vn.entry.c> e() {
        if (this.w == null) {
            f();
        }
        return this.w;
    }

    public void f() {
        chat.ola.vn.entry.c cVar;
        List<String> listB;
        List<String> listA;
        if (this.e == null || this.e.length <= 0) {
            this.w = null;
            return;
        }
        ArrayList arrayList = new ArrayList();
        int length = this.e.length;
        for (int i = 0; i < length; i++) {
            String str = this.e[i];
            if (i != 0 && str != null && str.trim().length() != 0) {
                String lowerCase = str.toLowerCase();
                ArrayList<String> arrayListB = chat.ola.vn.util.i.b((CharSequence) str);
                if (arrayListB != null && !arrayListB.isEmpty()) {
                    int size = arrayListB.size();
                    for (int i2 = 0; i2 < size; i2++) {
                        arrayList.add(new chat.ola.vn.entry.c((short) 0, arrayListB.get(i2)));
                    }
                } else if (lowerCase.indexOf("youtu") >= 0 && (listA = chat.ola.vn.util.i.a((CharSequence) str, false)) != null && !listA.isEmpty()) {
                    Iterator<String> it2 = listA.iterator();
                    while (it2.hasNext()) {
                        arrayList.add(new chat.ola.vn.entry.c((short) 1, it2.next()));
                    }
                } else if (lowerCase.indexOf("mall.ola.vn") < 0 || (listB = chat.ola.vn.util.i.b((CharSequence) str, false)) == null || listB.isEmpty()) {
                    arrayList.add(new chat.ola.vn.entry.c((short) 3, chat.ola.vn.util.i.c(str)));
                } else {
                    Iterator<String> it3 = listB.iterator();
                    while (it3.hasNext()) {
                        arrayList.add(new chat.ola.vn.entry.c((short) 2, it3.next()));
                    }
                }
            }
        }
        chat.ola.vn.entry.c cVarA = new chat.ola.vn.entry.c((short) 4, null).a(this);
        cVarA.a(t());
        cVarA.b(s());
        arrayList.add(cVarA);
        List<k> listM = chat.ola.vn.h.v.m();
        if (listM != null && listM.size() > 0 && System.currentTimeMillis() % 2 == 0) {
            int iNextInt = new Random(System.nanoTime()).nextInt(listM.size());
            k kVar = listM.get(iNextInt);
            if (chat.ola.vn.util.b.k(OlaApplication.a(), kVar.m)) {
                listM.remove(iNextInt);
                if (chat.ola.vn.util.a.c) {
                    cVar = new chat.ola.vn.entry.c((short) 5, null);
                }
            } else {
                cVar = new chat.ola.vn.entry.c((short) 5, null);
                cVar.a = kVar;
            }
            arrayList.add(cVar);
        } else if (chat.ola.vn.util.a.c) {
            cVar = new chat.ola.vn.entry.c((short) 5, null);
            arrayList.add(cVar);
        }
        if (this.a != null) {
            chat.ola.vn.entry.d dVar = new chat.ola.vn.entry.d();
            dVar.b = this.a;
            dVar.c = this.b;
            arrayList.add(dVar);
        }
        this.w = arrayList;
    }

    public ArrayList<String> g() {
        try {
            ArrayList<String> arrayList = new ArrayList<>();
            for (String str : this.e) {
                ArrayList<String> arrayListB = chat.ola.vn.util.i.b((CharSequence) str);
                if (arrayListB != null && !arrayListB.isEmpty()) {
                    arrayList.addAll(arrayListB);
                }
            }
            return arrayList;
        } catch (Throwable unused) {
            return null;
        }
    }

    @Override // chat.ola.vn.entity.ad
    public String h() {
        int i;
        if (this.h != null) {
            return this.h;
        }
        try {
        } catch (Throwable unused) {
        }
        for (String str : this.e) {
            ArrayList<String> arrayListB = chat.ola.vn.util.i.b((CharSequence) str);
            if (arrayListB != null && !arrayListB.isEmpty()) {
                this.h = arrayListB.get(0);
                return this.h;
            }
            return null;
        }
        return null;
    }

    public int i() {
        if (this.v == null) {
            return 0;
        }
        return this.v.size();
    }

    public String j() {
        return this.y;
    }

    public boolean k() {
        return this.A;
    }

    public String l() {
        return !chat.ola.vn.util.m.a(this.B) ? this.B : this.c;
    }
}
