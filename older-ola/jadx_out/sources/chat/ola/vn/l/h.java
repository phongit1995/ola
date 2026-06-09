package chat.ola.vn.l;

import android.os.AsyncTask;
import chat.ola.vn.util.m;
import com.facebook.accountkit.internal.AccountKitGraphConstants;
import java.util.HashMap;
import java.util.Map;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
class h extends AsyncTask<String, Void, String> {
    chat.ola.vn.network.c c;
    String a = null;
    private String e = null;
    String b = null;
    int d = 7;

    h() {
    }

    private String b(String str) {
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
        return chat.ola.vn.util.http.a.a((String) null, "player/member/checkin", (Map<String, String>) map, false);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // android.os.AsyncTask
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public String doInBackground(String... strArr) {
        try {
            String strE = chat.ola.vn.util.http.a.e(b(chat.ola.vn.h.g));
            if (!m.a(strE)) {
                JSONObject jSONObject = new JSONObject(strE);
                if (jSONObject.has("owsc")) {
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
            if (m.a(str)) {
                this.c.b((short) this.d);
            } else {
                this.c.b(this.a, this.e, str);
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }
}
