package chat.ola.vn.s;

import android.os.FileObserver;
import chat.ola.vn.util.m;
import java.io.File;

/* JADX INFO: loaded from: classes.dex */
public class a extends FileObserver {
    private b a;
    private boolean b;
    private String c;

    public a(String str) {
        super(str, 256);
        this.b = false;
        this.c = null;
        this.c = str;
        if (this.c.endsWith("/")) {
            return;
        }
        this.c += "/";
    }

    public void a(b bVar) {
        this.a = bVar;
    }

    @Override // android.os.FileObserver
    public void onEvent(int i, String str) {
        if (!m.a(this.c)) {
            str = this.c + str;
        }
        if (i != 64) {
            if (i == 256) {
                if (!this.b) {
                    if (this.a != null) {
                        this.a.A(str);
                        return;
                    }
                    return;
                }
                try {
                    if (new File(str).delete() || this.a == null) {
                        return;
                    }
                    this.a.A(str);
                    return;
                } catch (Throwable th) {
                    th.printStackTrace();
                    if (this.a != null) {
                        this.a.A(str);
                        return;
                    }
                    return;
                }
            }
            if (i != 512) {
                return;
            }
        }
        if (this.a != null) {
            this.a.B(str);
        }
    }
}
