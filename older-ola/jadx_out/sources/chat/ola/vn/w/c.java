package chat.ola.vn.w;

import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
class c implements bb {
    c() {
    }

    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        cgVar.a((short) 21, bkVar.o);
        if (bkVar.E != null) {
            for (int i = 0; i < bkVar.E.length; i++) {
                cgVar.a((short) 7, bkVar.E[i]);
                if (bkVar.F != null && !chat.ola.vn.util.m.a(bkVar.F[i])) {
                    cgVar.a((short) 22, bkVar.F[i]);
                }
            }
        }
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        ArrayList arrayList;
        String strB = sVar.b((short) 21);
        int iC = sVar.c((short) 7);
        if (iC > 0) {
            arrayList = new ArrayList(iC);
            int iB = sVar.b((short) 7, 0);
            int i = 0;
            while (i < iC) {
                int iA = sVar.a((short) 7, iB);
                String strC = sVar.c(iB);
                String strB2 = sVar.b((short) 22, iB, iA);
                short sA = sVar.a((short) 45, iB, iA, (byte) 0);
                short sA2 = sVar.a((short) 38, iB, iA, (short) -1);
                String strB3 = sVar.b((short) 86, iB, iA);
                short sA3 = sVar.a((short) 12, iB, iA, (short) 0);
                String strB4 = sVar.b((short) 13, iB, iA);
                chat.ola.vn.message.f fVar = new chat.ola.vn.message.f(strC, (short) 0);
                fVar.c(strB2);
                fVar.e(sA);
                fVar.b(sA3);
                fVar.e(strB4);
                fVar.c(sA2);
                fVar.f(strB3);
                fVar.b((byte) 1);
                arrayList.add(fVar);
                i++;
                iB = iA;
            }
        } else {
            arrayList = null;
        }
        gVar.a(strB, arrayList);
    }
}
