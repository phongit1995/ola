package chat.ola.vn.w;

/* JADX INFO: loaded from: classes.dex */
class d implements bb {
    d() {
    }

    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        if (!chat.ola.vn.util.m.a(bkVar.o)) {
            cgVar.a((short) 21, bkVar.o);
        }
        if (bkVar.aj != 0) {
            cgVar.a((short) 255, (byte) bkVar.aj);
        }
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        gVar.a(sVar.b((short) 21), sVar.a(sVar.b((short) 255, 0), (short) 0));
    }
}
