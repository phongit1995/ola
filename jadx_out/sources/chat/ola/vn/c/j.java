package chat.ola.vn.c;

import android.support.v4.util.LruCache;
import java.io.File;

/* JADX INFO: loaded from: classes.dex */
public class j extends b {
    private LruCache<String, a> b;

    public j(int i, boolean z) {
        File fileF = chat.ola.vn.d.f();
        if (fileF.exists()) {
            this.a = new File(fileF.getAbsoluteFile(), ".cached");
            if (!this.a.exists()) {
                this.a.mkdir();
            }
        }
        if (z) {
            a(i);
        } else {
            b(i);
        }
    }

    private void a(int i) {
        this.b = new LruCache<String, a>(i) { // from class: chat.ola.vn.c.j.1
            /* JADX INFO: Access modifiers changed from: protected */
            @Override // android.support.v4.util.LruCache
            /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
            public int sizeOf(String str, a aVar) {
                return chat.ola.vn.util.o.a(aVar.a);
            }

            /* JADX INFO: Access modifiers changed from: protected */
            @Override // android.support.v4.util.LruCache
            /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
            public void entryRemoved(boolean z, String str, a aVar, a aVar2) {
                try {
                    if (!z) {
                        j.this.b(aVar);
                    } else if (!aVar.e) {
                        j.this.a(aVar);
                    }
                } catch (Throwable unused) {
                }
                super.entryRemoved(z, str, aVar, aVar2);
            }
        };
    }

    private void b(int i) {
        this.b = new LruCache<String, a>(i) { // from class: chat.ola.vn.c.j.2
            /* JADX INFO: Access modifiers changed from: protected */
            @Override // android.support.v4.util.LruCache
            /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
            public void entryRemoved(boolean z, String str, a aVar, a aVar2) {
                try {
                    if (z) {
                        if (aVar.e) {
                            return;
                        }
                    } else if (aVar2 == null || chat.ola.vn.util.o.a(aVar.a) < chat.ola.vn.util.o.a(aVar2.a) || aVar.e) {
                        return;
                    }
                    j.this.a(aVar);
                } catch (Throwable unused) {
                }
            }
        };
    }

    @Override // chat.ola.vn.c.b
    public a a(String str) {
        a aVarC;
        if (str == null) {
            return null;
        }
        synchronized (this.b) {
            aVarC = this.b.get(str);
            if (aVarC == null) {
                aVarC = c(str);
            }
        }
        return aVarC;
    }

    @Override // chat.ola.vn.c.b
    public a a(String str, a aVar) {
        a aVarPut;
        if (str == null || aVar == null) {
            return null;
        }
        synchronized (this.b) {
            aVarPut = this.b.put(str, aVar);
        }
        return aVarPut;
    }

    @Override // chat.ola.vn.c.b
    public void a() {
        synchronized (this.b) {
            this.b.evictAll();
        }
    }

    @Override // chat.ola.vn.c.b
    public a b(String str) {
        a aVarRemove;
        if (str == null) {
            return null;
        }
        synchronized (this.b) {
            aVarRemove = this.b.remove(str);
        }
        return aVarRemove;
    }
}
