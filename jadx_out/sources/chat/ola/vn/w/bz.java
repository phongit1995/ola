package chat.ola.vn.w;

/* JADX INFO: loaded from: classes.dex */
public class bz implements bb {
    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        cgVar.a((short) 114, (byte) 1);
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        String strB = sVar.b((short) 138);
        short sA = cc.a(sVar.a(sVar.b((short) 139, 0), (short) 0));
        String strB2 = sVar.b((short) 22);
        String strB3 = sVar.b((short) 7);
        boolean zD = sVar.d((short) 115);
        boolean zD2 = sVar.d((short) 114);
        long jA = sVar.a(sVar.b((short) 9, 0), 0L);
        byte bA = sVar.a(sVar.b((short) 88, 0), (byte) -1);
        byte bA2 = sVar.a(sVar.b((short) 118, 0), (byte) 0);
        String strB4 = sVar.b((short) 13);
        byte bA3 = sVar.a(sVar.b((short) 38, 0), (short) -1);
        String strB5 = sVar.b((short) 52);
        byte bA4 = sVar.a(sVar.b((short) 45, 0), (byte) 0);
        int iA = sVar.a(sVar.b((short) 124, 0), 0);
        int iA2 = sVar.a(sVar.b((short) 125, 0), 0);
        chat.ola.vn.entity.ah ahVarB = bA4 > 0 ? chat.ola.vn.j.a().b(bA4) : null;
        chat.ola.vn.message.v vVar = new chat.ola.vn.message.v();
        vVar.d(strB3);
        vVar.B = strB2;
        vVar.J = zD;
        vVar.K = zD2;
        vVar.C = jA;
        vVar.F = bA;
        vVar.G = bA2;
        vVar.H = bA3;
        vVar.A = strB5;
        vVar.z = ahVarB;
        vVar.I = bA4;
        vVar.D = iA;
        vVar.E = iA2;
        vVar.a(System.currentTimeMillis());
        vVar.f(strB4);
        gVar.a(strB, sA, vVar);
    }
}
