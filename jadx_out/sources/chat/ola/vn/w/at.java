package chat.ola.vn.w;

import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
class at implements bb {
    at() {
    }

    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        if (bkVar.aj != 0) {
            cgVar.a((short) 255, (byte) bkVar.aj);
        }
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        ArrayList arrayList;
        int iC = sVar.c((short) 100);
        short sA = sVar.a(sVar.b((short) 255, 0), (short) 0);
        if (iC > 0) {
            arrayList = new ArrayList(iC);
            int iB = sVar.b((short) 100, 0);
            int iB2 = sVar.b((short) 101, 0);
            int iA = iB;
            for (int i = 0; i < iC; i++) {
                int iA2 = sVar.a((short) 100, iA);
                chat.ola.vn.entity.s sVar2 = new chat.ola.vn.entity.s(sVar.a(iA, 0L), sVar.c(iB2));
                String strB = sVar.b((short) 109, iA, iA2);
                String strB2 = sVar.b((short) 104, iA, iA2);
                short sA2 = (short) sVar.a((short) 103, iA, iA2, 0);
                String strB3 = sVar.b((short) 30, iA, iA2);
                sVar2.b(strB);
                sVar2.c(strB2);
                sVar2.a(sA2);
                sVar2.d(strB3);
                arrayList.add(sVar2);
                iA = sVar.a((short) 100, iA);
                iB2 = sVar.a((short) 101, iB2);
            }
        } else {
            arrayList = null;
        }
        gVar.a((List<chat.ola.vn.entity.s>) arrayList, sA);
    }
}
