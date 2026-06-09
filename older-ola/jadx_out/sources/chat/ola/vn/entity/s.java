package chat.ola.vn.entity;

/* JADX INFO: loaded from: classes.dex */
public class s {
    public k a;
    public long b;
    private byte c;
    private long d;
    private String e;
    private String f;
    private boolean g;
    private String h;
    private long i;

    public s() {
        this.b = 0L;
        this.c = (byte) 0;
        this.d = 0L;
        this.e = null;
    }

    public s(byte b) {
        this.b = 0L;
        this.c = (byte) 0;
        this.d = 0L;
        this.e = null;
        this.c = b;
    }

    public s(long j, String str) {
        this.b = 0L;
        this.c = (byte) 0;
        this.d = j;
        this.e = str;
    }

    public long a() {
        return this.i;
    }

    public void a(byte b) {
        this.c = b;
    }

    public void a(long j) {
        this.i = j;
    }

    public void a(String str) {
        this.e = str;
    }

    public void b(String str) {
        String[] strArrE;
        if (chat.ola.vn.util.m.c(str) || (strArrE = chat.ola.vn.util.m.e(str, ";")) == null) {
            return;
        }
        for (String str2 : strArrE) {
            if (chat.ola.vn.util.m.b(str2, "gps")) {
                this.g = true;
                return;
            }
        }
    }

    public boolean b() {
        return this.d > 0;
    }

    public long c() {
        return this.d;
    }

    public void c(String str) {
        this.f = str;
    }

    public String d() {
        return this.e;
    }

    public void d(String str) {
        this.h = str;
    }

    public boolean e() {
        return this.g;
    }

    public String f() {
        return this.f;
    }

    public String g() {
        return this.h;
    }

    public byte h() {
        return this.c;
    }

    public String toString() {
        return "[Room Id: ]" + this.d + " [Room Name: ]" + this.e;
    }
}
