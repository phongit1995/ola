package chat.ola.vn.w;

/* JADX INFO: loaded from: classes.dex */
class co implements bb {
    co() {
    }

    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        String str = bkVar.m;
        if (bkVar.as != 0) {
            cgVar.a((short) 114, bkVar.as);
        }
        if (str != null) {
            cgVar.a((short) 8, str);
        }
        String str2 = bkVar.s;
        if (str2 != null) {
            cgVar.a((short) 24, str2);
        }
        if (bkVar.ak != 0) {
            cgVar.a((short) 12, (byte) bkVar.ak);
        }
        if (bkVar.ai != 0) {
            cgVar.a((short) 220, (byte) bkVar.ai);
        }
        long j = bkVar.S;
        if (j != 0) {
            cgVar.a((short) 72, j);
        }
        if (bkVar.c != null) {
            cgVar.a((short) 79, bkVar.c);
        }
        if (!chat.ola.vn.util.m.a(bkVar.D)) {
            cgVar.a((short) 113, bkVar.D);
        }
        if (bkVar.aj != 0) {
            cgVar.a((short) 255, (byte) bkVar.aj);
        }
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        long jA = sVar.a(sVar.b((short) 72, 0), 0L);
        String strB = sVar.b((short) 8);
        short sA = sVar.a(sVar.b((short) 255, 0), (short) 0);
        if (jA != 0) {
            gVar.b(jA, sA);
        } else {
            gVar.j(strB, sA);
        }
    }
}
