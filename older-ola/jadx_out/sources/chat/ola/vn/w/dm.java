package chat.ola.vn.w;

/* JADX INFO: loaded from: classes.dex */
class dm implements bb {
    dm() {
    }

    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        cgVar.a((short) 129, bkVar.w);
        if (bkVar.m != null) {
            cgVar.a((short) 8, bkVar.m);
        }
        if (bkVar.ai != 0) {
            cgVar.a((short) 220, (byte) bkVar.ai);
        }
        if (!chat.ola.vn.util.m.a(bkVar.A)) {
            cgVar.a((short) 110, bkVar.A);
        }
        if (chat.ola.vn.util.m.a(bkVar.z)) {
            return;
        }
        cgVar.a((short) 109, bkVar.z);
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        String strB = sVar.b((short) 129);
        String strB2 = sVar.b((short) 7);
        String strB3 = sVar.b((short) 8);
        short sA = sVar.a(sVar.b((short) 220, 0), (short) 0);
        short sA2 = sVar.a(sVar.b((short) 45, 0), (short) 0);
        long jA = sVar.a(sVar.b((short) 9, 0), 0L);
        if (jA == 0) {
            jA = System.currentTimeMillis();
        }
        chat.ola.vn.message.d dVar = new chat.ola.vn.message.d();
        dVar.d(strB2);
        dVar.f(strB3);
        dVar.b(sA);
        dVar.a(sA2);
        dVar.a(jA);
        dVar.a((byte) 2);
        String strB4 = sVar.b((short) 110);
        if (strB4 != null) {
            ciVar.f(strB, strB4);
        }
        if (!chat.ola.vn.util.m.a(strB4)) {
            dVar.h(strB4);
        }
        gVar.c(strB, dVar);
    }
}
