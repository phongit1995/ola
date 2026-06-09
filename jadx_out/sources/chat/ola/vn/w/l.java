package chat.ola.vn.w;

/* JADX INFO: loaded from: classes.dex */
public class l implements bb {
    String e;

    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        this.e = bkVar.z;
        if (bkVar.aj != 0) {
            cgVar.a((short) 255, (byte) bkVar.aj);
        }
        cgVar.a((short) 43, bkVar.am);
        cgVar.a((short) 46, bkVar.an);
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        gVar.h(this.e, sVar.a(sVar.b((short) 255, 0), (short) 0));
    }
}
