package chat.ola.vn.w;

/* JADX INFO: loaded from: classes.dex */
public class dx implements bb {
    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        cgVar.a((short) 7, bkVar.p);
        cgVar.a((short) 17, bkVar.U);
        cgVar.a((short) 43, bkVar.am);
        if (bkVar.aj != 0) {
            cgVar.a((short) 255, (byte) bkVar.aj);
        }
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        short sA = sVar.a(sVar.b((short) 255, 0), (short) 0);
        String strB = sVar.b((short) 7);
        if (strB != null) {
            gVar.a(strB, sVar.a(sVar.b((short) 17, 0), 0L));
        } else {
            gVar.a(sA);
        }
    }
}
