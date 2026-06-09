package chat.ola.vn.w;

/* JADX INFO: loaded from: classes.dex */
class ai implements bb {
    ai() {
    }

    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        cgVar.a((short) 7, bkVar.p);
        if (bkVar.aj != 0) {
            cgVar.a((short) 255, (byte) bkVar.aj);
        }
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        short sA = sVar.a(sVar.b((short) 255, 0), (short) 0);
        String strB = sVar.b((short) 7);
        if (chat.ola.vn.util.m.a(strB)) {
            gVar.b(sVar.b((short) 109), sA);
            return;
        }
        String strB2 = sVar.b((short) 109);
        String strB3 = sVar.b((short) 110);
        String strB4 = sVar.b((short) 111);
        short sA2 = sVar.a(sVar.b((short) 66, 0), (short) 0);
        int iA = sVar.a(sVar.b((short) 124, 0), 0);
        int iA2 = sVar.a(sVar.b((short) 125, 0), 0);
        int iA3 = sVar.a(sVar.b((short) 126, 0), 0);
        long jA = sVar.a(sVar.b((short) 130, 0), 0L);
        chat.ola.vn.entity.b bVar = new chat.ola.vn.entity.b();
        bVar.a = strB;
        bVar.b = strB2;
        bVar.c = strB3;
        bVar.d = strB4;
        bVar.j = sA2;
        bVar.f = iA;
        bVar.g = iA2;
        bVar.h = iA3;
        bVar.i = jA;
        gVar.a(bVar, sA);
    }
}
