package chat.ola.vn.w;

/* JADX INFO: loaded from: classes.dex */
public class bp implements bb {
    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        if (!chat.ola.vn.util.m.a(bkVar.z)) {
            cgVar.a((short) 109, bkVar.z);
        }
        if (0 != bkVar.W) {
            cgVar.a((short) 130, bkVar.W);
        }
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        byte bA = sVar.a(sVar.b((short) 0, 0), (byte) -1);
        long jA = sVar.a(sVar.b((short) 130, 0), 0L);
        String strB = sVar.b((short) 109);
        if (bA < 0) {
            gVar.a(jA, strB, sVar.a((short) 23), sVar.b((short) 110));
        } else {
            if (bA == 9) {
                return;
            }
            gVar.a(jA, strB, sVar.b((short) 8));
        }
    }
}
