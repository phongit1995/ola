package chat.ola.vn.w;

import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
class cj implements bb {
    cj() {
    }

    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        if (!chat.ola.vn.util.m.a(bkVar.u)) {
            cgVar.a((short) 30, bkVar.u);
        }
        if (!chat.ola.vn.util.m.a(bkVar.D)) {
            cgVar.a((short) 113, bkVar.D);
        }
        if (bkVar.aj != 0) {
            cgVar.a((short) 255, (byte) bkVar.aj);
        }
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        ArrayList arrayList;
        short sA = sVar.a(sVar.b((short) 255, 0), (short) 0);
        byte bA = sVar.a(sVar.b((short) 31, 0), (byte) 0);
        int iC = sVar.c((short) 29);
        chat.ola.vn.entity.ad adVar = new chat.ola.vn.entity.ad();
        adVar.i(sVar.b((short) 110));
        adVar.h(sVar.b((short) 111));
        adVar.f(sVar.b((short) 109));
        adVar.e(sVar.b((short) 207));
        String strB = sVar.b((short) 113);
        if (iC > 0) {
            arrayList = new ArrayList(iC);
            int iB = sVar.b((short) 29, 0);
            short s = 30;
            int iB2 = sVar.b((short) 30, 0);
            int iA = iB;
            int i = 0;
            while (i < iC) {
                int iA2 = sVar.a(s, iB2);
                chat.ola.vn.entity.ad adVar2 = new chat.ola.vn.entity.ad();
                String strC = sVar.c(iA);
                adVar2.f(strC);
                adVar2.e(sVar.c(iB2));
                adVar2.d(sVar.b((short) 24, iB2, iA2));
                adVar2.c(sVar.b((short) 8, iB2, iA2));
                adVar2.b(sVar.a((short) 124, iB2, iA2, 0));
                adVar2.c(sVar.a((short) 125, iB2, iA2, 0));
                iA = sVar.a((short) 29, iA);
                if (!chat.ola.vn.util.m.a(strC) && !chat.ola.vn.util.m.b(strC, "null")) {
                    arrayList.add(adVar2);
                }
                i++;
                iB2 = iA2;
                s = 30;
            }
        } else {
            arrayList = null;
        }
        adVar.a(bA);
        switch (bA) {
            case 0:
                gVar.a(adVar, arrayList, strB, sA);
                break;
            case 1:
                gVar.b(adVar, arrayList, strB, sA);
                break;
            default:
                gVar.c(adVar, arrayList, strB, sA);
                break;
        }
    }
}
