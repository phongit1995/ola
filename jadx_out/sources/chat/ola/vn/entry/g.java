package chat.ola.vn.entry;

/* JADX INFO: loaded from: classes.dex */
public class g {
    private String a;
    private String b;
    private String c;
    private long e;
    private long f = System.currentTimeMillis();
    private long d = System.currentTimeMillis();

    public g(String str, String str2) {
        this.a = str;
        this.b = str2;
    }

    public String a() {
        return this.a;
    }

    public void a(long j) {
        this.d = j;
    }

    public void a(String str) {
        this.b = str;
    }

    public String b() {
        return this.b == null ? this.a : this.b;
    }

    public void b(long j) {
        this.e = j;
    }

    public void b(String str) {
        this.c = str;
    }

    public long c() {
        return this.d;
    }

    public void c(long j) {
        this.f = j;
    }

    public long d() {
        return this.e;
    }

    public String e() {
        return this.c;
    }

    public boolean equals(Object obj) {
        return obj.toString().equals(toString());
    }

    public long f() {
        return this.f;
    }

    public String toString() {
        return this.b + ": " + this.a;
    }
}
