package chat.ola.vn.message;

import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.entity.ah;
import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
public class e {
    public static aa a(d dVar, byte b, String str) {
        aa aaVar = new aa(dVar, b);
        aaVar.a(str);
        return aaVar;
    }

    public static c a(String str, String str2) {
        d dVar = new d();
        dVar.f(OlaApplication.a(R.string.message_invite_to_chatgroup));
        dVar.d(str2);
        dVar.e(str2);
        dVar.c((short) 0);
        dVar.a(System.currentTimeMillis());
        c cVar = new c(dVar, (byte) 1);
        cVar.a(str);
        return cVar;
    }

    public static d a(d dVar, byte b) {
        return b(dVar, b);
    }

    public static j a(String str, long j) {
        return a(str, j, (byte) 1);
    }

    private static j a(String str, long j, byte b) {
        d dVar = new d();
        dVar.d(str);
        dVar.e(str);
        dVar.c((short) 0);
        dVar.a(System.currentTimeMillis());
        j jVar = new j(dVar, b);
        jVar.c(j);
        return jVar;
    }

    public static k a(d dVar, byte b, String str, String str2) {
        k kVar = new k(dVar, b);
        kVar.a(str);
        kVar.n(str2);
        return kVar;
    }

    public static s a(String str, long j, int i, ah ahVar) {
        d dVar = new d();
        dVar.d(str);
        dVar.e(str);
        dVar.c((short) 0);
        dVar.a(System.currentTimeMillis());
        s sVar = new s(dVar, (byte) 2);
        sVar.c(j);
        sVar.b(i);
        sVar.a(ahVar);
        return sVar;
    }

    public static t a(String str, String str2, short s, short s2, byte b) {
        d dVar = new d();
        dVar.d(str);
        dVar.e(str2);
        dVar.c(s);
        dVar.a(s2);
        dVar.a(System.currentTimeMillis());
        return new t(dVar, b);
    }

    public static final y a(long j) {
        d dVar = new d();
        dVar.a(j);
        return new y(dVar);
    }

    private static d b(d dVar, byte b) {
        String strTrim;
        if (dVar != null) {
            if (!chat.ola.vn.util.m.a(dVar.v())) {
                l lVar = new l(dVar, b);
                lVar.j(dVar.v());
                lVar.h(dVar.p());
                lVar.f(dVar.k());
                lVar.p = dVar.p;
                lVar.w = dVar.w;
                lVar.x = dVar.x;
                return lVar;
            }
            if (!chat.ola.vn.util.m.a(dVar.c())) {
                ab abVar = new ab(dVar, b);
                abVar.b(dVar.c());
                abVar.h(dVar.p());
                abVar.f(dVar.k());
                abVar.p = dVar.p;
                abVar.w = dVar.w;
                abVar.x = dVar.x;
                return abVar;
            }
            if (!chat.ola.vn.util.m.a(dVar.y())) {
                r rVar = new r(dVar, b);
                rVar.k(dVar.y());
                rVar.h(dVar.p());
                rVar.f(dVar.k());
                rVar.p = dVar.p;
                rVar.w = dVar.w;
                rVar.x = dVar.x;
                return rVar;
            }
            if (!chat.ola.vn.util.m.a(dVar.B())) {
                i iVar = new i(dVar, b);
                iVar.m(dVar.B());
                iVar.h(dVar.p());
                iVar.f(dVar.k());
                iVar.p = dVar.p;
                iVar.w = dVar.w;
                iVar.x = dVar.x;
                return iVar;
            }
            String strK = dVar.k();
            if (!chat.ola.vn.util.m.a(strK)) {
                ArrayList<String> arrayListB = chat.ola.vn.util.i.b((CharSequence) strK);
                if (arrayListB != null && !arrayListB.isEmpty()) {
                    ArrayList arrayList = new ArrayList(arrayListB.size());
                    String str = null;
                    for (String str2 : arrayListB) {
                        if (chat.ola.vn.entity.i.i(str2) == 1) {
                            arrayList.add(chat.ola.vn.entity.ab.b(str2));
                        } else if (str == null) {
                            str = str2;
                        }
                    }
                    if (!arrayList.isEmpty()) {
                        try {
                            chat.ola.vn.entity.ab abVar2 = (chat.ola.vn.entity.ab) arrayList.get(0);
                            if (chat.ola.vn.entity.w.b(abVar2.c)) {
                                w wVar = new w(dVar, b);
                                wVar.f(null);
                                wVar.a(dVar.m());
                                wVar.h(dVar.p());
                                wVar.a(dVar.q());
                                wVar.b(dVar.t());
                                wVar.b(dVar.o());
                                chat.ola.vn.entity.w wVar2 = new chat.ola.vn.entity.w();
                                wVar2.a(abVar2.c);
                                wVar.a(wVar2);
                                wVar.a(dVar.u());
                                wVar.p = dVar.p;
                                wVar.w = dVar.w;
                                wVar.x = dVar.x;
                                return wVar;
                            }
                        } catch (Throwable unused) {
                        }
                        p pVar = new p(dVar, b);
                        pVar.f(strK);
                        pVar.a(dVar.m());
                        pVar.h(dVar.p());
                        pVar.a(dVar.q());
                        pVar.b(dVar.t());
                        pVar.b(dVar.o());
                        pVar.b(arrayList);
                        pVar.a(dVar.u());
                        pVar.p = dVar.p;
                        pVar.w = dVar.w;
                        pVar.x = dVar.x;
                        return pVar;
                    }
                    if (str != null) {
                        if (chat.ola.vn.entity.i.i(str) == 3) {
                            aa aaVar = new aa(dVar, b);
                            aaVar.f(null);
                            aaVar.a(dVar.m());
                            aaVar.h(dVar.p());
                            aaVar.a(dVar.q());
                            aaVar.b(dVar.t());
                            aaVar.b(dVar.o());
                            aaVar.n(str);
                            aaVar.a(dVar.u());
                            aaVar.p = dVar.p;
                            aaVar.w = dVar.w;
                            aaVar.x = dVar.x;
                            return aaVar;
                        }
                        if (chat.ola.vn.entity.i.i(str) == 2) {
                            z zVar = new z(dVar, b);
                            zVar.f(null);
                            zVar.a(dVar.m());
                            zVar.h(dVar.p());
                            zVar.a(dVar.q());
                            zVar.b(dVar.t());
                            zVar.b(dVar.o());
                            zVar.a(str);
                            zVar.a(dVar.u());
                            zVar.p = dVar.p;
                            zVar.w = dVar.w;
                            zVar.x = dVar.x;
                            return zVar;
                        }
                    }
                }
                try {
                    strTrim = strK.trim();
                } catch (Throwable unused2) {
                    strTrim = strK;
                }
                if (!chat.ola.vn.util.m.a(strTrim, "(Y)") && !chat.ola.vn.util.m.b(strTrim, ":-*") && !chat.ola.vn.util.m.b(strTrim, ":*") && !chat.ola.vn.util.m.b(strTrim, "💋")) {
                    x xVar = new x(dVar, b);
                    xVar.f(strK);
                    xVar.b(dVar.o());
                    xVar.a(dVar.m());
                    xVar.h(dVar.p());
                    xVar.p = dVar.p;
                    xVar.w = dVar.w;
                    xVar.x = dVar.x;
                    return xVar;
                }
                w wVar3 = new w(dVar, b);
                wVar3.f(null);
                wVar3.a(dVar.m());
                wVar3.h(dVar.p());
                wVar3.a(dVar.q());
                wVar3.b(dVar.t());
                wVar3.b(dVar.o());
                chat.ola.vn.entity.w wVar4 = new chat.ola.vn.entity.w();
                wVar4.a(strTrim);
                wVar3.a(wVar4);
                wVar3.a(dVar.u());
                wVar3.p = dVar.p;
                wVar3.w = dVar.w;
                wVar3.x = dVar.x;
                return wVar3;
            }
            if (dVar.o() > 0) {
                w wVar5 = new w(dVar, b);
                wVar5.f(null);
                wVar5.a(dVar.m());
                wVar5.h(dVar.p());
                wVar5.a(dVar.q());
                wVar5.b(dVar.t());
                wVar5.b(dVar.o());
                chat.ola.vn.entity.w wVar6 = new chat.ola.vn.entity.w();
                wVar6.a(dVar.o());
                wVar5.a(wVar6);
                wVar5.a(dVar.u());
                wVar5.p = dVar.p;
                wVar5.w = dVar.w;
                wVar5.x = dVar.x;
                return wVar5;
            }
        }
        return null;
    }

    public static j b(String str, long j) {
        return a(str, j, (byte) 2);
    }

    public static q b(String str, long j, int i, ah ahVar) {
        d dVar = new d();
        dVar.d(str);
        dVar.e(str);
        dVar.c((short) 0);
        dVar.a(System.currentTimeMillis());
        q qVar = new q(dVar, (byte) 1);
        qVar.c(j);
        qVar.b(i);
        qVar.a(ahVar);
        return qVar;
    }
}
