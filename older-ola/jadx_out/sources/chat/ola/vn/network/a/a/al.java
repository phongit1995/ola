package chat.ola.vn.network.a.a;

import java.util.HashMap;
import java.util.Map;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class al extends chat.ola.vn.entity.m<String> {
    private String c;
    private a d;

    public interface a {
        void C();

        void f(String str);
    }

    public al(String str, long j) {
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
            map.put("act", "verify");
            return chat.ola.vn.util.http.a.a((String) null, "player/member/acckit", (Map<String, String>) map, false);
        } catch (Throwable unused) {
            return null;
        }
    }

    public void a(a aVar) {
        this.d = aVar;
    }

    @Override // chat.ola.vn.entity.m
    /* JADX INFO: renamed from: b, reason: merged with bridge method [inline-methods] */
    public String a(byte[] bArr) {
        try {
            JSONObject jSONObjectA = chat.ola.vn.util.http.c.a(bArr);
            if (jSONObjectA.getInt("error") != 0) {
                return null;
            }
            JSONObject jSONObject = jSONObjectA.getJSONObject("acc");
            if (jSONObject.has("phoneNumber")) {
                return jSONObject.getString("phoneNumber");
            }
            return null;
        } catch (Throwable th) {
            th.printStackTrace();
            return null;
        }
    }

    @Override // chat.ola.vn.entity.m
    public void b(String str) {
    }

    @Override // chat.ola.vn.entity.m
    /* JADX INFO: renamed from: c, reason: merged with bridge method [inline-methods] */
    public void a(String str) {
        try {
            if (chat.ola.vn.util.m.a(str)) {
                this.d.C();
            } else {
                this.d.f(str);
            }
        } catch (Throwable unused) {
        }
    }
}
