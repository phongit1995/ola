package chat.ola.vn.network.a.a;

import java.util.HashMap;
import java.util.Map;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class n extends chat.ola.vn.entity.m<Integer> {
    private chat.ola.vn.p.q c;
    private String d;
    private String e;
    private String f;
    private String g;
    private String h;
    private String i;

    public n(String str, String str2, String str3, long j) {
        super(j);
        this.f = str;
        this.d = str2;
        this.e = str3;
    }

    @Override // chat.ola.vn.entity.m
    public String a() {
        HashMap map = new HashMap();
        if (!chat.ola.vn.util.m.a(this.f)) {
            map.put("responseCode", this.f);
        }
        if (!chat.ola.vn.util.m.a(this.d)) {
            map.put("purchaseData", this.d);
        }
        if (!chat.ola.vn.util.m.a(this.e)) {
            map.put("dataSignature", this.e);
        }
        return chat.ola.vn.util.http.a.a(chat.ola.vn.h.f(), "pay/ginapp/commit", (Map<String, String>) map, true);
    }

    public void a(chat.ola.vn.p.q qVar) {
        this.c = qVar;
    }

    @Override // chat.ola.vn.entity.m
    public void a(Integer num) {
        if (num != null) {
            try {
                if (num.intValue() == 0) {
                    try {
                        this.c.a(this.i, this.h, this.g);
                    } catch (Throwable unused) {
                    }
                } else if (num.intValue() > 0) {
                    b(this.g);
                }
            } catch (Throwable th) {
                th.printStackTrace();
            }
        }
    }

    @Override // chat.ola.vn.entity.m
    /* JADX INFO: renamed from: b, reason: merged with bridge method [inline-methods] */
    public Integer a(byte[] bArr) {
        JSONObject jSONObjectA;
        Integer numValueOf = -1;
        try {
            jSONObjectA = chat.ola.vn.util.http.c.a(bArr);
        } catch (Throwable unused) {
        }
        if (jSONObjectA.has("apiError")) {
            return -1;
        }
        if (jSONObjectA.has("errorCode")) {
            try {
                numValueOf = Integer.valueOf(jSONObjectA.getInt("errorCode"));
            } catch (Throwable unused2) {
                numValueOf = 0;
            }
        }
        if (jSONObjectA.has("message")) {
            this.g = jSONObjectA.getString("message");
        }
        if (jSONObjectA.has("purchaseToken")) {
            this.h = jSONObjectA.getString("purchaseToken");
        }
        if (jSONObjectA.has("productId")) {
            this.i = jSONObjectA.getString("productId");
        }
        return numValueOf;
    }

    @Override // chat.ola.vn.entity.m
    public void b(String str) {
        try {
            this.c.b(this.i, this.h, str);
        } catch (Throwable unused) {
        }
    }
}
