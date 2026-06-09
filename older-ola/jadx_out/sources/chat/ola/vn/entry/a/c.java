package chat.ola.vn.entry.a;

import android.content.Context;

/* JADX INFO: loaded from: classes.dex */
public class c<T> {
    protected short a;
    protected String b;
    protected String c;
    protected T d;
    protected a e;
    private short f;

    public interface a {
        void a(c cVar, Object obj);
    }

    public c(short s, short s2, String str, String str2, T t) {
        this.a = s;
        this.f = s2;
        this.b = str;
        this.c = str2;
        this.d = t;
    }

    public c<T> a(a aVar) {
        this.e = aVar;
        return this;
    }

    public short a() {
        return this.a;
    }

    public boolean a(Context context) {
        return false;
    }

    public String b() {
        return this.b;
    }

    public String c() {
        return this.c;
    }

    public short d() {
        return this.f;
    }

    public T e() {
        return this.d;
    }
}
