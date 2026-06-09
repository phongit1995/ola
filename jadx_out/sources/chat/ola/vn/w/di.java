package chat.ola.vn.w;

/* JADX INFO: loaded from: classes.dex */
public class di implements bb {
    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        cgVar.a((short) 111, bkVar.p);
        cgVar.a((short) 114, bkVar.aq);
        if (bkVar.aj != 0) {
            cgVar.a((short) 255, (byte) bkVar.aj);
        }
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        String strB = sVar.b((short) 7);
        if (sVar.a(sVar.b((short) 114, 0), (short) 0) == 1) {
            gVar.d(strB);
        } else {
            gVar.e(strB);
        }
    }
}
