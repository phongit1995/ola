package chat.ola.vn.w;

import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
class i implements bb {
    i() {
    }

    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        for (int i = 0; i < bkVar.E.length; i++) {
            cgVar.a((short) 7, bkVar.E[i]);
            if (bkVar.F != null && bkVar.F[i] != null) {
                cgVar.a((short) 22, bkVar.F[i]);
            }
        }
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        int iC = sVar.c((short) 7);
        if (iC > 0) {
            ArrayList arrayList = new ArrayList(iC);
            int iB = sVar.b((short) 7, 0);
            int i = 0;
            while (i < iC) {
                int iA = sVar.a((short) 7, iB);
                String strC = sVar.c(iB);
                String strB = sVar.b((short) 22, iB, iA);
                chat.ola.vn.message.f fVar = new chat.ola.vn.message.f(strC, (short) 0);
                fVar.b(strB);
                arrayList.add(fVar);
                i++;
                iB = iA;
            }
            gVar.b(arrayList);
        }
    }
}
