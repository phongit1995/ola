package chat.ola.vn.w;

/* JADX INFO: loaded from: classes.dex */
class dl implements bb {
    dl() {
    }

    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        cgVar.a((short) 7, bkVar.n);
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
        String strB = sVar.b((short) 7);
        String strB2 = sVar.b((short) 24);
        short sA = sVar.a(sVar.b((short) 45, 0), (short) 0);
        String strB3 = sVar.b((short) 110);
        long jA = sVar.a(sVar.b((short) 9, 0), 0L);
        if (jA == 0) {
            jA = System.currentTimeMillis();
        }
        chat.ola.vn.message.d dVar = new chat.ola.vn.message.d();
        dVar.d(strB);
        dVar.f("##" + strB2 + "#");
        dVar.a(sA);
        dVar.a(jA);
        dVar.a((byte) 2);
        String strB4 = sVar.b((short) 110);
        if (strB4 != null) {
            ciVar.e(strB, strB4);
        }
        if (!chat.ola.vn.util.m.a(strB4)) {
            dVar.h(strB4);
        }
        gVar.a(chat.ola.vn.util.m.b(ciVar.f, strB) ? chat.ola.vn.message.e.a(dVar, (byte) 2) : chat.ola.vn.message.e.a(dVar, (byte) 1));
        if (strB3 != null) {
            ciVar.e(strB, strB3);
        }
        try {
            if (chat.ola.vn.entity.i.i(strB2) == 3) {
                ciVar.a("inbox:" + ciVar.f, new String[]{strB2}, (short) 0);
            }
        } catch (Throwable unused) {
        }
    }
}
