package chat.ola.vn.entry;

import chat.ola.vn.entity.k;
import chat.ola.vn.entity.t;

/* JADX INFO: loaded from: classes.dex */
public class c {
    public k a = null;
    private short b;
    private CharSequence c;
    private CharSequence d;
    private t e;
    private int f;
    private String g;
    private String h;
    private int i;

    public c(short s, CharSequence charSequence) {
        this.b = s;
        this.c = charSequence;
    }

    public int a() {
        return this.f;
    }

    public c a(t tVar) {
        this.e = tVar;
        return this;
    }

    public void a(int i) {
        this.f = i;
    }

    public void a(String str) {
        this.g = str;
    }

    public t b() {
        return this.e;
    }

    public void b(int i) {
        this.i = i;
    }

    public void b(String str) {
        this.h = str;
    }

    public short c() {
        return this.b;
    }

    public CharSequence d() {
        return this.c;
    }

    public CharSequence e() {
        return this.d;
    }

    public String f() {
        return this.g;
    }

    public String g() {
        return this.h;
    }
}
