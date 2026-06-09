package chat.ola.vn.h;

import android.accounts.Account;
import chat.ola.vn.util.m;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class a {
    public Account a;
    public String b;
    public String c;
    public String d;
    public long e;

    public JSONObject a() {
        String str;
        String str2;
        String str3;
        String str4;
        JSONObject jSONObject = new JSONObject();
        try {
            if (this.a == null) {
                return null;
            }
            jSONObject.put("username", this.a.name);
            if (m.a(this.b)) {
                str = "password";
                str2 = "";
            } else {
                str = "password";
                str2 = this.b;
            }
            jSONObject.put(str, str2);
            if (m.a(this.c)) {
                str3 = "workingSession";
                str4 = "";
            } else {
                str3 = "workingSession";
                str4 = this.c;
            }
            jSONObject.put(str3, str4);
            if (!m.a(this.d)) {
                jSONObject.put("trustToken", this.d);
            }
            jSONObject.put("lastAccessTime", "" + this.e);
            return jSONObject;
        } catch (Throwable unused) {
            return null;
        }
    }

    public String toString() {
        String str;
        String str2;
        String str3;
        String str4;
        JSONObject jSONObject = new JSONObject();
        try {
            if (this.a == null) {
                return "";
            }
            jSONObject.put("username", this.a.name);
            if (m.a(this.b)) {
                str = "password";
                str2 = "";
            } else {
                str = "password";
                str2 = this.b;
            }
            jSONObject.put(str, str2);
            if (m.a(this.c)) {
                str3 = "workingSession";
                str4 = "";
            } else {
                str3 = "workingSession";
                str4 = this.c;
            }
            jSONObject.put(str3, str4);
            jSONObject.put("lastAccessTime", "" + this.e);
            return jSONObject.toString();
        } catch (Throwable unused) {
            return "";
        }
    }
}
