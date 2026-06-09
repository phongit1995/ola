package chat.ola.vn.w;

/* JADX INFO: loaded from: classes.dex */
class o implements bb {
    o() {
    }

    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        if (bkVar.x != null) {
            cgVar.a((short) 94, bkVar.x);
        }
        if (bkVar.h != null) {
            cgVar.a((short) 50, bkVar.h);
        }
        if (bkVar.y != null) {
            cgVar.a((short) 86, bkVar.y);
        }
        cgVar.a((short) 51, bkVar.X + "x" + bkVar.Y);
        if (bkVar.z != null) {
            cgVar.a((short) 14, bkVar.z);
        }
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        String strB = sVar.b((short) 28);
        String strB2 = sVar.b((short) 30);
        String strB3 = sVar.b((short) 8);
        String strB4 = sVar.b((short) 24);
        short sA = sVar.a(sVar.b((short) 12, 0), (short) 0);
        if (chat.ola.vn.util.m.a(strB2)) {
            return;
        }
        gVar.a(strB, strB2, strB3, strB4, sA == 1);
    }
}
