package bolts;

import java.io.Closeable;

/* JADX INFO: loaded from: classes.dex */
public class f implements Closeable {
    private final Object a;
    private g b;
    private Runnable c;
    private boolean d;

    @Override // java.io.Closeable, java.lang.AutoCloseable
    public void close() {
        synchronized (this.a) {
            if (this.d) {
                return;
            }
            this.d = true;
            this.b.a(this);
            this.b = null;
            this.c = null;
        }
    }
}
