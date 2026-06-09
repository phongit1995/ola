package chat.ola.vn.entity;

/* JADX INFO: loaded from: classes.dex */
public class u {
    protected f a;
    protected long g;
    protected String b = null;
    protected String c = null;
    protected String d = null;
    protected String e = null;
    protected String f = null;
    protected int h = 0;
    protected int i = 0;
    protected int j = 0;
    protected boolean k = false;

    public long a() {
        return this.g;
    }

    public void a(int i) {
        this.h = i;
    }

    public void a(long j) {
        this.g = j;
    }

    public void a(f fVar) {
        this.a = fVar;
    }

    public void a(String str) {
        this.b = str;
    }

    public void a(boolean z) {
        this.k = z;
    }

    public f b() {
        return this.a;
    }

    public void b(int i) {
        this.i = i;
    }

    public void b(String str) {
        this.c = str;
        try {
            this.d = chat.ola.vn.util.i.d(this.c, "");
        } catch (Throwable unused) {
        }
    }

    public String c() {
        return this.b;
    }

    public void c(int i) {
        this.j = i;
    }

    public void c(String str) {
        this.e = str;
    }

    public String d() {
        return this.e;
    }

    public void d(String str) {
        this.f = str;
    }

    public int e() {
        return this.h;
    }

    public int f() {
        return this.i;
    }

    public String g() {
        return this.f;
    }

    public boolean h() {
        return this.k;
    }

    public int i() {
        return this.j;
    }

    public String j() {
        return this.d;
    }
}
