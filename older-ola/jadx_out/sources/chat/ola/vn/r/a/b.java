package chat.ola.vn.r.a;

import chat.ola.vn.entry.g;
import chat.ola.vn.p.h;
import chat.ola.vn.util.m;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
public class b implements chat.ola.vn.r.a {
    private h b;
    a a = new a();
    private List<g> c = new ArrayList();
    private Map<String, g> d = new HashMap();

    private void d() {
        Collections.sort(this.c, this.a);
    }

    @Override // chat.ola.vn.r.a
    public g a(int i) {
        return this.c.get(i);
    }

    @Override // chat.ola.vn.r.a
    public g a(String str) {
        try {
            return this.d.get(str);
        } catch (Throwable unused) {
            return null;
        }
    }

    @Override // chat.ola.vn.r.a
    public List<g> a() {
        return this.c;
    }

    @Override // chat.ola.vn.r.a
    public void a(g gVar) {
        if (gVar == null || m.a(gVar.a())) {
            return;
        }
        g gVar2 = this.d.get(gVar.a());
        if (gVar2 != null) {
            gVar2.a(gVar.c());
        } else {
            this.c.add(gVar);
            this.d.put(gVar.a(), gVar);
        }
        d();
        if (this.b != null) {
            this.b.a(this, gVar);
        }
    }

    @Override // chat.ola.vn.r.a
    public void a(List<g> list) {
        try {
            this.c.clear();
            this.d.clear();
            if (list != null && list.size() > 0) {
                for (g gVar : list) {
                    String strA = gVar.a();
                    if (gVar != null && !m.a(strA) && this.d.get(strA) == null) {
                        this.c.add(gVar);
                        this.d.put(strA, gVar);
                    }
                }
                d();
            }
            if (this.b != null) {
                this.b.a(this, list);
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.r.a
    public int b() {
        return this.c.size();
    }

    @Override // chat.ola.vn.r.a
    public void c() {
        this.c.clear();
        this.d.clear();
        chat.ola.vn.h.u.t();
        if (this.b != null) {
            this.b.a(this);
        }
    }
}
