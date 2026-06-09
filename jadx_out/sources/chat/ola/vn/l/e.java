package chat.ola.vn.l;

import android.os.AsyncTask;
import chat.ola.vn.util.m;
import com.facebook.accountkit.internal.AccountKitGraphConstants;
import java.util.HashMap;
import java.util.Map;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
class e extends AsyncTask<String, Void, String> {
    int a = 0;
    String b = null;
    chat.ola.vn.network.c c;

    e() {
    }

    private String b(String str) {
        HashMap map = new HashMap();
        map.put("gameCode", "ola");
        if (!m.a(str)) {
            map.put("deviceId", str);
        }
        if (!m.a(this.b)) {
            map.put("socialToken", this.b);
            map.put("socialType", "" + this.a);
        }
        return chat.ola.vn.util.http.a.a((String) null, "player/token", (Map<String, String>) map, false);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // android.os.AsyncTask
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public String doInBackground(String... strArr) {
        try {
            String strE = chat.ola.vn.util.http.a.e(b(chat.ola.vn.h.g));
            if (!m.a(strE)) {
                JSONObject jSONObject = new JSONObject(strE);
                if ((jSONObject.has("error") ? jSONObject.getInt("error") : 1) == 0 && jSONObject.has(AccountKitGraphConstants.TOKEN_RESPONSE_TYPE)) {
                    return jSONObject.getString(AccountKitGraphConstants.TOKEN_RESPONSE_TYPE);
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
            this.c.a(str);
        } catch (Throwable unused) {
        }
    }
}
