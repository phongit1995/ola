package chat.ola.vn.w;

import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
public class ad implements bb {
    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        if (bkVar.aj != 0) {
            cgVar.a((short) 255, (byte) bkVar.aj);
        }
        if (!chat.ola.vn.util.m.a(bkVar.p)) {
            cgVar.a((short) 2, bkVar.p);
        }
        if (chat.ola.vn.util.m.a(bkVar.l)) {
            return;
        }
        cgVar.a((short) 6, bkVar.l);
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        ArrayList arrayList;
        short s = 0;
        short sA = sVar.a(sVar.b((short) 255, 0), (short) 0);
        short s2 = 109;
        int iC = sVar.c((short) 109);
        String strB = sVar.b((short) 6);
        if (iC > 0) {
            arrayList = new ArrayList(iC);
            int iB = sVar.b((short) 109, 0);
            int iB2 = sVar.b((short) 207, 0);
            int i = 0;
            while (i < iC) {
                String strC = sVar.c(iB);
                int iA = sVar.a(s2, iB);
                String strC2 = sVar.c(iB2);
                short sA2 = sVar.a((short) 69, iB, iA, s);
                short sA3 = sVar.a((short) 62, iB, iA, s);
                int i2 = iB2;
                int i3 = i;
                int i4 = iB;
                long jA = sVar.a((short) 9, iB, iA, 0L);
                int iA2 = sVar.a((short) 205, i4, iA, 0);
                if (iA2 < 0) {
                    iA2 = 0;
                }
                int iA3 = sVar.a((short) 206, i4, iA, 0);
                chat.ola.vn.entity.l lVar = new chat.ola.vn.entity.l();
                lVar.b = strC;
                lVar.a = strC2;
                lVar.i = sA2;
                lVar.j = sA3;
                lVar.f = jA;
                lVar.g = iA2;
                lVar.h = iA3;
                lVar.c = sVar.b((short) 24, i4, iA);
                int iA4 = sVar.a((short) 207, i2);
                arrayList.add(lVar);
                i = i3 + 1;
                iB = iA;
                iC = iC;
                s = 0;
                s2 = 109;
                iB2 = iA4;
            }
        } else {
            arrayList = null;
        }
        String strB2 = sVar.b((short) 2);
        if (chat.ola.vn.util.m.a(strB2)) {
            strB2 = ciVar.f;
        }
        if (chat.ola.vn.util.m.b(strB2, ciVar.f)) {
            gVar.a(arrayList, strB, sA);
        } else {
            gVar.a(strB2, arrayList, strB, sA);
        }
    }
}
