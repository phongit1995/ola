package chat.ola.vn.entity;

import java.io.Serializable;

/* JADX INFO: loaded from: classes.dex */
public class OlaCheckInItemEntity implements Serializable {
    private long a;
    private String b;
    private String c;
    private String d;
    private String e;
    private String f;
    private String g;
    private String h;

    public String a() {
        return this.e;
    }

    public void a(long j) {
        this.a = j;
    }

    public void a(OlaCheckInItemEntity olaCheckInItemEntity) {
        this.e = olaCheckInItemEntity.a();
        this.h = olaCheckInItemEntity.b();
        this.a = olaCheckInItemEntity.c();
        this.b = olaCheckInItemEntity.d();
        this.c = olaCheckInItemEntity.e();
        this.d = olaCheckInItemEntity.f();
        this.g = olaCheckInItemEntity.h();
    }

    public void a(String str) {
        this.e = str;
    }

    public String b() {
        return this.h;
    }

    public void b(String str) {
        this.h = str;
    }

    public long c() {
        return this.a;
    }

    public void c(String str) {
        this.b = str;
    }

    public String d() {
        return this.b;
    }

    public void d(String str) {
        this.c = str;
    }

    public String e() {
        return this.c;
    }

    public void e(String str) {
        this.d = str;
    }

    public String f() {
        return this.d;
    }

    public void f(String str) {
        this.g = str;
    }

    public String g() {
        return this.f;
    }

    public String h() {
        return this.g;
    }
}
