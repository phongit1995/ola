package chat.ola.vn.u;

import chat.ola.vn.w.cg;
import chat.ola.vn.w.s;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
class i implements a {
    i() {
    }

    @Override // chat.ola.vn.u.a
    public cg a(e eVar, List<g> list) {
        cg cgVar = new cg(eVar.j);
        if (!chat.ola.vn.util.m.a(eVar.e)) {
            cgVar.a((short) 10, eVar.e);
        }
        cgVar.a((short) 1, eVar.g);
        cgVar.a((short) 2, eVar.h);
        if (!chat.ola.vn.util.m.a(eVar.a)) {
            cgVar.a((short) 3, eVar.a);
        }
        if (!chat.ola.vn.util.m.a(eVar.b)) {
            cgVar.a((short) 4, eVar.b);
        }
        if (!chat.ola.vn.util.m.a(eVar.d)) {
            cgVar.a((short) 9, eVar.d);
        }
        cgVar.a((short) 15, eVar.k);
        if (!chat.ola.vn.util.m.a(eVar.f)) {
            cgVar.a((short) 16, eVar.f);
        }
        return cgVar;
    }

    @Override // chat.ola.vn.u.a
    public void a(s sVar, List<g> list) {
        String strB = sVar.b((short) 4);
        String strB2 = sVar.b((short) 5);
        for (g gVar : list) {
            if (chat.ola.vn.util.m.b(strB, gVar.b())) {
                gVar.b(strB, strB2);
                return;
            }
        }
    }
}
