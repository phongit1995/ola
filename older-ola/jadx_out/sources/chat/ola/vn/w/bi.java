package chat.ola.vn.w;

/* JADX INFO: loaded from: classes.dex */
public class bi implements bb {
    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        cgVar.a((short) 114, bkVar.as);
        if (bkVar.ae != 0) {
            cgVar.a((short) 62, (byte) bkVar.ae);
        }
        if (bkVar.t != null) {
            try {
                for (String str : bkVar.t) {
                    if (!chat.ola.vn.util.m.a(str)) {
                        cgVar.a((short) 24, str);
                    }
                }
            } catch (Throwable unused) {
            }
        }
        if (!chat.ola.vn.util.m.a(bkVar.s)) {
            cgVar.a((short) 24, bkVar.s);
        }
        if (!chat.ola.vn.util.m.c(bkVar.z)) {
            cgVar.a((short) 109, bkVar.z);
        }
        if (!chat.ola.vn.util.m.c(bkVar.A)) {
            cgVar.a((short) 110, bkVar.A);
        }
        if (bkVar.aj != 0) {
            cgVar.a((short) 255, (byte) bkVar.aj);
        }
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
    }
}
