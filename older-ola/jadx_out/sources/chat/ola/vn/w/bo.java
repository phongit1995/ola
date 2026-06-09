package chat.ola.vn.w;

/* JADX INFO: loaded from: classes.dex */
public class bo implements bb {
    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        cgVar.a((short) 7, bkVar.p);
        cgVar.a((short) 43, bkVar.am);
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        String strB = sVar.b((short) 7);
        if (sVar.a((short) 45) == null) {
            gVar.h(strB);
            return;
        }
        short sA = sVar.a(sVar.b((short) 45, 0), (short) 0);
        long jA = sVar.a(sVar.b((short) 9, 0), 0L);
        if (jA <= 0 || sA <= 0) {
            return;
        }
        gVar.b(strB, sA, ((int) ((jA - System.currentTimeMillis()) / 86400000)) + 1);
    }
}
