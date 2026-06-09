package chat.ola.vn.w;

/* JADX INFO: loaded from: classes.dex */
public class ea implements bb {
    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        long jD = chat.ola.vn.util.e.d(sVar.a((short) 100));
        String strB = sVar.b((short) 7);
        String strB2 = sVar.b((short) 13);
        short sA = sVar.a(sVar.b((short) 45, 0), (short) 0);
        short sA2 = sVar.a(sVar.b((short) 38, 0), (short) -1);
        byte bA = sVar.a(sVar.b((short) 88, 0), (byte) -1);
        chat.ola.vn.message.f fVar = new chat.ola.vn.message.f(strB, (short) 0);
        fVar.b((short) 2);
        fVar.e(strB2);
        fVar.c(sA2);
        fVar.e(sA);
        fVar.a(bA);
        gVar.a(jD, fVar);
    }
}
