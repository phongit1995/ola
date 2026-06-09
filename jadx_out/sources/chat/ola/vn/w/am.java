package chat.ola.vn.w;

import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
public class am implements bb {
    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        if (bkVar.aj != 0) {
            cgVar.a((short) 255, (byte) bkVar.aj);
        }
        if (bkVar.as > 0) {
            cgVar.a((short) 114, bkVar.as);
        }
        if (!chat.ola.vn.util.m.a(bkVar.p)) {
            cgVar.a((short) 2, bkVar.p);
        }
        if (!chat.ola.vn.util.m.a(bkVar.z)) {
            cgVar.a((short) 109, bkVar.z);
        }
        if (chat.ola.vn.util.m.a(bkVar.l)) {
            return;
        }
        cgVar.a((short) 6, bkVar.l);
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        ArrayList arrayList;
        int i = 0;
        short sA = sVar.a(sVar.b((short) 255, 0), (short) 0);
        String strB = sVar.b((short) 2);
        String strB2 = sVar.b((short) 109);
        short s = 24;
        int iC = sVar.c((short) 24);
        String strB3 = sVar.b((short) 6);
        if (iC > 0) {
            ArrayList arrayList2 = new ArrayList(iC);
            int iB = sVar.b((short) 24, 0);
            int i2 = 0;
            while (i2 < iC) {
                int iA = sVar.a(s, iB);
                String strC = sVar.c(iB);
                String strB4 = sVar.b((short) 22, iB, iA);
                int iA2 = sVar.a((short) 206, iB, iA, i);
                long jA = sVar.a((short) 9, iB, iA, 0L);
                chat.ola.vn.entity.i iVar = new chat.ola.vn.entity.i();
                iVar.a(strC);
                iVar.c(strB4);
                iVar.b(iA2);
                iVar.a(jA);
                arrayList2.add(iVar);
                i2++;
                iB = iA;
                i = 0;
                s = 24;
            }
            arrayList = arrayList2;
        } else {
            arrayList = null;
        }
        String str = chat.ola.vn.util.m.a(strB) ? ciVar.f : strB;
        if (chat.ola.vn.util.m.b(str, ciVar.f)) {
            gVar.b(strB2, arrayList, strB3, sA);
        } else {
            gVar.a(str, strB2, arrayList, strB3, sA);
        }
    }
}
