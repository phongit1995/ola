package chat.ola.vn.w;

import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
class dn implements bb {
    dn() {
    }

    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        cgVar.a((short) 100, bkVar.R);
        if (bkVar.ai > 0) {
            cgVar.a((short) 220, (byte) bkVar.ai);
        }
        cgVar.a((short) 8, bkVar.m);
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        long jA = sVar.a(sVar.b((short) 100, 0), 0L);
        int iC = sVar.c((short) 7);
        if (iC > 0) {
            ArrayList arrayList = new ArrayList(iC);
            int iB = sVar.b((short) 7, 0);
            int i = 0;
            while (i < iC) {
                int iA = sVar.a((short) 7, iB);
                String strC = sVar.c(iB);
                String strB = sVar.b((short) 8, iB, iA);
                short sA = sVar.a((short) 220, iB, iA, (short) 0);
                short sA2 = sVar.a((short) 45, iB, iA, (short) 0);
                chat.ola.vn.message.d dVar = new chat.ola.vn.message.d();
                dVar.d(strC);
                dVar.f(strB);
                dVar.b(sA);
                dVar.a(sA2);
                dVar.a(System.currentTimeMillis());
                dVar.a((byte) 2);
                arrayList.add(chat.ola.vn.message.e.a(dVar, (byte) 1));
                i++;
                iB = iA;
            }
            gVar.a(jA, arrayList);
        }
    }
}
