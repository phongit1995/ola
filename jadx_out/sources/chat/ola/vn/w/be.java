package chat.ola.vn.w;

/* JADX INFO: loaded from: classes.dex */
class be implements bb {
    be() {
    }

    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        if (bkVar.aj != 0) {
            cgVar.a((short) 255, (byte) bkVar.aj);
        }
        if (bkVar.p != null) {
            cgVar.a((short) 7, bkVar.p);
        }
        if (bkVar.A != null) {
            cgVar.a((short) 110, bkVar.A);
        }
        cgVar.a((short) 22, bkVar.i);
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        short sA = sVar.a(sVar.b((short) 255, 0), (short) 0);
        String strB = sVar.b((short) 7);
        String strB2 = sVar.b((short) 21);
        String strB3 = sVar.b((short) 129);
        String strB4 = sVar.b((short) 22);
        String strB5 = sVar.b((short) 13);
        String strB6 = sVar.b((short) 24);
        String strB7 = sVar.b((short) 110);
        if (strB != null) {
            gVar.a(strB, strB2, strB3, strB6, strB4, strB5);
        } else {
            gVar.a(strB7, strB2, strB3, strB6, strB4, strB5, sA);
        }
    }
}
