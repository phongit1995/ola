package chat.ola.vn.entity;

import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class r {
    public String a = "";
    public long b = 0;
    public long c = 0;
    public int d = 0;

    public static r a(String str) {
        r rVar = new r();
        try {
            JSONObject jSONObject = new JSONObject(str);
            rVar.a = jSONObject.optString("passCode");
            rVar.b = jSONObject.optLong("lastFailTime");
            rVar.c = 0L;
            if (jSONObject.has("requirePasscodeTime")) {
                rVar.c = jSONObject.optLong("requirePasscodeTime");
            }
            rVar.d = jSONObject.optInt("failCount");
        } catch (Throwable unused) {
        }
        return rVar;
    }

    public String toString() {
        try {
            JSONObject jSONObject = new JSONObject();
            jSONObject.put("passCode", this.a);
            jSONObject.put("lastFailTime", this.b);
            jSONObject.put("requirePasscodeTime", this.c);
            jSONObject.put("failCount", this.d);
            return jSONObject.toString();
        } catch (Throwable unused) {
            return "";
        }
    }
}
