package chat.ola.vn.entity;

import chat.ola.vn.OlaApplication;

/* JADX INFO: loaded from: classes.dex */
public abstract class m<T> {
    public long a;
    public boolean b;

    public m(long j) {
        this.b = true;
        this.a = j;
        this.b = true;
    }

    public abstract T a(byte[] bArr);

    public abstract String a();

    public abstract void a(T t);

    public final void a(final String str) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.entity.m.2
            @Override // java.lang.Runnable
            public void run() {
                m.this.b(str);
            }
        });
    }

    public final void a(byte[] bArr, String str) {
        final T tA = a(bArr);
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.entity.m.1
            /* JADX WARN: Multi-variable type inference failed */
            @Override // java.lang.Runnable
            public void run() {
                m.this.a(tA);
            }
        });
    }

    public abstract void b(String str);
}
