package chat.ola.vn.u;

import chat.ola.vn.w.cg;
import chat.ola.vn.w.s;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
class f implements a {
    f() {
    }

    @Override // chat.ola.vn.u.a
    public cg a(e eVar, List<g> list) {
        return null;
    }

    @Override // chat.ola.vn.u.a
    public void a(s sVar, List<g> list) {
        byte bA = sVar.a(sVar.b((short) 0, 0), (byte) 0);
        String strB = sVar.b((short) 14);
        String strB2 = sVar.b((short) 4);
        String strB3 = sVar.b((short) 5);
        switch (bA) {
            case 1:
                for (g gVar : list) {
                    if (chat.ola.vn.util.m.b(strB2, gVar.b()) || chat.ola.vn.util.m.b(strB3, gVar.c())) {
                        gVar.d(strB2, strB);
                        break;
                    }
                }
                break;
            case 2:
                int iA = sVar.a(sVar.b((short) 1, 0), 0);
                for (g gVar2 : list) {
                    if (chat.ola.vn.util.m.b(strB2, gVar2.b()) || chat.ola.vn.util.m.b(strB3, gVar2.c())) {
                        gVar2.a(strB2, iA, strB);
                        break;
                    }
                }
                break;
            case 3:
                for (g gVar3 : list) {
                    if (chat.ola.vn.util.m.b(strB2, gVar3.b()) || chat.ola.vn.util.m.b(strB3, gVar3.c())) {
                        gVar3.e(strB2, strB);
                        break;
                    }
                }
                break;
            default:
                for (g gVar4 : list) {
                    if (chat.ola.vn.util.m.b(strB2, gVar4.b()) || chat.ola.vn.util.m.b(strB3, gVar4.c())) {
                        gVar4.c(strB3, strB);
                        break;
                    }
                }
                break;
        }
    }
}
