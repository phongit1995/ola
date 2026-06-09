package chat.ola.vn.w;

/* JADX INFO: loaded from: classes.dex */
class ba implements bb {
    ba() {
    }

    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        cgVar.a((short) 2, bkVar.e);
        cgVar.a((short) 12, (byte) 2);
        cgVar.a((short) 61, bkVar.g);
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
        if (bkVar.M != null) {
            cgVar.a((short) 110, bkVar.M);
        }
        if (bkVar.B != null) {
            cgVar.a((short) 111, bkVar.B);
        }
        if (bkVar.c != null) {
            cgVar.a((short) 79, bkVar.c);
        }
        if (bkVar.aj != 0) {
            cgVar.a((short) 255, (byte) bkVar.aj);
        }
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        short sA = sVar.a(sVar.b((short) 255, 0), (short) 0);
        String strB = sVar.b((short) 4);
        String strB2 = sVar.b((short) 22);
        String strB3 = sVar.b((short) 13);
        String strB4 = sVar.b((short) 110);
        String strB5 = sVar.b((short) 61);
        if (chat.ola.vn.util.m.a(strB5)) {
            strB5 = "US";
        }
        chat.ola.vn.h.T = strB5;
        long jA = sVar.a(sVar.b((short) 9, 0), 0L);
        short sA2 = sVar.a(sVar.b((short) 45, 0), (short) -1);
        ciVar.j = strB;
        ciVar.h = strB2;
        if (sA2 >= 0) {
            ciVar.o = sA2;
        }
        ciVar.i = strB3;
        ciVar.e = jA;
        ciVar.k = strB4;
        ciVar.c(true);
        gVar.a(ciVar, sA);
        ciVar.b();
    }
}
