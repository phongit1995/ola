package chat.ola.vn.w;

/* JADX INFO: loaded from: classes.dex */
class da implements bb {
    da() {
    }

    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        if (bkVar.aj != 0) {
            cgVar.a((short) 255, (byte) bkVar.aj);
        }
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        short sA = sVar.a(sVar.b((short) 255, 0), (short) 0);
        byte[] bArrA = sVar.a((short) 1);
        ciVar.a(sVar.a((short) 11));
        gVar.a(bArrA, sA);
    }
}
