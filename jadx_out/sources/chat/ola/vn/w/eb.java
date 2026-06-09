package chat.ola.vn.w;

/* JADX INFO: loaded from: classes.dex */
public class eb implements bb {
    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        if (bkVar.as != 0) {
            cgVar.a((short) 114, bkVar.as);
        }
        if (bkVar.F != null) {
            for (int i = 0; i < bkVar.F.length; i++) {
                cgVar.a((short) 109, bkVar.F[i]);
                cgVar.a((short) 24, bkVar.t[i]);
            }
        }
        if (!chat.ola.vn.util.m.a(bkVar.A)) {
            cgVar.a((short) 110, bkVar.A);
        }
        if (bkVar.aj != 0) {
            cgVar.a((short) 255, (byte) bkVar.aj);
        }
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        String[] strArr;
        short sA = sVar.a(sVar.b((short) 255, 0), (short) 0);
        int iC = sVar.c((short) 109);
        String[] strArr2 = null;
        if (iC > 0) {
            strArr2 = new String[iC];
            strArr = new String[iC];
            int iB = sVar.b((short) 109, 0);
            int iB2 = sVar.b((short) 24, 0);
            int iA = iB;
            for (int i = 0; i < iC; i++) {
                strArr2[i] = sVar.c(iA);
                strArr[i] = sVar.c(iB2);
                iA = sVar.a((short) 109, iA);
                iB2 = sVar.a((short) 24, iB2);
            }
        } else {
            strArr = null;
        }
        if (sVar.a(sVar.b((short) 114, 0), (byte) 0) != 1) {
            return;
        }
        gVar.a(strArr2, strArr, sA);
    }
}
