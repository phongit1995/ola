package chat.ola.vn.w;

import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
public class ay implements bb {
    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        if (bkVar.p != null) {
            cgVar.a((short) 7, bkVar.p);
        }
        if (bkVar.aj != 0) {
            cgVar.a((short) 255, (byte) bkVar.aj);
        }
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        int i;
        short sA = sVar.a(sVar.b((short) 255, 0), (short) 0);
        String strB = sVar.b((short) 7);
        short sA2 = sVar.a(sVar.b((short) 114, 0), (short) 0);
        String strB2 = sVar.b((short) 111);
        long jA = sVar.a(sVar.b((short) 130, 0), 0L);
        if (jA >= 0) {
            int i2 = (int) (jA / 3600000);
            if (jA % 3600000 != 0) {
                i2++;
            }
            int i3 = i2 / 24;
            if (i2 % 24 != 0) {
                i3++;
            }
            i = i3;
        } else {
            i = -1;
        }
        long jA2 = sVar.a(sVar.b((short) 9, 0), 0L);
        String strB3 = sVar.b((short) 109);
        String strB4 = sVar.b((short) 110);
        String strB5 = sVar.b((short) 112);
        String[] strArrE = chat.ola.vn.util.m.e(strB3, ";");
        String[] strArrE2 = chat.ola.vn.util.m.e(strB4, ";");
        ArrayList arrayList = null;
        String[] strArrE3 = strB5 != null ? chat.ola.vn.util.m.e(strB5, ";") : null;
        if (strArrE != null && strArrE.length > 0) {
            arrayList = new ArrayList(strArrE.length);
            for (int i4 = 0; i4 < strArrE.length; i4++) {
                chat.ola.vn.entity.ah ahVar = new chat.ola.vn.entity.ah(Short.parseShort(strArrE[i4]));
                ahVar.b(strArrE2[i4]);
                if (strArrE3 == null || strArrE3[i4] == null) {
                    ahVar.a(false);
                } else {
                    ahVar.a(strArrE3[i4].equals("1"));
                }
                arrayList.add(ahVar);
            }
        }
        gVar.a(strB, i, sA2, strB2, jA2, arrayList, sA);
    }
}
