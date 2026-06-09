package chat.ola.vn.entity;

import java.io.Serializable;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class OlaVenueEntity implements Serializable {
    private static final long serialVersionUID = 1;
    private String a;
    private String b;
    private String c;
    private String d;
    private String e;
    private String f;
    private String g;
    private String h;
    private String i;
    private int j;
    private long k;
    private long l = 0;

    public JSONObject a() {
        try {
            if (this.b == null) {
                return null;
            }
            JSONObject jSONObject = new JSONObject();
            jSONObject.put("venueId", this.b);
            jSONObject.put("timeStamp", this.l);
            return jSONObject;
        } catch (Throwable unused) {
            return null;
        }
    }

    public void a(int i) {
        this.j = i;
    }

    public void a(long j) {
        this.k = j;
    }

    public void a(String str) {
        this.b = str;
    }

    public String b() {
        return this.b;
    }

    public void b(long j) {
        this.l = j;
    }

    public void b(String str) {
        this.c = str;
    }

    public String c() {
        return this.c;
    }

    public void c(String str) {
        this.d = str;
    }

    public String d() {
        return this.d;
    }

    public void d(String str) {
        this.e = str;
    }

    public String e() {
        return this.e;
    }

    public void e(String str) {
        this.f = str;
    }

    public String f() {
        return this.f;
    }

    public void f(String str) {
        this.g = str;
    }

    public OlaVenueEntity g() {
        try {
            OlaVenueEntity olaVenueEntity = new OlaVenueEntity();
            olaVenueEntity.b = this.b;
            olaVenueEntity.e = this.e;
            olaVenueEntity.d = this.d;
            olaVenueEntity.f = this.f;
            olaVenueEntity.c = this.c;
            olaVenueEntity.g = this.g;
            olaVenueEntity.h = this.h;
            olaVenueEntity.i = this.i;
            olaVenueEntity.j = this.j;
            olaVenueEntity.k = this.k;
            return olaVenueEntity;
        } catch (Throwable th) {
            th.printStackTrace();
            return null;
        }
    }

    public void g(String str) {
        this.h = str;
    }

    public String h() {
        return this.i;
    }

    public void h(String str) {
        this.i = str;
    }

    public int i() {
        return this.j;
    }

    public void i(String str) {
        this.a = str;
    }

    public String j() {
        return this.a;
    }

    public long k() {
        return this.l;
    }

    public String toString() {
        try {
            return "[ID: " + this.b + "] [NAME: " + this.c + "] [DESCRIPTION: " + this.d + "] [MEDIA: " + this.f + "] [ADDRESS: " + this.e + "]";
        } catch (Throwable unused) {
            return super.toString();
        }
    }
}
