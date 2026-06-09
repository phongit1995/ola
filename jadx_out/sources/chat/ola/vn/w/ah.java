package chat.ola.vn.w;

import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
class ah implements bb {
    ah() {
    }

    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        if (bkVar.aj != 0) {
            cgVar.a((short) 255, (byte) bkVar.aj);
        }
        cgVar.a((short) 129, bkVar.w);
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        ArrayList arrayList;
        short sA = sVar.a(sVar.b((short) 255, 0), (short) 0);
        String strB = sVar.b((short) 129);
        int iC = sVar.c((short) 7);
        if (iC > 0) {
            arrayList = new ArrayList(iC);
            int iB = sVar.b((short) 7, 0);
            int i = 0;
            while (i < iC) {
                int iA = sVar.a((short) 7, iB);
                String strC = sVar.c(iB);
                String strB2 = sVar.b((short) 22, iB, iA);
                short sA2 = sVar.a((short) 45, iB, iA, (short) 0);
                chat.ola.vn.message.f fVarD = chat.ola.vn.h.t.d(strC);
                if (fVarD == null) {
                    fVarD = new chat.ola.vn.message.f(strC, (short) 0);
                    fVarD.b(strB2);
                    fVarD.d(sA2);
                }
                arrayList.add(fVarD);
                i++;
                iB = iA;
            }
        } else {
            arrayList = null;
        }
        gVar.a(strB, arrayList, sA);
    }
}
