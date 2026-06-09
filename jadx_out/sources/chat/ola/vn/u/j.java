package chat.ola.vn.u;

import chat.ola.vn.w.cg;
import chat.ola.vn.w.s;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class j implements a {
    @Override // chat.ola.vn.u.a
    public cg a(e eVar, List<g> list) {
        return null;
    }

    @Override // chat.ola.vn.u.a
    public void a(s sVar, List<g> list) {
        String strB = sVar.b((short) 5);
        String strB2 = sVar.b((short) 4);
        int iA = sVar.a(sVar.b((short) 2, 0), 0);
        int iA2 = sVar.a(sVar.b((short) 8, 0), 0);
        int iC = sVar.c((short) 11);
        int iA3 = sVar.a(sVar.b((short) 12, 0), -1);
        ArrayList arrayList = null;
        Integer numValueOf = iA3 >= 0 ? Integer.valueOf(iA3) : null;
        if (iC > 0) {
            arrayList = new ArrayList(iC);
            int iB = sVar.b((short) 11, 0);
            for (int i = 0; i < iC; i++) {
                int iA4 = sVar.a(iB, -1);
                if (iA4 >= 0) {
                    arrayList.add(Integer.valueOf(iA4));
                }
                iB = sVar.a((short) 11, iB);
            }
        }
        ArrayList arrayList2 = arrayList;
        for (g gVar : list) {
            if (chat.ola.vn.util.m.b(strB2, gVar.b())) {
                gVar.a(strB2, strB, iA, iA2, arrayList2, numValueOf);
                return;
            }
        }
    }
}
