package chat.ola.vn.network.a.a;

import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
public class af extends chat.ola.vn.entity.m<chat.ola.vn.entity.e> {
    private String c;

    public af(String str, long j) {
        super(j);
        this.c = str;
    }

    @Override // chat.ola.vn.entity.m
    public String a() {
        String strA = chat.ola.vn.h.a();
        if (chat.ola.vn.util.m.a(this.c) || chat.ola.vn.util.m.a(strA)) {
            return null;
        }
        return chat.ola.vn.util.http.a.a(chat.ola.vn.h.f(), "mall/hittow?id=" + this.c + "&owsn=" + strA, (Map<String, String>) null, true);
    }

    @Override // chat.ola.vn.entity.m
    public void a(chat.ola.vn.entity.e eVar) {
    }

    @Override // chat.ola.vn.entity.m
    /* JADX INFO: renamed from: b, reason: merged with bridge method [inline-methods] */
    public chat.ola.vn.entity.e a(byte[] bArr) {
        return null;
    }

    @Override // chat.ola.vn.entity.m
    public void b(String str) {
    }
}
