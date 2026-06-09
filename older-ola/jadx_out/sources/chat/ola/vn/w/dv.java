package chat.ola.vn.w;

import android.annotation.SuppressLint;

/* JADX INFO: loaded from: classes.dex */
@SuppressLint({"DefaultLocale"})
class dv implements bb {
    private String e = null;

    dv() {
    }

    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        this.e = bkVar.f;
        cgVar.a((short) 2, bkVar.e.toLowerCase());
        cgVar.a((short) 43, bkVar.am);
        if (!chat.ola.vn.util.m.a(bkVar.i)) {
            cgVar.a((short) 22, bkVar.i);
        }
        if (bkVar.j != null) {
            cgVar.a((short) 4, bkVar.j);
        }
        if (bkVar.O != null) {
            cgVar.a((short) 58, bkVar.O.longValue());
        }
        if (bkVar.k != null) {
            cgVar.a((short) 5, bkVar.k);
        }
        if (bkVar.ar >= 0) {
            cgVar.a((short) 88, bkVar.ar);
        }
        if (bkVar.d != null) {
            cgVar.a((short) 142, bkVar.d);
        }
        if (bkVar.z != null) {
            cgVar.a((short) 109, bkVar.z);
        }
        if (bkVar.aj != 0) {
            cgVar.a((short) 255, (byte) bkVar.aj);
        }
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        gVar.a(ciVar.f, this.e, sVar.a(sVar.b((short) 255, 0), (short) 0));
    }
}
