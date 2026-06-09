package chat.ola.vn.w;

import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
public class ca implements bb {
    private String e;

    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        this.e = bkVar.A;
        if (chat.ola.vn.util.m.a(this.e)) {
            return;
        }
        cgVar.a((short) 110, this.e);
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        ArrayList arrayList;
        int i;
        short s = 138;
        int iC = sVar.c((short) 138);
        String str = null;
        byte b = 0;
        if (iC > 0) {
            arrayList = new ArrayList(iC);
            int iB = sVar.b((short) 138, 0);
            int i2 = 0;
            while (i2 < iC) {
                int iA = sVar.a(s, iB);
                chat.ola.vn.message.f fVar = new chat.ola.vn.message.f(sVar.c(iB), cc.a(sVar.a((short) 139, iB, iA, (short) b)));
                int iA2 = sVar.a((short) 205, iB, iA, (int) b);
                if (iA2 > 0) {
                    fVar.a(iA2);
                }
                String strB = sVar.b((short) 110, iB, iA);
                if (chat.ola.vn.util.m.a(strB)) {
                    i = iC;
                } else {
                    String strB2 = sVar.b((short) 7, iB, iA);
                    byte b2 = chat.ola.vn.util.m.b(strB2, chat.ola.vn.h.a()) ? (byte) 2 : (byte) 1;
                    chat.ola.vn.message.d dVar = new chat.ola.vn.message.d(b2);
                    String strB3 = sVar.b((short) 8, iB, iA);
                    byte bA = sVar.a((short) 137, iB, iA, b);
                    dVar.d(strB2);
                    i = iC;
                    dVar.a(sVar.a((short) 9, iB, iA, 0L));
                    dVar.f(strB3);
                    dVar.h(strB);
                    dVar.a(bA);
                    fVar.S = chat.ola.vn.message.e.a(dVar, b2);
                    str = strB;
                }
                arrayList.add(fVar);
                i2++;
                iB = iA;
                iC = i;
                s = 138;
                b = 0;
            }
        } else {
            arrayList = null;
        }
        gVar.b(arrayList, str, sVar.a(sVar.b((short) 255, 0), (short) 0));
    }
}
