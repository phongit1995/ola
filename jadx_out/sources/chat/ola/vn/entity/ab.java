package chat.ola.vn.entity;

import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class ab {
    public short a = 1;
    public byte b = 0;
    public String c;

    public static ab a(String str) {
        ab abVar = new ab();
        abVar.b = (byte) 1;
        abVar.a = (short) 1;
        abVar.c = str;
        return abVar;
    }

    public static ab a(JSONObject jSONObject) {
        try {
            ab abVar = new ab();
            abVar.b = (byte) jSONObject.getInt("type");
            abVar.c = jSONObject.getString("url");
            abVar.a = (short) 1;
            if (jSONObject.has("mediaType")) {
                abVar.a = (short) jSONObject.getInt("mediaType");
            }
            return abVar;
        } catch (Throwable unused) {
            return null;
        }
    }

    public static ab b(String str) {
        ab abVar = new ab();
        abVar.b = (byte) 0;
        abVar.a = (short) 1;
        abVar.c = str;
        return abVar;
    }

    public static ab c(String str) {
        ab abVar = new ab();
        abVar.b = (byte) 0;
        abVar.a = (short) 2;
        abVar.c = str;
        return abVar;
    }

    public JSONObject a() {
        try {
            JSONObject jSONObject = new JSONObject();
            jSONObject.put("type", (int) this.b);
            jSONObject.put("mediaType", (int) this.a);
            if (!chat.ola.vn.util.m.a(this.c)) {
                jSONObject.put("url", this.c);
            }
            return jSONObject;
        } catch (Throwable unused) {
            return null;
        }
    }

    public boolean equals(Object obj) {
        try {
            ab abVar = (ab) obj;
            if (this.b == abVar.b) {
                if (chat.ola.vn.util.m.a(this.c, abVar.c)) {
                    return true;
                }
            }
        } catch (Throwable unused) {
        }
        return super.equals(obj);
    }
}
