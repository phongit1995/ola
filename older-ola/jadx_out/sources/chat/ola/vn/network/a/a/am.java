package chat.ola.vn.network.a.a;

import java.util.HashMap;
import java.util.Map;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class am extends chat.ola.vn.entity.m<String> {
    public chat.ola.vn.p.p c;

    public am(long j) {
        super(j);
    }

    @Override // chat.ola.vn.entity.m
    public String a() {
        HashMap map = new HashMap();
        map.put("did", "" + chat.ola.vn.h.g);
        return chat.ola.vn.util.http.a.a(chat.ola.vn.h.f(), "id/authweb", (Map<String, String>) map, true);
    }

    @Override // chat.ola.vn.entity.m
    /* JADX INFO: renamed from: b, reason: merged with bridge method [inline-methods] */
    public String a(byte[] bArr) {
        try {
            JSONObject jSONObjectA = chat.ola.vn.util.http.c.a(bArr);
            if (jSONObjectA.has("url")) {
                return jSONObjectA.getString("url");
            }
            return null;
        } catch (Throwable unused) {
            return null;
        }
    }

    @Override // chat.ola.vn.entity.m
    public void b(String str) {
        if (this.c != null) {
            this.c.a();
        }
    }

    @Override // chat.ola.vn.entity.m
    /* JADX INFO: renamed from: c, reason: merged with bridge method [inline-methods] */
    public void a(String str) {
        if (chat.ola.vn.util.m.a(str)) {
            b((String) null);
        } else {
            this.c.a(str);
        }
    }
}
