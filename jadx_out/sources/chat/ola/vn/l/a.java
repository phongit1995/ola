package chat.ola.vn.l;

import android.os.AsyncTask;
import chat.ola.vn.util.m;
import com.facebook.accountkit.internal.AccountKitGraphConstants;
import java.util.HashMap;
import java.util.Map;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
class a extends AsyncTask<String, Void, Boolean> {
    chat.ola.vn.network.c c;
    String a = null;
    String b = null;
    int d = 0;

    a() {
    }

    private String a(String str) {
        HashMap map = new HashMap();
        map.put("gameCode", "ola");
        if (!m.a(str)) {
            map.put("deviceId", str);
        }
        if (!m.a(this.b)) {
            map.put(AccountKitGraphConstants.TOKEN_RESPONSE_TYPE, this.b);
        }
        if (!m.a(this.a)) {
            map.put("nick", this.a);
        }
        return chat.ola.vn.util.http.a.a((String) null, "player/member/check", (Map<String, String>) map, false);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // android.os.AsyncTask
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public Boolean doInBackground(String... strArr) {
        try {
            String strE = chat.ola.vn.util.http.a.e(a(chat.ola.vn.h.g));
            if (!m.a(strE)) {
                JSONObject jSONObject = new JSONObject(strE);
                if ((jSONObject.has("error") ? jSONObject.getInt("error") : 0) == 0 && jSONObject.has("result")) {
                    return Boolean.valueOf(jSONObject.getBoolean("result"));
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
    public void onPostExecute(Boolean bool) {
        if (bool != null) {
            try {
                this.c.a(this.a, bool.booleanValue());
            } catch (Throwable th) {
                th.printStackTrace();
            }
        }
    }
}
