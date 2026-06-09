package chat.ola.vn.w;

/* JADX INFO: loaded from: classes.dex */
class ax implements bb {
    ax() {
    }

    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        int i = -1;
        short sA = sVar.a(sVar.b((short) 45, 0), (short) -1);
        long jA = sVar.a(sVar.b((short) 9, 0), 0L);
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
        }
        Short shValueOf = null;
        if (sA >= 0) {
            shValueOf = Short.valueOf(sA);
            ciVar.o = sA;
        }
        ciVar.n = i;
        gVar.a(shValueOf, i);
    }
}
