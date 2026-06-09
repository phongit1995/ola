package chat.ola.vn.w;

/* JADX INFO: loaded from: classes.dex */
class dg implements bb {
    dg() {
    }

    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        cgVar.a((short) 129, bkVar.w);
        cgVar.a((short) 12, (byte) bkVar.ac);
        if (bkVar.aj != 0) {
            cgVar.a((short) 255, (byte) bkVar.aj);
        }
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        String strB = sVar.b((short) 129);
        String strB2 = sVar.b((short) 7);
        switch (sVar.a(sVar.b((short) 12, 0), (byte) 0)) {
            case 0:
                gVar.d(strB, strB2);
                break;
            case 1:
                gVar.e(strB, strB2);
                break;
        }
    }
}
