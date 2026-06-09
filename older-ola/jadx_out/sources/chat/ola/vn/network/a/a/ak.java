package chat.ola.vn.network.a.a;

import chat.ola.vn.OlaApplication;

/* JADX INFO: loaded from: classes.dex */
public class ak extends chat.ola.vn.entity.m<Void> {
    private String c;

    public ak(long j) {
        super(j);
        this.c = null;
        this.c = chat.ola.vn.h.f();
    }

    @Override // chat.ola.vn.entity.m
    public String a() {
        return chat.ola.vn.util.http.a.a(this.c, "id/signoutall", true);
    }

    @Override // chat.ola.vn.entity.m
    public void a(Void r1) {
        try {
            OlaApplication.b.k();
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.entity.m
    /* JADX INFO: renamed from: b, reason: merged with bridge method [inline-methods] */
    public Void a(byte[] bArr) {
        return null;
    }

    @Override // chat.ola.vn.entity.m
    public void b(String str) {
    }
}
