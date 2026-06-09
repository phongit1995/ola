package chat.ola.vn.w;

import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
class ac implements bb {
    String e;

    ac() {
    }

    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        cgVar.a((short) 114, bkVar.as);
        this.e = bkVar.z;
        if (!chat.ola.vn.util.m.a(bkVar.z)) {
            cgVar.a((short) 109, bkVar.z);
        }
        try {
            if (bkVar.G != null && bkVar.F != null) {
                for (int i = 0; i < bkVar.G.length; i++) {
                    cgVar.a((short) 4, bkVar.G[i]);
                    cgVar.a((short) 22, bkVar.F[i]);
                }
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
        if (bkVar.aj != 0) {
            cgVar.a((short) 255, (byte) bkVar.aj);
        }
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        int i = 0;
        byte bA = sVar.a(sVar.b((short) 114, 0), (byte) 0);
        short sA = sVar.a(sVar.b((short) 255, 0), (short) 0);
        switch (bA) {
            case 0:
                int iC = sVar.c((short) 7);
                ArrayList arrayList = null;
                if (iC > 0) {
                    arrayList = new ArrayList(iC);
                    int iB = sVar.b((short) 7, 0);
                    int iB2 = sVar.b((short) 4, 0);
                    int i2 = iB;
                    int i3 = 0;
                    while (i3 < iC) {
                        int iA = sVar.a((short) 7, i2);
                        String strC = sVar.c(i2);
                        chat.ola.vn.message.f fVar = new chat.ola.vn.message.f(strC, (short) 0);
                        fVar.h(sVar.c(iB2));
                        String strB = sVar.b((short) 22, i2, iA);
                        if (!chat.ola.vn.util.m.a(strB)) {
                            strC = strB;
                        }
                        fVar.c(strC);
                        arrayList.add(fVar);
                        iB2 = sVar.a((short) 4, iB2);
                        i3++;
                        i2 = iA;
                    }
                }
                gVar.c(arrayList, sA);
                return;
            case 1:
                int iC2 = sVar.c((short) 7);
                if (iC2 > 0) {
                    String[] strArr = new String[iC2];
                    String[] strArr2 = new String[iC2];
                    String strB2 = sVar.b((short) 109);
                    int iB3 = sVar.b((short) 7, 0);
                    while (i < iC2) {
                        strArr2[i] = sVar.c(iB3);
                        int iA2 = sVar.a((short) 7, iB3);
                        strArr[i] = sVar.b((short) 22, iB3, iA2);
                        if (chat.ola.vn.util.m.a(strArr[i])) {
                            strArr[i] = strArr2[i];
                        }
                        i++;
                        iB3 = iA2;
                    }
                    gVar.a(strArr2, strArr, this.e, strB2, sA);
                    return;
                }
                break;
        }
    }
}
