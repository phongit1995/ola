package chat.ola.vn.w;

/* JADX INFO: loaded from: classes.dex */
class m implements bb {
    m() {
    }

    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        cgVar.a((short) 12, (byte) 2);
        String str = bkVar.r;
        if (chat.ola.vn.util.m.c(str)) {
            return;
        }
        cgVar.a((short) 13, str);
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        short s = 7;
        int iC = sVar.c((short) 7);
        if (iC == 0) {
            return;
        }
        chat.ola.vn.message.f[] fVarArr = new chat.ola.vn.message.f[iC];
        int iB = sVar.b((short) 7, 0);
        boolean z = false;
        int i = 0;
        while (!z) {
            int iA = sVar.a(s, iB);
            boolean z2 = iA <= 0 ? true : z;
            String strC = sVar.c(iB);
            short sA = sVar.a(sVar.a((short) 12, iB, iA), (short) 0);
            short sA2 = sVar.a((short) 45, iB, iA, (short) 0);
            short sA3 = sVar.a((short) 38, iB, iA, (short) -1);
            String strB = sVar.b((short) 13, iB, iA);
            long jA = sVar.a((short) 58, iB, iA, 0L);
            fVarArr[i] = new chat.ola.vn.message.f(strC, (short) 0);
            fVarArr[i].e(sA2);
            fVarArr[i].c(sA3);
            fVarArr[i].b(sA);
            fVarArr[i].e(strB);
            fVarArr[i].c(jA);
            i++;
            iB = iA;
            z = z2;
            s = 7;
        }
        gVar.a(fVarArr);
    }
}
