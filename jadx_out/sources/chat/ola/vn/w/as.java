package chat.ola.vn.w;

/* JADX INFO: loaded from: classes.dex */
public class as implements bb {
    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        if (bkVar.as != 0) {
            cgVar.a((short) 114, bkVar.as);
        }
        if (!chat.ola.vn.util.m.a(bkVar.z)) {
            cgVar.a((short) 109, bkVar.z);
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
        short sA = sVar.a(sVar.b((short) 255, 0), (short) 0);
        String strB = sVar.b((short) 29);
        String[] strArrE = null;
        try {
            if (!chat.ola.vn.util.m.a(strB)) {
                strArrE = chat.ola.vn.util.m.e(strB, ";");
            }
        } catch (Throwable unused) {
        }
        String[] strArr = strArrE;
        String strB2 = sVar.b((short) 109);
        String strB3 = sVar.b((short) 110);
        switch (sVar.a(sVar.b((short) 114, 0), (short) 0)) {
            case 0:
                try {
                    gVar.a(Long.parseLong(strB2), strB3, strArr, sA);
                } catch (Throwable unused2) {
                    return;
                }
                break;
            case 1:
                gVar.b(strB2, strB3, strArr, sA);
                break;
            case 2:
                gVar.c(strB2, strB3, strArr, sA);
                break;
            case 3:
                gVar.d(strB2, strB3, strArr, sA);
                break;
            case 4:
                gVar.e(strB2, strB3, strArr, sA);
                break;
            case 5:
                gVar.b(strB3, strArr, sA);
                break;
            case 6:
                gVar.a(strB3, strArr, sA);
                break;
            case 8:
                if (!chat.ola.vn.util.m.a(strB2)) {
                    gVar.d(strB2, sA);
                }
                break;
            case 9:
                if (!chat.ola.vn.util.m.a(strB2)) {
                    gVar.e(strB2, sA);
                }
                break;
            case 11:
                gVar.b(sVar.a(sVar.b((short) 115, 0), (short) 0), sA);
                break;
            case 12:
                gVar.a(strB2, strB3, strArr, sA);
                break;
            case 13:
                if (!chat.ola.vn.util.m.a(strB)) {
                    gVar.f(strB, sA);
                }
                break;
        }
    }
}
