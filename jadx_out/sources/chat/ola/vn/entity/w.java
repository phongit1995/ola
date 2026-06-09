package chat.ola.vn.entity;

import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class w {
    protected String a = null;
    protected int b = 0;
    public boolean c = false;
    public long d = 0;

    public static w a(JSONObject jSONObject) {
        try {
            w wVar = new w();
            if (jSONObject.has("stickerCode")) {
                wVar.a(jSONObject.getString("stickerCode"));
            }
            if (jSONObject.has("kulIndex")) {
                wVar.a(jSONObject.getInt("kulIndex"));
            }
            wVar.d = jSONObject.getLong("lastHitTime");
            return wVar;
        } catch (Throwable unused) {
            return null;
        }
    }

    public static boolean b(String str) {
        try {
            return str.startsWith("1P4S");
        } catch (Throwable unused) {
            return false;
        }
    }

    public String a() {
        return this.a;
    }

    public void a(int i) {
        this.b = i;
    }

    public void a(String str) {
        this.a = str;
    }

    public JSONObject b() {
        try {
            JSONObject jSONObject = new JSONObject();
            if (!chat.ola.vn.util.m.a(this.a)) {
                jSONObject.put("stickerCode", this.a);
            }
            if (this.b > 0) {
                jSONObject.put("kulIndex", this.b);
            }
            jSONObject.put("lastHitTime", this.d);
            return jSONObject;
        } catch (Throwable unused) {
            return null;
        }
    }

    public int c() {
        return this.b;
    }

    public boolean equals(Object obj) {
        try {
            return chat.ola.vn.util.m.b(this.a, ((w) obj).a);
        } catch (Throwable unused) {
            return super.equals(obj);
        }
    }
}
