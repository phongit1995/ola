package chat.ola.vn.w;

import java.io.InputStream;

/* JADX INFO: Access modifiers changed from: package-private */
/* JADX INFO: loaded from: classes.dex */
public class dq implements Runnable {
    public chat.ola.vn.p.g a;
    public ce b;
    protected boolean c;
    protected ci d;

    public dq(InputStream inputStream) {
        this.c = false;
        this.b = new ce(inputStream);
        this.c = false;
    }

    private void a(s sVar) {
        if (sVar == null || this.a == null) {
            return;
        }
        try {
            bb bbVarA = ch.a().a((short) sVar.b);
            if (bbVarA == null || this.a == null) {
                return;
            }
            bbVarA.a(sVar, this.a, this.d);
        } catch (Throwable unused) {
        }
    }

    private s b() {
        if (this.b == null) {
            return null;
        }
        return this.b.a();
    }

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    public void a() {
        this.a = null;
        this.c = true;
        try {
            try {
                this.b.b();
            } catch (Throwable th) {
                th.printStackTrace();
            }
        } finally {
            this.b = null;
        }
    }

    public void a(chat.ola.vn.p.g gVar) {
        this.a = gVar;
        this.b.a(gVar);
    }

    public void a(ci ciVar) {
        this.d = ciVar;
    }

    @Override // java.lang.Runnable
    public void run() {
        s sVarB;
        this.c = false;
        while (true) {
            int i = 10;
            while (!this.c) {
                try {
                    sVarB = b();
                } catch (Throwable unused) {
                    this.c = true;
                    this.d.c(false);
                    if (this.a != null) {
                        this.a.d();
                    }
                }
                if (sVarB == null) {
                    i--;
                    if (i <= 0) {
                        this.c = true;
                        this.d.c(false);
                        if (this.a != null) {
                            this.a.d();
                        }
                    } else {
                        try {
                            Thread.sleep(500L);
                        } catch (Throwable unused2) {
                        }
                    }
                }
            }
            return;
            a(sVarB);
        }
    }
}
