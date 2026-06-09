package chat.ola.vn.r.a;

import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.entity.k;
import chat.ola.vn.h;
import chat.ola.vn.util.m;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Random;

/* JADX INFO: loaded from: classes.dex */
public class c {
    private List<chat.ola.vn.entry.e> d;
    private chat.ola.vn.o.e e;
    private List<chat.ola.vn.entry.e> f;
    private List<k> a = null;
    private String g = null;
    private long h = 0;
    private List<chat.ola.vn.entry.e> c = new ArrayList();
    private Map<String, chat.ola.vn.entry.e> b = new HashMap();

    public c() {
        n();
    }

    private void n() {
        this.c.clear();
        this.b.clear();
        this.c.add(chat.ola.vn.entry.e.a(R.string.general_tab_notify, R.drawable.ic_tab_notify, R.string.general_tab_notify));
        this.e = new chat.ola.vn.o.e();
        this.c.add(this.e);
        this.c.add(chat.ola.vn.entry.e.a(R.string.general_tab_personal, R.drawable.ic_tab_persional, R.string.general_tab_personal));
        this.c.add(chat.ola.vn.entry.e.a(R.string.general_tab_vipstore, R.drawable.ic_tab_vip_store, R.string.general_tab_vipstore));
        this.c.add(chat.ola.vn.entry.e.a(R.string.general_tab_kenstore, R.drawable.ic_tab_ken_store, R.string.general_tab_kenstore));
        this.c.add(new chat.ola.vn.o.a());
        this.c.add(chat.ola.vn.entry.e.a(R.string.general_tab_mediastore, R.drawable.ic_tab_media_store, R.string.general_tab_mediastore));
        chat.ola.vn.entry.e eVarA = chat.ola.vn.entry.e.a(R.string.general_tab_ola_mall, R.drawable.ola_mall_icon, R.string.general_tab_ola_mall);
        eVarA.d(OlaApplication.a(R.string.message_mall_introduction));
        this.c.add(eVarA);
        this.c.add(chat.ola.vn.entry.e.a(R.string.general_tab_nearby_places, R.drawable.ic_check_in, R.string.general_tab_nearby_places));
        this.c.add(new chat.ola.vn.o.f());
        a();
    }

    private void o() {
        if (this.d == null) {
            this.d = new ArrayList(this.c.size() + 3);
        }
        this.d.clear();
        ArrayList arrayList = new ArrayList(this.c.size());
        ArrayList arrayList2 = new ArrayList(this.c.size());
        int size = this.c.size();
        for (int i = 0; i < size; i++) {
            chat.ola.vn.entry.e eVar = this.c.get(i);
            if (eVar.c()) {
                arrayList.add(eVar);
            } else {
                arrayList2.add(eVar);
            }
        }
        if (arrayList.size() > 0) {
            chat.ola.vn.entry.e eVar2 = new chat.ola.vn.entry.e();
            eVar2.a((byte) 1);
            eVar2.a(OlaApplication.a(R.string.string_notified_applications));
            this.d.add(eVar2);
            this.d.addAll(arrayList);
            chat.ola.vn.entry.e eVar3 = new chat.ola.vn.entry.e();
            eVar3.a((byte) 1);
            eVar3.a(OlaApplication.a(R.string.general_tab_app));
            this.d.add(eVar3);
        }
        this.d.addAll(arrayList2);
    }

    public chat.ola.vn.entry.e a(int i) {
        try {
            return this.d.get(i);
        } catch (Throwable unused) {
            return null;
        }
    }

    public chat.ola.vn.entry.e a(String str) {
        try {
            for (chat.ola.vn.entry.e eVar : this.c) {
                if (m.b(eVar.g().split("/")[0], str)) {
                    return eVar;
                }
            }
            return null;
        } catch (Throwable unused) {
            return null;
        }
    }

    public void a() {
        String[] strArrSplit;
        try {
            try {
                for (chat.ola.vn.entry.e eVar : this.c) {
                    if (!m.a(eVar.k())) {
                        this.b.put(eVar.k(), eVar);
                    }
                }
                String strK = chat.ola.vn.e.a().k();
                if (!m.a(strK) && (strArrSplit = strK.split(";")) != null) {
                    for (int i = 0; i < strArrSplit.length; i++) {
                        if (!m.a(strArrSplit[i])) {
                            try {
                                String[] strArrSplit2 = strArrSplit[i].split(":");
                                if (strArrSplit2 != null) {
                                    String str = strArrSplit2[0];
                                    int i2 = Integer.parseInt(strArrSplit2[1]);
                                    chat.ola.vn.entry.e eVar2 = this.b.get(str);
                                    if (eVar2 != null) {
                                        if (eVar2.l() <= i2) {
                                            eVar2.c(i2);
                                            eVar2.a(true);
                                            eVar2.b(true);
                                        } else {
                                            eVar2.b(false);
                                        }
                                    }
                                }
                            } catch (Throwable unused) {
                            }
                        }
                    }
                }
            } catch (Throwable unused2) {
            }
        } finally {
            o();
        }
    }

    public void a(chat.ola.vn.entry.e eVar) {
        if (this.c.contains(eVar)) {
            return;
        }
        this.c.add(eVar);
        o();
    }

    public void a(chat.ola.vn.entry.e eVar, int i) {
        if (i < 0 || i > this.c.size() || this.c.contains(eVar)) {
            return;
        }
        this.c.add(i, eVar);
        o();
    }

    public void a(String str, List<chat.ola.vn.entry.e> list) {
        if (list == null || list.isEmpty()) {
            return;
        }
        if (this.f != null) {
            this.c.removeAll(this.f);
        }
        for (chat.ola.vn.entry.e eVar : list) {
            if (!this.c.contains(eVar)) {
                try {
                    int iE = eVar.e();
                    if (iE < 0 || iE > this.c.size()) {
                        this.c.add(eVar);
                    } else {
                        this.c.add(iE, eVar);
                    }
                } catch (Throwable unused) {
                    this.c.add(eVar);
                }
            }
        }
        this.f = list;
        this.g = str;
        o();
    }

    public void a(List<k> list) {
        this.a = list;
        h.t.g();
    }

    public chat.ola.vn.entry.e b(int i) {
        for (chat.ola.vn.entry.e eVar : this.c) {
            if (eVar.d() == i) {
                return eVar;
            }
        }
        return null;
    }

    public void b() {
        try {
            n();
            this.g = null;
            if (this.f != null) {
                this.f.clear();
            }
        } catch (Throwable unused) {
        }
    }

    public int c() {
        int i = 0;
        try {
            Iterator<chat.ola.vn.entry.e> it2 = this.c.iterator();
            while (it2.hasNext()) {
                if (it2.next().c()) {
                    i++;
                }
            }
        } catch (Throwable unused) {
        }
        return i;
    }

    public chat.ola.vn.entry.e d() {
        try {
            int size = this.c.size();
            for (int i = 0; i < size; i++) {
                chat.ola.vn.entry.e eVar = this.c.get(i);
                if (eVar.c() && eVar.d() == R.string.general_tab_notify) {
                    return eVar;
                }
            }
            return null;
        } catch (Throwable unused) {
            return null;
        }
    }

    public chat.ola.vn.entry.e e() {
        try {
            int size = this.c.size();
            for (int i = 0; i < size; i++) {
                chat.ola.vn.entry.e eVar = this.c.get(i);
                if (eVar.c()) {
                    return eVar;
                }
            }
            return null;
        } catch (Throwable unused) {
            return null;
        }
    }

    public String f() {
        try {
            int iC = c();
            if (iC <= 0) {
                return null;
            }
            if (iC > 1) {
                return "" + iC;
            }
            String strH = e().h();
            if (strH.length() <= 5) {
                return strH;
            }
            return "" + strH.charAt(0);
        } catch (Throwable unused) {
            return null;
        }
    }

    public void g() {
        o();
        if (chat.ola.vn.m.d.c() != null) {
            chat.ola.vn.m.d.c().d();
        }
    }

    public void h() {
        if (this.a != null) {
            while (this.a.size() > 0) {
                int iNextInt = new Random(System.nanoTime()).nextInt(this.a.size());
                k kVar = this.a.get(iNextInt);
                if (!chat.ola.vn.util.b.k(OlaApplication.a(), kVar.m)) {
                    this.e.a(kVar);
                    return;
                }
                this.a.remove(iNextInt);
            }
        }
        this.e.a((k) null);
        o();
    }

    public String i() {
        return this.g;
    }

    public int j() {
        try {
            return this.d.size();
        } catch (Throwable unused) {
            return 0;
        }
    }

    public void k() {
        String strJ = null;
        try {
            for (chat.ola.vn.entry.e eVar : this.c) {
                if (!m.a(eVar.k()) && eVar.a()) {
                    strJ = strJ == null ? eVar.j() : strJ + ";" + eVar.j();
                }
            }
            chat.ola.vn.e.a().c(strJ);
        } catch (Throwable unused) {
        }
    }

    public boolean l() {
        boolean z = System.currentTimeMillis() - this.h >= 3600000;
        this.h = System.currentTimeMillis();
        return z;
    }

    public List<k> m() {
        return null;
    }
}
