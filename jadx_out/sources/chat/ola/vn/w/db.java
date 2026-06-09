package chat.ola.vn.w;

import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
public class db implements bb {
    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        if (bkVar.aj != 0) {
            cgVar.a((short) 255, (byte) bkVar.aj);
        }
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        short sA = sVar.a(sVar.b((short) 255, 0), (short) 0);
        String strB = sVar.b((short) 8);
        if (strB != null) {
            String[] strArrE = chat.ola.vn.util.m.e(strB, ";");
            String strB2 = sVar.b((short) 110);
            ArrayList arrayList = null;
            String[] strArrSplit = strB2 != null ? strB2.split(";") : null;
            if (strArrE != null) {
                arrayList = new ArrayList(strArrE.length);
                for (int i = 0; i < strArrE.length; i++) {
                    String[] strArrE2 = chat.ola.vn.util.m.e(strArrE[i], ":");
                    chat.ola.vn.entity.ac acVar = new chat.ola.vn.entity.ac();
                    acVar.d = Integer.parseInt(strArrE2[0]);
                    acVar.c = Long.parseLong(strArrE2[1]);
                    if (strArrSplit != null && strArrSplit[i] != null) {
                        acVar.b = strArrSplit[i];
                    }
                    arrayList.add(acVar);
                }
            }
            String[] strArrSplit2 = sVar.b((short) 109).split(";");
            ArrayList arrayList2 = new ArrayList(strArrSplit2.length);
            for (String str : strArrSplit2) {
                arrayList2.add(new chat.ola.vn.entity.ah((short) Integer.parseInt(str)));
            }
            gVar.a(arrayList, arrayList2, sA);
        }
    }
}
