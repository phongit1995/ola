package chat.ola.vn.w;

import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
class bc implements bb {
    bc() {
    }

    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        if (bkVar.aj != 0) {
            cgVar.a((short) 255, (byte) bkVar.aj);
        }
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        short sA = sVar.a(sVar.b((short) 255, 0), (short) 0);
        int iC = sVar.c((short) 7);
        if (iC > 0) {
            ArrayList arrayList = new ArrayList();
            int iA = sVar.a((short) 7, -1);
            int iA2 = sVar.a((short) 58, -1);
            for (int i = 0; i < iC; i++) {
                String strC = sVar.c(iA);
                long jA = sVar.a(iA2, 0L);
                iA = sVar.a((short) 7, iA);
                iA2 = sVar.a((short) 58, iA2);
                chat.ola.vn.message.f fVar = new chat.ola.vn.message.f(strC, (short) 0);
                fVar.a(jA);
                arrayList.add(fVar);
            }
            gVar.b(arrayList, sA);
        }
    }
}
