package chat.ola.vn.w;

/* JADX INFO: loaded from: classes.dex */
class ae implements bb {
    ae() {
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
        long jD = chat.ola.vn.util.e.d(sVar.a((short) 59));
        String strB = sVar.b((short) 8);
        if (strB != null) {
            gVar.b(jD, strB);
        } else {
            gVar.a(jD, sA);
        }
    }
}
