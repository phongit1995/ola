package chat.ola.vn.w;

import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
class bf implements bb {
    bf() {
    }

    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        cgVar.a((short) 100, bkVar.R);
        if (bkVar.c != null) {
            cgVar.a((short) 79, bkVar.c);
        }
        cgVar.a((short) 114, bkVar.as);
        if (bkVar.aj != 0) {
            cgVar.a((short) 255, (byte) bkVar.aj);
        }
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        long j;
        String str;
        String str2;
        short s;
        ArrayList arrayList;
        long j2;
        boolean z;
        char c;
        String[] strArrE;
        s sVar2 = sVar;
        short sA = sVar2.a(sVar2.b((short) 255, 0), (short) 0);
        long jA = sVar2.a(sVar2.b((short) 100, 0), 0L);
        String strB = sVar2.b((short) 101);
        String strB2 = sVar2.b((short) 104);
        if (chat.ola.vn.util.m.a(strB2)) {
            try {
                chat.ola.vn.entity.s sVarA = chat.ola.vn.h.x.a(jA);
                if (sVarA != null) {
                    strB2 = sVarA.f();
                }
            } catch (Throwable unused) {
            }
        }
        String str3 = strB2;
        short s2 = 7;
        int iC = sVar2.c((short) 7);
        ArrayList arrayList2 = null;
        if (iC > 0) {
            arrayList2 = new ArrayList(iC);
            arrayList = new ArrayList(iC);
            int iB = sVar2.b((short) 7, 0);
            int i = 0;
            while (i < iC) {
                int iA = sVar2.a(s2, iB);
                String strC = sVar2.c(iB);
                String strB3 = sVar2.b((short) 13, iB, iA);
                String strB4 = sVar2.b((short) 86, iB, iA);
                String strB5 = sVar2.b((short) 22, iB, iA);
                int i2 = iC;
                String strB6 = sVar2.b((short) 109, iB, iA);
                short s3 = sA;
                String str4 = str3;
                short sA2 = sVar2.a((short) 45, iB, iA, (short) 0);
                String str5 = strB;
                if (sVar2.a((short) 115, iB, iA, (short) 0) == 1) {
                    j2 = jA;
                    z = true;
                } else {
                    j2 = jA;
                    z = false;
                }
                boolean z2 = sVar2.a((short) 114, iB, iA, (short) 0) == 1;
                short sA3 = sVar2.a((short) 38, iB, iA, (short) -1);
                int i3 = i;
                byte bA = sVar2.a((short) 88, iB, iA, (byte) -1);
                String strB7 = sVar2.b((short) 79, iB, iA);
                if (!chat.ola.vn.util.m.b(ciVar.f, strC)) {
                    chat.ola.vn.message.f fVarD = chat.ola.vn.h.t.d(strC);
                    if (fVarD == null) {
                        c = 0;
                        fVarD = new chat.ola.vn.message.f(strC, (short) 0);
                        fVarD.c(strB5);
                    } else {
                        c = 0;
                    }
                    if (strB7 != null && (strArrE = chat.ola.vn.util.m.e(strB7, " ")) != null && strArrE.length >= 2) {
                        fVarD.j(strArrE[c]);
                        fVarD.k(strArrE[1]);
                    }
                    fVarD.f(strB4);
                    fVarD.b((short) 2);
                    fVarD.e(strB3);
                    fVarD.e(sA2);
                    fVarD.c(sA3);
                    fVarD.i(strB6);
                    fVarD.a(bA);
                    fVarD.c(z2);
                    arrayList2.add(fVarD);
                    if (z) {
                        arrayList.add(fVarD);
                    }
                }
                i = i3 + 1;
                iB = iA;
                iC = i2;
                sA = s3;
                str3 = str4;
                strB = str5;
                jA = j2;
                sVar2 = sVar;
                s2 = 7;
            }
            j = jA;
            str = strB;
            str2 = str3;
            s = sA;
        } else {
            j = jA;
            str = strB;
            str2 = str3;
            s = sA;
            arrayList = null;
        }
        gVar.a(j, str, str2, arrayList2, arrayList, s);
    }
}
