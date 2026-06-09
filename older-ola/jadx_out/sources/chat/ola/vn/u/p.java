package chat.ola.vn.u;

import android.annotation.SuppressLint;

/* JADX INFO: loaded from: classes.dex */
@SuppressLint({"DefaultLocale"})
public class p {
    m a;
    boolean b = true;
    private byte[] c;
    private String d;
    private String e;
    private String f;
    private String g;
    private o h;

    private p() {
    }

    public static p a(String str, String str2, String str3, o oVar) {
        p pVar = new p();
        pVar.d = str;
        pVar.f = str2;
        pVar.g = str3;
        pVar.h = oVar;
        return pVar;
    }

    public String a() {
        return this.d;
    }

    public void a(byte[] bArr) {
        this.c = bArr;
    }

    public byte[] b() {
        return this.c;
    }

    public o c() {
        return this.h;
    }

    public String d() {
        try {
            return this.f.toLowerCase();
        } catch (Throwable unused) {
            return this.f;
        }
    }

    public String e() {
        return this.e;
    }
}
