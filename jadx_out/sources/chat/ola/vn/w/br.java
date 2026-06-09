package chat.ola.vn.w;

/* JADX INFO: loaded from: classes.dex */
public class br implements bb {
    static bb[] e;

    public br() {
        if (e == null) {
            e = new bb[10];
            e[4] = new cf();
        }
    }

    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
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
