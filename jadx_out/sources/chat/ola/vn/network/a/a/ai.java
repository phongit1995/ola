package chat.ola.vn.network.a.a;

import java.util.HashMap;
import java.util.Map;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class ai extends chat.ola.vn.entity.m<String> {
    private String c;
    private String d;
    private a e;

    public interface a {
        void a_(String str, String str2);

        void c_();
    }

    public ai(String str, String str2, long j) {
        super(j);
        this.d = str;
        this.c = str2;
        this.b = false;
    }

    @Override // chat.ola.vn.entity.m
    public String a() {
        try {
            HashMap map = new HashMap();
            map.put("kitToken", this.c);
            map.put("gameCode", "ola.acckit");
            map.put("act", "resetpass");
            map.put("nick", this.d);
            return chat.ola.vn.util.http.a.a((String) null, "player/member/acckit", (Map<String, String>) map, false);
        } catch (Throwable unused) {
            return null;
        }
    }

    public void a(a aVar) {
        this.e = aVar;
    }

    @Override // chat.ola.vn.entity.m
    /* JADX INFO: renamed from: b, reason: merged with bridge method [inline-methods] */
    public String a(byte[] bArr) {
        try {
            JSONObject jSONObjectA = chat.ola.vn.util.http.c.a(bArr);
            if ((jSONObjectA.has("error") ? jSONObjectA.getInt("error") : 0) == 0 && jSONObjectA.has("pass")) {
                return jSONObjectA.getString("pass");
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
                this.e.c_();
            } else {
                this.e.a_(this.d, str);
            }
        } catch (Throwable unused) {
        }
    }
}
