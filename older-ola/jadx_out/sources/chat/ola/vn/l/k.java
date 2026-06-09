package chat.ola.vn.l;

import android.os.AsyncTask;
import chat.ola.vn.util.m;
import java.util.HashMap;
import java.util.Map;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
class k extends AsyncTask<String, Void, Boolean> {
    String a = null;
    chat.ola.vn.network.c b;

    k() {
    }

    private String a(String str) {
        HashMap map = new HashMap();
        map.put("gameCode", "ola");
        if (!m.a(str)) {
            map.put("deviceId", str);
        }
        return chat.ola.vn.util.http.a.a(this.a, "player/member/unlink", (Map<String, String>) map, false);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // android.os.AsyncTask
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public Boolean doInBackground(String... strArr) {
        try {
            String strE = chat.ola.vn.util.http.a.e(a(chat.ola.vn.h.g));
            if (!m.a(strE)) {
                JSONObject jSONObject = new JSONObject(strE);
                if (jSONObject.has("result")) {
                    return Boolean.valueOf(jSONObject.getBoolean("result"));
                }
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
        return false;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // android.os.AsyncTask
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public void onPostExecute(Boolean bool) {
        try {
            if (bool.booleanValue()) {
                this.b.c();
            } else {
                this.b.d();
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }
}
