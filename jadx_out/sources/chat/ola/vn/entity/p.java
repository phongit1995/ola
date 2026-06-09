package chat.ola.vn.entity;

import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class p {
    public static String a = "sms";
    public static String b = "card";
    public static String c = "ginapp";
    public String d;
    public String e;
    public String f;
    public String g;
    public String h;
    public String i;
    public String j;
    public long k;
    public String l;
    public String m;
    public a n;
    public ae o;

    public JSONObject a() {
        JSONObject jSONObject = new JSONObject();
        try {
            if (chat.ola.vn.util.m.a(this.f) || chat.ola.vn.util.m.a(this.m)) {
                return null;
            }
            jSONObject.put("productId", this.f);
            jSONObject.put("signatureData", this.m);
            return jSONObject;
        } catch (Throwable unused) {
            return null;
        }
    }
}
