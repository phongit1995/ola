package chat.ola.vn.w;

import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
public class dd implements bb {
    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        if (bkVar.aj != 0) {
            cgVar.a((short) 255, (byte) bkVar.aj);
        }
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        short sA = sVar.a(sVar.b((short) 255, 0), (short) 0);
        String strB = sVar.b((short) 5);
        String strB2 = sVar.b((short) 29);
        String[] strArrE = chat.ola.vn.util.m.e(sVar.b((short) 8), ";");
        if (strArrE == null || strArrE.length <= 0 || strArrE.length % 2 != 0) {
            return;
        }
        ArrayList arrayList = new ArrayList(strArrE.length / 2);
        for (int i = 0; i < strArrE.length; i += 2) {
            chat.ola.vn.entity.ac acVar = new chat.ola.vn.entity.ac();
            acVar.a = strArrE[i];
            acVar.b = strArrE[i + 1];
            arrayList.add(acVar);
        }
        gVar.a(strB2, strB, arrayList, sA);
    }
}
