package chat.ola.vn.w;

import java.util.Locale;

/* JADX INFO: loaded from: classes.dex */
public class de implements bb {
    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        cgVar.a((short) 7, bkVar.p.toLowerCase(Locale.US));
        cgVar.a((short) 110, bkVar.A);
        if (bkVar.Q != 0) {
            cgVar.a((short) 130, bkVar.Q);
        }
        if (bkVar.U != 0) {
            cgVar.a((short) 59, bkVar.U);
        }
        if (bkVar.aj != 0) {
            cgVar.a((short) 255, (byte) bkVar.aj);
        }
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        String strB = sVar.b((short) 111);
        String strB2 = sVar.b((short) 7);
        String strB3 = sVar.b((short) 110);
        short sA = sVar.a(sVar.b((short) 45, 0), (short) 0);
        short sA2 = sVar.a(sVar.b((short) 114, 0), (short) 0);
        int iA = (int) (sVar.a(sVar.b((short) 130, 0), 0L) / 86400000);
        long jA = sVar.a(sVar.b((short) 59, 0), 0L);
        chat.ola.vn.entity.ah ahVar = new chat.ola.vn.entity.ah(sA);
        chat.ola.vn.entity.ah ahVarB = chat.ola.vn.j.a().b(sA);
        if (ahVarB != null) {
            ahVar.a(ahVarB.d());
        }
        ahVar.b(strB3);
        gVar.a(strB, strB2, sA2, ahVar, iA, jA);
    }
}
