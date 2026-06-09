package chat.ola.vn.r.a;

import android.annotation.SuppressLint;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.entity.k;
import chat.ola.vn.entity.s;
import chat.ola.vn.h;
import chat.ola.vn.util.m;
import com.google.android.gms.maps.model.MarkerOptions;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Random;

/* JADX INFO: loaded from: classes.dex */
@SuppressLint({"DefaultLocale"})
public class f {
    public static short a = 1;
    public static short b = 2;
    public static short c = 4;
    public static short d = 8;
    public static short e = 255;
    public String f;
    private int h;
    private List<s> j;
    private s o;
    private boolean p;
    private s s;
    private short g = e;
    private List<MarkerOptions> q = null;
    private Map<String, MarkerOptions> r = null;
    private List<s> i = new ArrayList();
    private List<chat.ola.vn.message.f> k = new ArrayList(500);
    private List<chat.ola.vn.message.f> l = new ArrayList(500);
    private List<chat.ola.vn.message.f> m = new ArrayList();
    private Map<String, chat.ola.vn.message.f> n = new HashMap();

    private void s() {
        try {
            a(this.o, new ArrayList(this.l));
        } catch (Throwable unused) {
        }
    }

    public s a(long j) {
        try {
            for (s sVar : this.i) {
                if (sVar.c() == j) {
                    return sVar;
                }
            }
            return null;
        } catch (Throwable unused) {
            return null;
        }
    }

    public chat.ola.vn.message.f a(String str) {
        if (m.a(str)) {
            return null;
        }
        return this.n.get(str.toLowerCase());
    }

    public void a(int i) {
        this.h = i;
    }

    public void a(s sVar, List<chat.ola.vn.message.f> list) {
        n();
        this.l.clear();
        this.l.addAll(list);
        this.k.clear();
        if ((this.g & e) == e) {
            this.k.addAll(list);
        } else {
            for (chat.ola.vn.message.f fVar : list) {
                if (fVar.k() == 5 || fVar.k() == 6 || (((this.g & a) == a && (fVar.r() == 0 || fVar.r() == -1)) || (((this.g & b) == b && (fVar.r() == 1 || fVar.r() == -1)) || (((this.g & c) == c && (fVar.r() == 2 || fVar.r() == -1)) || ((this.g & d) == d && !m.a(fVar.R) && fVar.R.charAt(1) == 'P'))))) {
                    this.k.add(fVar);
                }
            }
        }
        if (this.k != null && sVar != null) {
            sVar.a(this.k.size());
        }
        if (chat.ola.vn.util.a.a) {
            chat.ola.vn.message.a aVar = new chat.ola.vn.message.a();
            int iNextInt = new Random().nextInt(10) + 3;
            if (iNextInt >= this.k.size()) {
                iNextInt = this.k.size() - 1;
            }
            this.k.add(iNextInt, aVar);
        }
        this.n.clear();
        for (chat.ola.vn.message.f fVar2 : list) {
            if (fVar2.k() != 5 && fVar2.k() != 6) {
                this.n.put(fVar2.j().toLowerCase(), fVar2);
            }
        }
        this.o = sVar;
    }

    public void a(List<s> list) {
        try {
            this.s = null;
            if (this.i == null) {
                this.i = new ArrayList();
            }
            this.i.clear();
            int size = list.size();
            int i = 0;
            while (true) {
                if (i >= size) {
                    break;
                }
                s sVar = list.get(i);
                if (sVar.c() <= 0) {
                    this.s = sVar;
                    this.s.a((byte) 1);
                    list.remove(i);
                    break;
                }
                i++;
            }
            this.i.addAll(list);
            if (this.h != 1) {
                a(0);
            }
            b();
        } catch (Throwable unused) {
        }
    }

    public void a(short s) {
        if (this.g != s) {
            this.g = s;
            s();
        }
    }

    public void a(boolean z) {
        this.p = z;
    }

    public boolean a() {
        return (this.k == null || this.k.isEmpty()) ? false : true;
    }

    public boolean a(MarkerOptions markerOptions) {
        try {
            if (this.q == null) {
                this.q = new LinkedList();
            }
            if (this.r == null) {
                this.r = new HashMap();
            }
            String lowerCase = markerOptions.getSnippet().toLowerCase();
            if (m.a(lowerCase) || this.r.get(lowerCase) != null) {
                return false;
            }
            this.q.add(markerOptions);
            this.r.put(lowerCase, markerOptions);
            return true;
        } catch (Throwable unused) {
            return false;
        }
    }

    public s b(int i) {
        try {
            return this.j.get(i);
        } catch (Throwable unused) {
            return null;
        }
    }

    public void b() {
        if (this.j == null) {
            this.j = new ArrayList();
        }
        this.j.clear();
        if (h.O.u == 0 || ((h.O.q > 0 && h.O.q < 3) || !h.O.x)) {
            this.j.add(new s((byte) 6));
        }
        if (this.s != null) {
            this.j.add(this.s);
        }
        s sVar = new s((byte) 5);
        sVar.a(OlaApplication.a(R.string.string_auto_join_room));
        sVar.c(OlaApplication.a(R.string.string_auto_join_room_description));
        this.j.add(sVar);
        if (this.i == null || this.i.size() <= 0) {
            List<k> listM = h.v.m();
            if (listM == null || listM.size() <= 0) {
                return;
            }
            k kVar = listM.get(new Random(System.nanoTime()).nextInt(listM.size()));
            if (chat.ola.vn.util.b.k(OlaApplication.a(), kVar.m)) {
                return;
            }
            s sVar2 = new s((byte) 2);
            sVar2.a(OlaApplication.a(R.string.string_room_list));
            this.j.add(sVar2);
            s sVar3 = new s((byte) 3);
            sVar3.a(kVar.a);
            sVar3.c(kVar.f);
            sVar3.d(kVar.j);
            sVar3.a = kVar;
            this.j.add(sVar3);
            return;
        }
        s sVar4 = new s((byte) 2);
        sVar4.a(OlaApplication.a(R.string.string_room_list));
        this.j.add(sVar4);
        int size = this.j.size() + 1;
        this.j.addAll(this.i);
        try {
            List<k> listM2 = h.v.m();
            if (listM2 != null && listM2.size() > 0) {
                k kVar2 = listM2.get(new Random(System.nanoTime()).nextInt(listM2.size()));
                if (!chat.ola.vn.util.b.k(OlaApplication.a(), kVar2.m)) {
                    s sVar5 = new s((byte) 3);
                    sVar5.a(kVar2.a);
                    sVar5.c(kVar2.f);
                    sVar5.d(kVar2.j);
                    sVar5.a = kVar2;
                    int size2 = size + 5;
                    if (size2 > this.j.size()) {
                        size2 = this.j.size();
                    }
                    size += new Random(System.nanoTime()).nextInt(size2 - size);
                    this.j.add(size, sVar5);
                }
            }
            if (chat.ola.vn.util.a.a) {
                int iNextInt = new Random(System.nanoTime()).nextInt(5);
                s sVar6 = new s((byte) 4);
                int size3 = size + iNextInt;
                if (size3 > this.j.size()) {
                    size3 = this.j.size();
                }
                this.j.add(size3, sVar6);
            }
        } catch (Throwable unused) {
        }
    }

    public void b(List<chat.ola.vn.message.f> list) {
        this.m.clear();
        this.m.addAll(list);
    }

    public chat.ola.vn.message.f c(int i) {
        try {
            return this.k.get(i);
        } catch (Throwable unused) {
            return null;
        }
    }

    public boolean c() {
        try {
            return this.o.b();
        } catch (Throwable unused) {
            return false;
        }
    }

    public void d() {
        this.o = null;
        a(0);
    }

    public int e() {
        return this.h;
    }

    public int f() {
        try {
            return this.j.size();
        } catch (Throwable unused) {
            return 0;
        }
    }

    public int g() {
        try {
            return this.k.size();
        } catch (Throwable unused) {
            return 0;
        }
    }

    public List<chat.ola.vn.message.f> h() {
        return this.k;
    }

    public List<chat.ola.vn.message.f> i() {
        return new ArrayList(this.m);
    }

    public String j() {
        return this.o != null ? this.o.d() : "";
    }

    public long k() {
        try {
            return this.o.c();
        } catch (Throwable unused) {
            return Long.MIN_VALUE;
        }
    }

    public Iterator<MarkerOptions> l() {
        try {
            return this.q.iterator();
        } catch (Throwable unused) {
            return null;
        }
    }

    public int m() {
        try {
            return this.q.size();
        } catch (Throwable unused) {
            return 0;
        }
    }

    public void n() {
        if (this.q != null) {
            this.q.clear();
        }
        if (this.r != null) {
            this.r.clear();
        }
        this.f = null;
    }

    public void o() {
        try {
            n();
            this.l.clear();
            this.m.clear();
            this.n.clear();
            this.o = null;
            this.h = 0;
        } catch (Throwable unused) {
        }
    }

    public s p() {
        return this.o;
    }

    public short q() {
        return this.g;
    }

    public boolean r() {
        return (this.g & e) != e;
    }
}
