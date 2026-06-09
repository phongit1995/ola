package chat.ola.vn.w;

/* JADX INFO: renamed from: chat.ola.vn.w.do, reason: invalid class name */
/* JADX INFO: loaded from: classes.dex */
class Cdo implements chat.ola.vn.f.c, bb {
    Cdo() {
    }

    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        cgVar.a((short) 7, bkVar.n);
        cgVar.a((short) 220, (byte) bkVar.ai);
        cgVar.a((short) 8, bkVar.m);
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
        String strB = sVar.b((short) 7);
        String strB2 = sVar.b((short) 8);
        short sA = sVar.a(sVar.b((short) 45, 0), (short) 0);
        short sA2 = sVar.a(sVar.b((short) 220, 0), (short) 0);
        long jA = sVar.a(sVar.b((short) 9, 0), 0L);
        if (jA == 0) {
            jA = System.currentTimeMillis();
        }
        if (strB2 == null) {
            strB2 = "";
        }
        chat.ola.vn.message.d dVar = new chat.ola.vn.message.d();
        dVar.d(strB);
        if (chat.ola.vn.util.m.b(strB2, b)) {
            strB2 = a;
        }
        dVar.f(strB2);
        dVar.a(sA);
        dVar.b(sA2);
        dVar.a(jA);
        dVar.a((byte) 2);
        String strB3 = sVar.b((short) 110);
        if (strB3 != null) {
            ciVar.e(strB, strB3);
        }
        if (!chat.ola.vn.util.m.a(strB3)) {
            dVar.h(strB3);
        }
        chat.ola.vn.message.d dVarA = chat.ola.vn.util.m.b(ciVar.f, strB) ? chat.ola.vn.message.e.a(dVar, (byte) 2) : chat.ola.vn.message.e.a(dVar, (byte) 1);
        gVar.a(dVarA);
        try {
            if (dVarA.e() == 3) {
                ciVar.a("inbox:" + ciVar.f, new String[]{((chat.ola.vn.message.aa) dVarA).C()}, (short) 0);
            }
        } catch (Throwable unused) {
        }
    }
}
