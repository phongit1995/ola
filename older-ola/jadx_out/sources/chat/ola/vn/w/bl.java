package chat.ola.vn.w;

/* JADX INFO: loaded from: classes.dex */
class bl implements bb {
    bl() {
    }

    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        if (bkVar.p != null) {
            cgVar.a((short) 7, bkVar.p.toLowerCase());
        }
        if (bkVar.z != null) {
            cgVar.a((short) 109, bkVar.z);
        }
        cgVar.a((short) 114, bkVar.as);
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        String strB = sVar.b((short) 7);
        String strB2 = sVar.b((short) 109);
        boolean z = sVar.a(sVar.b((short) 114, 0), (byte) 0) == 1;
        if (strB != null) {
            if (strB2 != null) {
                if (z) {
                    gVar.h(strB2, strB);
                    return;
                } else {
                    gVar.i(strB2, strB);
                    return;
                }
            }
            if (z) {
                gVar.b(strB);
            } else {
                gVar.c(strB);
            }
        }
    }
}
