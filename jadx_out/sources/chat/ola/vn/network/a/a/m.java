package chat.ola.vn.network.a.a;

import java.util.HashMap;
import java.util.Map;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class m extends chat.ola.vn.entity.m<Boolean> {
    private chat.ola.vn.p.j c;
    private String d;

    public m(String str, long j) {
        super(j);
        this.d = str;
        this.b = false;
    }

    @Override // chat.ola.vn.entity.m
    public String a() {
        try {
            if (!chat.ola.vn.util.m.c(this.d)) {
                HashMap map = new HashMap();
                map.put("un", this.d);
                return chat.ola.vn.util.http.a.a((String) null, "id/regable", (Map<String, String>) map, false);
            }
        } catch (Throwable unused) {
        }
        return null;
    }

    public void a(chat.ola.vn.p.j jVar) {
        this.c = jVar;
    }

    @Override // chat.ola.vn.entity.m
    public void a(Boolean bool) {
        try {
            this.c.a(this.d, bool.booleanValue());
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.entity.m
    /* JADX INFO: renamed from: b, reason: merged with bridge method [inline-methods] */
    public Boolean a(byte[] bArr) {
        try {
            JSONObject jSONObjectA = chat.ola.vn.util.http.c.a(bArr);
            if (jSONObjectA.has("nick")) {
                this.d = jSONObjectA.getString("nick");
            }
            if (jSONObjectA.has("result")) {
                return Boolean.valueOf(jSONObjectA.getBoolean("result"));
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
        return false;
    }

    @Override // chat.ola.vn.entity.m
    public void b(String str) {
    }
}
