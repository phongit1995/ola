package chat.ola.vn.network.a.a;

import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
public class ae extends chat.ola.vn.entity.m<Void> {
    public chat.ola.vn.p.k c;

    public ae(long j) {
        super(j);
    }

    @Override // chat.ola.vn.entity.m
    public String a() {
        return chat.ola.vn.util.http.a.a(chat.ola.vn.h.f(), "id/activehit", (Map<String, String>) null, true);
    }

    @Override // chat.ola.vn.entity.m
    public void a(Void r1) {
    }

    @Override // chat.ola.vn.entity.m
    /* JADX INFO: renamed from: b, reason: merged with bridge method [inline-methods] */
    public Void a(byte[] bArr) {
        return null;
    }

    @Override // chat.ola.vn.entity.m
    public void b(String str) {
        if (this.c != null) {
            this.c.a();
        }
    }
}
