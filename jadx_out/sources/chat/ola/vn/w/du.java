package chat.ola.vn.w;

/* JADX INFO: loaded from: classes.dex */
public class du implements bb {
    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        if (bkVar.aA) {
            cgVar.a((short) 10, new byte[]{1});
        }
        if (!chat.ola.vn.util.m.a(bkVar.z)) {
            cgVar.a((short) 109, bkVar.z);
        }
        cgVar.a((short) 47, bkVar.v);
        if (bkVar.aj != 0) {
            cgVar.a((short) 255, (byte) bkVar.aj);
        }
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        gVar.g(sVar.b((short) 109), sVar.a(sVar.b((short) 255, 0), (short) 0));
    }
}
