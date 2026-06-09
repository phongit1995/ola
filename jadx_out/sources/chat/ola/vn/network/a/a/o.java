package chat.ola.vn.network.a.a;

import java.util.HashMap;
import java.util.Map;

/* JADX INFO: loaded from: classes.dex */
public class o extends chat.ola.vn.entity.m<Void> {
    private String c;

    public o(String str, long j) {
        super(j);
        this.c = str;
        this.b = false;
    }

    @Override // chat.ola.vn.entity.m
    public String a() {
        try {
            HashMap map = new HashMap();
            map.put("kitToken", this.c);
            map.put("gameCode", "ola.acckit");
            return chat.ola.vn.util.http.a.a((String) null, "player/member/acckit", (Map<String, String>) map, false);
        } catch (Throwable unused) {
            return null;
        }
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
    }
}
