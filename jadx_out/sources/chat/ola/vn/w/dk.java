package chat.ola.vn.w;

/* JADX INFO: loaded from: classes.dex */
class dk implements bb {
    dk() {
    }

    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        cgVar.a((short) 129, bkVar.w);
        cgVar.a((short) 24, bkVar.s);
        if (!chat.ola.vn.util.m.a(bkVar.z)) {
            cgVar.a((short) 109, bkVar.z);
        }
        if (chat.ola.vn.util.m.a(bkVar.A)) {
            return;
        }
        cgVar.a((short) 110, bkVar.A);
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        String strB = sVar.b((short) 129);
        String strB2 = sVar.b((short) 7);
        String strB3 = sVar.b((short) 24);
        long jA = sVar.a(sVar.b((short) 9, 0), System.currentTimeMillis());
        short sA = sVar.a(sVar.b((short) 45, 0), (short) 0);
        String strB4 = sVar.b((short) 110);
        chat.ola.vn.message.d dVar = new chat.ola.vn.message.d();
        dVar.d(strB2);
        dVar.f("##" + strB3 + "#");
        dVar.a(sA);
        dVar.a(jA);
        dVar.h(strB4);
        dVar.a((byte) 2);
        gVar.c(strB, dVar);
        if (strB4 != null) {
            ciVar.e(strB2, strB4);
        }
    }
}
