package chat.ola.vn.w;

/* JADX INFO: loaded from: classes.dex */
public class h implements bb {
    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        if (bkVar.p != null) {
            cgVar.a((short) 7, bkVar.p);
        }
        cgVar.a((short) 205, bkVar.Z);
        cgVar.a((short) 45, (byte) bkVar.ad);
        if (bkVar.aj != 0) {
            cgVar.a((short) 255, (byte) bkVar.aj);
        }
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        int i;
        short sA = sVar.a(sVar.b((short) 255, 0), (short) 0);
        String strB = sVar.b((short) 7);
        byte bA = sVar.a(sVar.b((short) 45, 0), (byte) 0);
        long jA = sVar.a(sVar.b((short) 9, 0), -1L);
        if (jA >= 0) {
            int i2 = (int) (jA / 3600000);
            if (jA % 3600000 != 0) {
                i2++;
            }
            int i3 = i2 / 24;
            if (i2 % 24 != 0) {
                i3++;
            }
            i = i3;
        } else {
            i = -1;
        }
        long jA2 = sVar.a(sVar.b((short) 59, 0), -1L);
        if (strB == null || strB.equalsIgnoreCase(ciVar.f)) {
            gVar.a(strB, bA, i, jA2, sA);
        } else if (jA2 >= 0) {
            gVar.a(strB, bA, i, sA);
        } else {
            gVar.b(strB, bA, i, sA);
        }
    }
}
