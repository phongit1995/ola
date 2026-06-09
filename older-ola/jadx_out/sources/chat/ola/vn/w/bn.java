package chat.ola.vn.w;

/* JADX INFO: loaded from: classes.dex */
public class bn implements bb {
    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        cgVar.a((short) 62, bkVar.aw ? (byte) 1 : (byte) 0);
        cgVar.a((short) 7, bkVar.p);
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        short sA = sVar.a(sVar.b((short) 62, 0), (short) 0);
        String strB = sVar.b((short) 7);
        if (sA == 1) {
            gVar.f(strB);
        } else {
            gVar.g(strB);
        }
    }
}
