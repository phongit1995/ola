package chat.ola.vn.entity;

import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class o {
    private String a;
    private String b;
    private OlaCheckInActionEntity c;
    private List<OlaCheckInItemEntity> d;
    private OlaVenueEntity e;
    private long f;
    private CharSequence g;

    public String a() {
        return this.a;
    }

    public void a(long j) {
        this.f = j;
    }

    public void a(OlaCheckInActionEntity olaCheckInActionEntity) {
        this.c = olaCheckInActionEntity;
    }

    public void a(OlaVenueEntity olaVenueEntity) {
        this.e = olaVenueEntity;
    }

    public void a(CharSequence charSequence) {
        this.g = charSequence;
    }

    public void a(String str) {
        this.a = str;
    }

    public void a(List<OlaCheckInItemEntity> list) {
        this.d = list;
    }

    public OlaCheckInActionEntity b() {
        return this.c;
    }

    public void b(String str) {
        this.b = str;
    }

    public List<OlaCheckInItemEntity> c() {
        return this.d;
    }

    public OlaVenueEntity d() {
        return this.e;
    }

    public CharSequence e() {
        return this.g;
    }
}
