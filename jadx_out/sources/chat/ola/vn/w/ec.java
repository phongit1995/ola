package chat.ola.vn.w;

/* JADX INFO: loaded from: classes.dex */
public class ec implements bb {
    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        cgVar.a((short) 114, bkVar.as);
        if (bkVar.p != null) {
            cgVar.a((short) 7, bkVar.p);
        }
        if (0 != bkVar.W) {
            cgVar.a((short) 130, bkVar.W);
        }
        if (bkVar.aj != 0) {
            cgVar.a((short) 255, (byte) bkVar.aj);
        }
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        short s;
        String str;
        String str2;
        chat.ola.vn.entity.g[] gVarArr;
        chat.ola.vn.entity.w wVar;
        chat.ola.vn.entity.g gVar2;
        byte b;
        short sA = sVar.a(sVar.b((short) 255, 0), (short) 0);
        short sA2 = sVar.a(sVar.b((short) 114, 0), (short) 0);
        String strB = sVar.b((short) 7);
        String strB2 = sVar.b((short) 28);
        String strB3 = sVar.b((short) 13);
        if (strB == null) {
            String str3 = ciVar.f;
        }
        short s2 = 109;
        int iC = sVar.c((short) 109);
        if (iC > 0) {
            gVarArr = new chat.ola.vn.entity.g[iC];
            int iB = sVar.b((short) 109, 0);
            int iB2 = sVar.b((short) 110, 0);
            int iB3 = sVar.b((short) 9, 0);
            int iB4 = sVar.b((short) 130, 0);
            int i = iB;
            int i2 = 0;
            while (i2 < iC) {
                int iA = sVar.a(s2, i);
                String strC = sVar.c(i);
                String strC2 = sVar.c(iB2);
                int i3 = iC;
                String strB4 = sVar.b((short) 8, i, iA);
                String strB5 = sVar.b((short) 24, i, iA);
                short s3 = sA;
                String str4 = strB2;
                short sA3 = sVar.a((short) 220, i, iA, (short) 0);
                String str5 = strB3;
                short sA4 = sVar.a((short) 45, i, iA, (short) 0);
                int i4 = iB2;
                long jA = sVar.a(iB3, 0L);
                long jA2 = sVar.a(iB4, 0L);
                gVarArr[i2] = new chat.ola.vn.entity.g();
                gVarArr[i2].e(strC);
                gVarArr[i2].a(strC2);
                gVarArr[i2].b(strB4);
                gVarArr[i2].c(strB5);
                if (sA3 > 0) {
                    wVar = new chat.ola.vn.entity.w();
                    wVar.a(sA3);
                } else {
                    wVar = null;
                }
                if (wVar == null && chat.ola.vn.entity.w.b(strB5)) {
                    wVar = new chat.ola.vn.entity.w();
                    wVar.a(strB5);
                }
                gVarArr[i2].a(wVar);
                gVarArr[i2].e(sA4);
                gVarArr[i2].a(jA);
                gVarArr[i2].c(jA2);
                if (sA2 == 0) {
                    gVar2 = gVarArr[i2];
                    b = 1;
                } else {
                    if (sA2 == 1) {
                        gVar2 = gVarArr[i2];
                        b = 2;
                    }
                    iB2 = sVar.a((short) 110, i4);
                    iB3 = sVar.a((short) 9, iB3);
                    iB4 = sVar.a((short) 130, iB4);
                    i2++;
                    iC = i3;
                    sA = s3;
                    strB2 = str4;
                    strB3 = str5;
                    i = iA;
                    s2 = 109;
                }
                gVar2.a(b);
                iB2 = sVar.a((short) 110, i4);
                iB3 = sVar.a((short) 9, iB3);
                iB4 = sVar.a((short) 130, iB4);
                i2++;
                iC = i3;
                sA = s3;
                strB2 = str4;
                strB3 = str5;
                i = iA;
                s2 = 109;
            }
            s = sA;
            str = strB2;
            str2 = strB3;
        } else {
            s = sA;
            str = strB2;
            str2 = strB3;
            gVarArr = null;
        }
        if (sA2 == 0) {
            gVar.a(str, str2, gVarArr, s);
        } else {
            short s4 = s;
            String str6 = str;
            String str7 = str2;
            if (sA2 == 1) {
                gVar.b(str6, str7, gVarArr, s4);
            }
        }
    }
}
