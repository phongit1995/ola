package chat.ola.vn.w;

import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
public class dc implements bb {
    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        if (bkVar.aj != 0) {
            cgVar.a((short) 255, (byte) bkVar.aj);
        }
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        ArrayList arrayList;
        short sA = sVar.a(sVar.b((short) 255, 0), (short) 0);
        String strB = sVar.b((short) 5);
        String strB2 = sVar.b((short) 92);
        String strB3 = sVar.b((short) 8);
        String[] strArrE = chat.ola.vn.util.m.e(strB2, ";");
        if (strArrE == null || strArrE.length <= 0 || strArrE.length % 2 != 0) {
            arrayList = null;
        } else {
            arrayList = new ArrayList(strArrE.length / 2);
            for (int i = 0; i < strArrE.length; i += 2) {
                chat.ola.vn.entity.a aVar = new chat.ola.vn.entity.a();
                aVar.a = strArrE[i];
                aVar.b = strArrE[i + 1];
                arrayList.add(aVar);
            }
        }
        gVar.b(strB3, strB, arrayList, sA);
    }
}
