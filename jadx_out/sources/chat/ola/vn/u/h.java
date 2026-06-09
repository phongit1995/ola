package chat.ola.vn.u;

import chat.ola.vn.w.ce;
import chat.ola.vn.w.s;
import java.io.InputStream;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
class h implements Runnable {
    public ce a;
    protected boolean b;
    private List<g> c;
    private d d;

    public h(InputStream inputStream, d dVar) {
        this.b = false;
        this.a = new ce(inputStream);
        this.b = false;
        this.d = dVar;
    }

    private void a(s sVar) {
        if (sVar == null || this.c == null) {
            return;
        }
        try {
            a aVarA = k.a((short) sVar.b);
            if (aVarA != null) {
                synchronized (this.c) {
                    aVarA.a(sVar, this.c);
                }
            }
        } catch (Throwable unused) {
        }
    }

    private s b() {
        if (this.a == null) {
            return null;
        }
        return this.a.a();
    }

    public void a() {
        this.c = null;
        this.b = true;
        try {
            this.a.b();
        } catch (Throwable th) {
            this.a = null;
            throw th;
        }
        this.a = null;
        this.d = null;
    }

    public void a(List<g> list) {
        this.c = list;
    }

    @Override // java.lang.Runnable
    public void run() {
        s sVarB;
        try {
            this.b = false;
            while (true) {
                int i = 5;
                while (!this.b) {
                    try {
                        sVarB = b();
                    } catch (Throwable unused) {
                        this.b = true;
                        this.d.b();
                    }
                    if (sVarB == null) {
                        i--;
                        if (i < 0) {
                            this.b = true;
                        }
                        try {
                            Thread.sleep(1000L);
                        } catch (Throwable unused2) {
                        }
                    }
                    this.d.a();
                    a(sVarB);
                }
                return;
            }
        } catch (Throwable unused3) {
        }
    }
}
