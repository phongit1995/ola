package chat.ola.vn.w;

/* JADX INFO: loaded from: classes.dex */
public class cn implements bb {
    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        cgVar.a((short) 114, bkVar.as);
        cgVar.a((short) 8, bkVar.m);
        if (bkVar.s != null) {
            cgVar.a((short) 24, bkVar.s);
        }
        if (bkVar.ai != 0) {
            cgVar.a((short) 220, (byte) bkVar.ai);
        }
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        long jA = sVar.a(sVar.b((short) 72, 0), 0L);
        String strB = sVar.b((short) 8);
        short sA = sVar.a(sVar.b((short) 255, 0), (short) 0);
        if (jA != 0) {
            gVar.b(jA, sA);
        } else {
            gVar.j(strB, sA);
        }
    }
}
