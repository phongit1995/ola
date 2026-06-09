package chat.ola.vn.u;

import chat.ola.vn.w.cg;
import chat.ola.vn.w.s;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
class l implements a {
    l() {
    }

    @Override // chat.ola.vn.u.a
    public cg a(e eVar, List<g> list) {
        cg cgVar = new cg(eVar.j);
        if (!chat.ola.vn.util.m.a(eVar.e)) {
            cgVar.a((short) 10, eVar.e);
        }
        cgVar.a((short) 5, eVar.c);
        cgVar.a((short) 7, eVar.i);
        if (eVar.l != null) {
            cgVar.a((short) 6, eVar.l);
        }
        return cgVar;
    }

    @Override // chat.ola.vn.u.a
    public void a(s sVar, List<g> list) {
        String strB = sVar.b((short) 5);
        String strB2 = sVar.b((short) 13);
        if (strB2 == null) {
            for (g gVar : list) {
                if (chat.ola.vn.util.m.b(strB, gVar.c())) {
                    gVar.a(strB);
                    return;
                }
            }
            return;
        }
        for (g gVar2 : list) {
            if (chat.ola.vn.util.m.b(strB, gVar2.c())) {
                gVar2.a(strB, strB2);
                return;
            }
        }
    }
}
