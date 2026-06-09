package chat.ola.vn.w;

import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
public class ar implements bb {
    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        if (!chat.ola.vn.util.m.a(bkVar.z)) {
            cgVar.a((short) 109, bkVar.z);
        }
        if (bkVar.E != null) {
            for (String str : bkVar.E) {
                if (!chat.ola.vn.util.m.a(str)) {
                    cgVar.a((short) 110, str);
                }
            }
        }
        if (bkVar.aj != 0) {
            cgVar.a((short) 255, (byte) bkVar.aj);
        }
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        ArrayList arrayList;
        int i = 0;
        short sA = sVar.a(sVar.b((short) 255, 0), (short) 0);
        String strB = sVar.b((short) 109);
        int iC = sVar.c((short) 110);
        if (iC > 0) {
            arrayList = new ArrayList(iC);
            int iB = sVar.b((short) 110, 0);
            while (i < iC) {
                int iA = sVar.a((short) 110, iB);
                String strC = sVar.c(iB);
                byte[] bArrB = sVar.b(sVar.a((short) 23, iB, iA));
                chat.ola.vn.entity.aa aaVar = new chat.ola.vn.entity.aa();
                aaVar.a = strC;
                aaVar.b = bArrB;
                arrayList.add(aaVar);
                i++;
                iB = iA;
            }
        } else {
            arrayList = null;
        }
        gVar.b(strB, arrayList, sA);
    }
}
