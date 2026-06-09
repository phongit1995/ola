package chat.ola.vn.entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class OlaCheckInActionEntity implements Serializable {
    private String a;
    private String b;
    private String c;
    private String d;
    private boolean e = true;
    private List<OlaCheckInItemEntity> f;
    private List<String> g;

    public String a() {
        return this.a;
    }

    public void a(OlaCheckInActionEntity olaCheckInActionEntity) {
        if (olaCheckInActionEntity != null) {
            this.a = olaCheckInActionEntity.a;
            this.b = olaCheckInActionEntity.b;
            this.c = olaCheckInActionEntity.c;
            this.d = olaCheckInActionEntity.d;
            this.e = olaCheckInActionEntity.e;
            if (olaCheckInActionEntity.f != null) {
                this.f = new ArrayList(olaCheckInActionEntity.f);
            }
            if (olaCheckInActionEntity.g != null) {
                this.g = new ArrayList(olaCheckInActionEntity.g);
            }
        }
    }

    public void a(String str) {
        this.a = str;
    }

    public void a(List<OlaCheckInItemEntity> list) {
        this.f = list;
    }

    public void a(boolean z) {
        this.e = z;
    }

    public String b() {
        return this.b;
    }

    public void b(String str) {
        this.b = str;
    }

    public void b(List<String> list) {
        this.g = list;
    }

    public String c() {
        return this.c;
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

    public boolean e() {
        return this.e;
    }

    public List<OlaCheckInItemEntity> f() {
        return this.f;
    }
}
