package chat.ola.vn.w;

import java.util.Locale;

/* JADX INFO: loaded from: classes.dex */
class ap implements bb {
    ap() {
    }

    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        if (0 != bkVar.Q) {
            cgVar.a((short) 9, bkVar.Q);
        }
        if (bkVar.as != 0) {
            cgVar.a((short) 114, bkVar.as);
        }
        if (bkVar.aj != 0) {
            cgVar.a((short) 255, (byte) bkVar.aj);
        }
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        int length;
        short sA = sVar.a(sVar.b((short) 255, 0), (short) 0);
        short s = 109;
        int iC = sVar.c((short) 109);
        if (iC > 0) {
            chat.ola.vn.entity.j[] jVarArr = new chat.ola.vn.entity.j[iC];
            int iB = sVar.b((short) 109, 0);
            int i = 0;
            while (i < iC) {
                int iA = sVar.a(s, iB);
                jVarArr[i] = new chat.ola.vn.entity.j();
                jVarArr[i].d = sVar.c(iB);
                jVarArr[i].g = sVar.b((short) 112, iB, iA);
                String strB = sVar.b((short) 7, iB, iA);
                String strB2 = sVar.b((short) 22, iB, iA);
                jVarArr[i].b = strB;
                jVarArr[i].c = strB2;
                jVarArr[i].h = sVar.a((short) 9, iB, iA, 0L);
                jVarArr[i].i = sVar.b(sVar.a((short) 23, iB, iA));
                String strB3 = sVar.b((short) 110, iB, iA);
                if (!chat.ola.vn.util.m.c(strB) && !chat.ola.vn.util.m.c(strB3)) {
                    if (strB3.toLowerCase(Locale.US).startsWith("@" + strB.toLowerCase())) {
                        length = strB.length() + 1;
                    } else if (strB3.toLowerCase(Locale.US).startsWith(strB.toLowerCase())) {
                        length = strB.length();
                    }
                    strB3 = strB3.substring(length).trim();
                }
                jVarArr[i].e = strB3;
                jVarArr[i].f = sVar.b((short) 113, iB, iA);
                String strB4 = sVar.b((short) 111, iB, iA);
                if (!chat.ola.vn.util.m.a(strB4)) {
                    jVarArr[i].a = chat.ola.vn.util.o.a(strB4, ciVar.f);
                }
                i++;
                iB = iA;
                s = 109;
            }
            gVar.a(jVarArr, sVar.a(sVar.b((short) 124, 0), 0), sA);
        }
    }
}
