package chat.ola.vn.pickercontacts;

import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class c {
    public static short a = 0;
    public static short b = 1;
    public static short c = 2;
    private String e;
    private List<String> f;
    private String g;
    private boolean h;
    private long d = -1;
    private short i = b;

    public String a() {
        return this.e;
    }

    public void a(long j) {
        this.d = j;
    }

    public void a(c cVar) {
        this.d = cVar.c();
        this.e = cVar.a();
        this.f = new ArrayList(cVar.b());
        this.i = cVar.d();
        this.h = cVar.g();
        this.g = cVar.e();
    }

    public void a(String str) {
        this.e = str;
    }

    public void a(List<String> list) {
        this.f = list;
    }

    public void a(short s) {
        this.i = s;
    }

    public List<String> b() {
        return this.f;
    }

    public void b(String str) {
        this.g = str;
    }

    public long c() {
        return this.d;
    }

    public short d() {
        return this.i;
    }

    public String e() {
        return this.g;
    }

    public String f() {
        try {
            return this.g != null ? this.g : this.f.get(0);
        } catch (Throwable th) {
            th.printStackTrace();
            return null;
        }
    }

    public boolean g() {
        return this.h;
    }
}
