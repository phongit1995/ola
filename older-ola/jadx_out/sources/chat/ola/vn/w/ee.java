package chat.ola.vn.w;

import android.annotation.SuppressLint;
import chat.ola.vn.OlaApplication;
import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
@SuppressLint({"DefaultLocale"})
class ee implements bb {
    private String e = null;
    private long f;
    private chat.ola.vn.e.c g;

    ee() {
    }

    private chat.ola.vn.entity.g a(String str) {
        try {
            if (chat.ola.vn.util.m.b(str, chat.ola.vn.h.a())) {
                return null;
            }
            if (chat.ola.vn.util.m.a(str) && chat.ola.vn.h.H > 0) {
                return null;
            }
            chat.ola.vn.r.a.e eVar = chat.ola.vn.h.u;
            if ((!chat.ola.vn.util.m.a(str) && !chat.ola.vn.util.m.b(str, chat.ola.vn.h.a()) && !chat.ola.vn.util.m.b(str, "av") && !chat.ola.vn.util.m.b(str, "md") && !chat.ola.vn.util.m.b(str, "lk") && !chat.ola.vn.util.m.b(str, "#ola") && !chat.ola.vn.util.m.b(str, "#apk") && !chat.ola.vn.util.m.b(str, "#hai") && !chat.ola.vn.util.m.b(str, "me") && !chat.ola.vn.util.m.b(str, "rs")) || !eVar.w() || !chat.ola.vn.util.a.c) {
                return null;
            }
            chat.ola.vn.entity.g gVar = new chat.ola.vn.entity.g();
            gVar.d((short) 5);
            return gVar;
        } catch (Throwable unused) {
        }
        return null;
    }

    private chat.ola.vn.entity.g b(String str) {
        if (!chat.ola.vn.h.t.C()) {
            if (System.currentTimeMillis() - chat.ola.vn.r.a.e.c >= 300000) {
                chat.ola.vn.r.a.e.b = 0;
                chat.ola.vn.r.a.e.a = null;
                chat.ola.vn.r.a.e.c = System.currentTimeMillis();
                OlaApplication.b.d((String) null, (short) 0);
            }
            return null;
        }
        if (!chat.ola.vn.h.u.x()) {
            return null;
        }
        if (chat.ola.vn.util.m.a(str) || chat.ola.vn.util.m.b(str, chat.ola.vn.h.a()) || chat.ola.vn.util.m.b(str, "av") || chat.ola.vn.util.m.b(str, "md") || chat.ola.vn.util.m.b(str, "lk") || chat.ola.vn.util.m.b(str, "#ola") || chat.ola.vn.util.m.b(str, "#apk") || chat.ola.vn.util.m.b(str, "#hai") || chat.ola.vn.util.m.b(str, "me") || chat.ola.vn.util.m.b(str, "rs")) {
            chat.ola.vn.entity.g gVar = new chat.ola.vn.entity.g();
            gVar.d((short) 9);
            if (chat.ola.vn.h.t.A() > 100) {
                int iA = chat.ola.vn.h.t.A() - chat.ola.vn.r.a.e.b;
                if (iA > 100) {
                    iA = 100;
                }
                ArrayList arrayList = new ArrayList();
                for (int i = 0; i < iA; i++) {
                    arrayList.add(chat.ola.vn.h.t.f(chat.ola.vn.r.a.e.b));
                    chat.ola.vn.r.a.e.b++;
                }
                if (chat.ola.vn.r.a.e.b >= chat.ola.vn.h.t.A()) {
                    chat.ola.vn.r.a.e.b = 0;
                    OlaApplication.b.d((String) null, (short) 0);
                }
                gVar.d = arrayList;
            } else {
                gVar.d = new ArrayList(chat.ola.vn.h.t.y());
                chat.ola.vn.r.a.e.b = 0;
                OlaApplication.b.d((String) null, (short) 0);
            }
            chat.ola.vn.entry.b.aa.l = true;
            gVar.a(0L);
            return gVar;
        }
        return null;
    }

    private void b(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        short sA = sVar.a(sVar.b((short) 255, 0), (short) 0);
        long jA = sVar.a(sVar.b((short) 72, 0), 0L);
        String strB = sVar.b((short) 109);
        int iA = sVar.a(sVar.b((short) 124, 0), 0);
        if (chat.ola.vn.util.m.b(strB, "refresh")) {
            gVar.a(jA, iA, sA);
        } else if (iA > 0) {
            gVar.b(jA, iA, sA);
        }
    }

    /* JADX WARN: Removed duplicated region for block: B:120:0x02e1 A[Catch: Throwable -> 0x0337, TryCatch #29 {Throwable -> 0x0337, blocks: (B:118:0x02d9, B:120:0x02e1, B:122:0x02e9), top: B:387:0x02d9 }] */
    /* JADX WARN: Removed duplicated region for block: B:121:0x02e8  */
    /* JADX WARN: Removed duplicated region for block: B:126:0x0316  */
    /* JADX WARN: Removed duplicated region for block: B:206:0x05cf  */
    /* JADX WARN: Removed duplicated region for block: B:207:0x05d8  */
    /* JADX WARN: Removed duplicated region for block: B:229:0x0637 A[Catch: Throwable -> 0x0671, TryCatch #26 {Throwable -> 0x0671, blocks: (B:223:0x061d, B:229:0x0637, B:231:0x0641, B:232:0x0649, B:234:0x0653), top: B:381:0x061d }] */
    /* JADX WARN: Removed duplicated region for block: B:241:0x0671 A[PHI: r71
      0x0671: PHI (r71v3 java.lang.String) = 
      (r71v2 java.lang.String)
      (r71v5 java.lang.String)
      (r71v5 java.lang.String)
      (r71v5 java.lang.String)
      (r71v6 java.lang.String)
     binds: [B:242:0x0674, B:228:0x0635, B:233:0x0651, B:231:0x0641, B:307:0x0671] A[DONT_GENERATE, DONT_INLINE]] */
    /* JADX WARN: Removed duplicated region for block: B:243:0x0677  */
    /* JADX WARN: Removed duplicated region for block: B:245:0x067f A[Catch: Throwable -> 0x06af, TRY_LEAVE, TryCatch #24 {Throwable -> 0x06af, blocks: (B:236:0x0659, B:238:0x0663, B:240:0x0669, B:245:0x067f), top: B:377:0x0659 }] */
    /* JADX WARN: Removed duplicated region for block: B:251:0x06b5  */
    /* JADX WARN: Removed duplicated region for block: B:335:0x0543 A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Removed duplicated region for block: B:365:0x02f1 A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private void c(chat.ola.vn.w.s r76, chat.ola.vn.p.g r77, chat.ola.vn.w.ci r78) {
        /*
            Method dump skipped, instruction units count: 2010
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.w.ee.c(chat.ola.vn.w.s, chat.ola.vn.p.g, chat.ola.vn.w.ci):void");
    }

    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        String str = bkVar.p;
        if (!chat.ola.vn.util.m.a(str)) {
            cgVar.a((short) 7, str.toLowerCase());
        }
        this.f = bkVar.S;
        if (0 != this.f) {
            cgVar.a((short) 72, this.f);
        }
        if (bkVar.at != 0) {
            cgVar.a((short) 115, bkVar.at);
        } else {
            this.e = str;
        }
        if (bkVar.aj != 0) {
            cgVar.a((short) 255, (byte) bkVar.aj);
        }
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        switch (sVar.a(sVar.b((short) 115, 0), (byte) 0)) {
            case 0:
                c(sVar, gVar, ciVar);
                break;
            case 1:
                b(sVar, gVar, ciVar);
                break;
        }
    }
}
