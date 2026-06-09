package bolts;

import java.io.Closeable;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.concurrent.ScheduledFuture;

/* JADX INFO: loaded from: classes.dex */
public class g implements Closeable {
    private final Object a;
    private final List<f> b;
    private ScheduledFuture<?> c;
    private boolean d;
    private boolean e;

    private void b() {
        if (this.e) {
            throw new IllegalStateException("Object already closed");
        }
    }

    private void c() {
        if (this.c != null) {
            this.c.cancel(true);
            this.c = null;
        }
    }

    void a(f fVar) {
        synchronized (this.a) {
            b();
            this.b.remove(fVar);
        }
    }

    public boolean a() {
        boolean z;
        synchronized (this.a) {
            b();
            z = this.d;
        }
        return z;
    }

    @Override // java.io.Closeable, java.lang.AutoCloseable
    public void close() {
        synchronized (this.a) {
            if (this.e) {
                return;
            }
            c();
            Iterator<f> it2 = this.b.iterator();
            while (it2.hasNext()) {
                it2.next().close();
            }
            this.b.clear();
            this.e = true;
        }
    }

    public String toString() {
        return String.format(Locale.US, "%s@%s[cancellationRequested=%s]", getClass().getName(), Integer.toHexString(hashCode()), Boolean.toString(a()));
    }
}
