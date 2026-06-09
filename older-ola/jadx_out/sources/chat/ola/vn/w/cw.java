package chat.ola.vn.w;

/* JADX INFO: loaded from: classes.dex */
public class cw implements bb {
    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        String str = bkVar.p;
        short s = bkVar.ag;
        String str2 = bkVar.m;
        if (!chat.ola.vn.util.m.a(str)) {
            cgVar.a((short) 7, str);
        }
        if (s != 0) {
            cgVar.a((short) 66, (byte) s);
        }
        if (chat.ola.vn.util.m.a(str2)) {
            return;
        }
        cgVar.a((short) 8, str2);
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
    }
}
