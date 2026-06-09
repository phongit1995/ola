package chat.ola.vn.w;

import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
class ag implements bb {
    ag() {
    }

    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        if (bkVar.aa != 0) {
            cgVar.a((short) 39, bkVar.aa);
        }
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        ArrayList arrayList;
        int i = 0;
        int iA = sVar.a(sVar.b((short) 39, 0), 0);
        int iC = sVar.c((short) 129);
        if (iC > 0) {
            arrayList = new ArrayList(iC);
            int iB = sVar.b((short) 129, 0);
            while (i < iC) {
                int iA2 = sVar.a((short) 129, iB);
                String strC = sVar.c(iB);
                String strB = sVar.b((short) 22, iB, iA2);
                String strB2 = sVar.b((short) 13, iB, iA2);
                String strB3 = sVar.b((short) 24, iB, iA2);
                chat.ola.vn.message.f fVar = new chat.ola.vn.message.f(strC, (short) 2);
                fVar.c(strB);
                fVar.e(strB2);
                fVar.b((short) 2);
                fVar.g(strB3);
                fVar.b((byte) 1);
                arrayList.add(fVar);
                i++;
                iB = iA2;
            }
        } else {
            arrayList = null;
        }
        gVar.a(iA, (List<chat.ola.vn.message.f>) arrayList);
    }
}
