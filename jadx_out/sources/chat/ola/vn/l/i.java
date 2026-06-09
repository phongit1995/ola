package chat.ola.vn.l;

import android.os.AsyncTask;
import chat.ola.vn.util.m;
import com.facebook.accountkit.internal.AccountKitGraphConstants;
import java.util.HashMap;
import java.util.Map;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
class i extends AsyncTask<String, Void, String> {
    chat.ola.vn.network.c e;
    String a = null;
    String b = null;
    String c = null;
    String d = null;
    int f = 0;

    i() {
    }

    private String b(String str) {
        HashMap map = new HashMap();
        map.put("gameCode", "ola");
        if (!m.a(str)) {
            map.put("deviceId", str);
        }
        if (!m.a(this.d)) {
            map.put(AccountKitGraphConstants.TOKEN_RESPONSE_TYPE, this.d);
        }
        if (!m.a(this.a)) {
            map.put("nick", this.a);
        }
        if (!m.a(this.b)) {
            map.put("pass", this.b);
        }
        if (!m.a(this.c)) {
            map.put("phone", this.c);
        }
        return chat.ola.vn.util.http.a.a((String) null, "player/member/register", (Map<String, String>) map, false);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // android.os.AsyncTask
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public String doInBackground(String... strArr) {
        try {
            String strE = chat.ola.vn.util.http.a.e(b(chat.ola.vn.h.g));
            if (!m.a(strE)) {
                JSONObject jSONObject = new JSONObject(strE);
                if (jSONObject.has("error")) {
                    this.f = jSONObject.getInt("error");
                }
                if (jSONObject.has("result") && Boolean.valueOf(jSONObject.getBoolean("result")).booleanValue()) {
                    return jSONObject.getString("owsc");
                }
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
        return null;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // android.os.AsyncTask
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public void onPostExecute(String str) {
        try {
            if (!m.a(str)) {
                this.e.a(this.a, this.b, str);
                return;
            }
            switch (this.f) {
                case 12:
                    this.f = 22;
                    break;
                case 14:
                    this.f = 3;
                    break;
                case 15:
                    this.f = 7;
                    break;
                case 16:
                    this.f = 10;
                    break;
                case 17:
                    this.f = 32;
                    break;
            }
            this.e.a((short) this.f);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }
}
