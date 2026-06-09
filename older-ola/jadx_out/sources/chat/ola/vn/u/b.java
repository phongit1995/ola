package chat.ola.vn.u;

import android.annotation.SuppressLint;
import chat.ola.vn.OlaApplication;
import java.io.File;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
@SuppressLint({"DefaultLocale"})
public class b {
    private static b a;

    private b() {
    }

    public static b a() {
        if (a == null) {
            a = new b();
        }
        return a;
    }

    @SuppressLint({"DefaultLocale"})
    private void a(p pVar) {
        String strA = pVar.a();
        try {
            File file = new File(strA);
            if (!file.exists()) {
                if (pVar.c() != null) {
                    pVar.c().b(strA, null);
                    return;
                }
                return;
            }
            long length = file.length();
            String strB = com.mg.ola.common.d.d.b(strA);
            pVar.b = strB.startsWith("Ocam") ? true ^ chat.ola.vn.util.o.b(strB, length) : true;
            try {
                new m().a(pVar);
            } catch (Throwable th) {
                th.printStackTrace();
            }
        } catch (Throwable th2) {
            th2.printStackTrace();
            if (pVar.c() != null) {
                pVar.c().b(strA, null);
            }
        }
    }

    public p a(String str, String str2, o oVar) {
        return a(str, null, str2, oVar);
    }

    public p a(String str, String str2, String str3, final o oVar) {
        String strF;
        if (chat.ola.vn.util.m.a(str)) {
            return null;
        }
        try {
            strF = chat.ola.vn.d.f(str);
        } catch (Throwable th) {
            th.printStackTrace();
        }
        if (chat.ola.vn.util.m.a(strF)) {
            if (chat.ola.vn.util.m.a(str2)) {
                str2 = chat.ola.vn.util.o.f(str);
            }
            if (chat.ola.vn.util.m.a(str2)) {
                str2 = "jpg";
            }
            p pVarA = p.a(str, str2, str3, oVar);
            a(pVarA);
            return pVarA;
        }
        final chat.ola.vn.entity.i iVar = new chat.ola.vn.entity.i();
        iVar.a(strF);
        if (iVar.f() != 0) {
            if (oVar != null) {
                OlaApplication.a(new Runnable() { // from class: chat.ola.vn.u.b.1
                    @Override // java.lang.Runnable
                    public void run() {
                        try {
                            oVar.a(iVar);
                        } catch (Throwable unused) {
                        }
                    }
                });
            }
            return p.a(str, iVar.i(), str3, oVar);
        }
        return null;
    }

    public void a(List<p> list) {
        try {
            for (p pVar : list) {
                try {
                    if (pVar.a != null) {
                        pVar.a.a(true);
                    }
                } catch (Throwable th) {
                    th.printStackTrace();
                }
            }
        } catch (Throwable th2) {
            th2.printStackTrace();
        }
    }

    public void b() {
    }
}
