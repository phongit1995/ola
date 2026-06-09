package chat.ola.vn.w;

/* JADX INFO: loaded from: classes.dex */
class dh implements chat.ola.vn.f.c, bb {
    dh() {
    }

    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        cgVar.a((short) 138, bkVar.N);
        bkVar.av = bkVar.av == 2 ? (byte) 1 : (byte) 0;
        cgVar.a((short) 139, bkVar.av);
        cgVar.a((short) 137, (byte) bkVar.ac);
        if (chat.ola.vn.util.m.a(bkVar.A)) {
            return;
        }
        cgVar.a((short) 110, bkVar.A);
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        char c;
        String str;
        String strB = sVar.b((short) 138);
        int i = 0;
        short sA = sVar.a(sVar.b((short) 139, 0), (short) 0);
        if (sA == 0) {
            c = 0;
        } else if (sA != 1) {
            return;
        } else {
            c = 2;
        }
        String strB2 = sVar.b((short) 7);
        String strB3 = sVar.b((short) 110);
        String strB4 = sVar.b((short) 111);
        String strB5 = sVar.b((short) 8);
        short sA2 = sVar.a(sVar.b((short) 220, 0), (short) 0);
        byte bA = sVar.a(sVar.b((short) 137, 0), (byte) 0);
        long jA = sVar.a(sVar.b((short) 9, 0), 0L);
        long jA2 = sVar.a(sVar.b((short) 130, 0), 0L);
        if (jA == 0) {
            jA = System.currentTimeMillis();
        }
        long j = jA;
        if (strB5 == null) {
            strB5 = "";
        }
        String[] strArrE = {strB3};
        try {
            strArrE = strB3.indexOf(44) > 0 ? chat.ola.vn.util.m.e(strB3, ",") : new String[]{strB3};
        } catch (Throwable unused) {
        }
        while (i < strArrE.length) {
            chat.ola.vn.message.d dVar = new chat.ola.vn.message.d();
            dVar.d(strB2);
            if (chat.ola.vn.util.m.b(strB5, b)) {
                strB5 = a;
            }
            dVar.f(strB5);
            dVar.b(sA2);
            dVar.a(j);
            dVar.b(j);
            dVar.h(strArrE[i]);
            dVar.a(bA);
            if (strB4 == null) {
                if (c == 0) {
                    gVar.a(strB, dVar);
                } else if (c == 2) {
                    gVar.b(strB, dVar);
                }
                str = strB2;
            } else {
                str = strB2;
                dVar.p = Long.valueOf(System.currentTimeMillis() + jA2);
                if (c == 0) {
                    gVar.a(strB, strB4, dVar);
                } else if (c == 2) {
                    gVar.b(strB, strB4, dVar);
                }
            }
            i++;
            strB2 = str;
        }
    }
}
