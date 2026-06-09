package chat.ola.vn.entity;

import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class y {
    private String a;
    private String b;
    private String c;
    private String d;
    private String e;
    private List<String> f;
    private String g;
    private String h;
    private String i;
    private int j;
    private boolean k;
    private int l;
    private String m;
    private int n;

    public String a() {
        return this.a;
    }

    public void a(int i) {
        this.j = i;
    }

    public void a(String str) {
        this.a = str;
    }

    public void a(List<String> list) {
        this.f = list;
    }

    public void a(boolean z) {
        this.k = z;
    }

    public String b() {
        return this.b;
    }

    public void b(int i) {
        this.l = i;
    }

    public void b(String str) {
        this.b = str;
    }

    public String c() {
        return this.c;
    }

    public void c(int i) {
        this.n = i;
    }

    public void c(String str) {
        this.c = str;
    }

    public String d() {
        return this.d;
    }

    public void d(String str) {
        this.d = str;
    }

    public OlaVenueEntity e() {
        try {
            OlaVenueEntity olaVenueEntity = new OlaVenueEntity();
            olaVenueEntity.d(this.d);
            olaVenueEntity.c(this.c);
            olaVenueEntity.h(this.g);
            olaVenueEntity.g(this.i);
            olaVenueEntity.f(this.h);
            olaVenueEntity.e(this.e);
            olaVenueEntity.b(this.b);
            olaVenueEntity.a(this.j);
            olaVenueEntity.a(this.a);
            return olaVenueEntity;
        } catch (Throwable th) {
            th.printStackTrace();
            return null;
        }
    }

    public void e(String str) {
        this.h = str;
    }

    public String f() {
        return this.h;
    }

    public void f(String str) {
        this.i = str;
    }

    public String g() {
        return this.i;
    }

    public void g(String str) {
        this.e = str;
    }

    public int h() {
        return this.j;
    }

    public void h(String str) {
        this.m = str;
    }

    public String i() {
        return this.e;
    }

    public void i(String str) {
        this.g = str;
    }

    public List<String> j() {
        return this.f;
    }

    public String k() {
        return this.m;
    }

    public String l() {
        return this.g;
    }
}
