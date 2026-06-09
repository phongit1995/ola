package chat.ola.vn.w;

/* JADX INFO: loaded from: classes.dex */
public class cc implements bb {
    static bb[] e;

    public cc() {
        if (e == null) {
            e = new bb[100];
            e[1] = new ca();
            e[2] = new bv();
            e[3] = new bz();
            e[4] = new bs();
            e[7] = new bw();
            e[6] = new bu();
            e[12] = new cb();
            e[13] = new by();
            e[14] = new bx();
            e[15] = new bt();
            e[16] = new cd();
        }
    }

    public static short a(short s) {
        return s != 1 ? (short) 0 : (short) 2;
    }

    public static short b(short s) {
        return s != 2 ? (short) 0 : (short) 1;
    }

    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        if (!chat.ola.vn.util.m.a(bkVar.N)) {
            cgVar.a((short) 138, bkVar.N);
            bkVar.av = bkVar.av == 2 ? (byte) 1 : (byte) 0;
            cgVar.a((short) 139, bkVar.av);
        }
        if (bkVar.aj != 0) {
            cgVar.a((short) 255, (byte) bkVar.aj);
        }
        cgVar.a((short) 140, bkVar.au);
        e[bkVar.au].a(bkVar, cgVar, gVar);
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        e[sVar.a(sVar.b((short) 140, 0), (short) 0)].a(sVar, gVar, ciVar);
    }
}
