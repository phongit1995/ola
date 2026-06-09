package chat.ola.vn.l;

import android.os.AsyncTask;
import chat.ola.vn.util.m;
import com.facebook.accountkit.internal.AccountKitGraphConstants;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.json.JSONArray;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
class f extends AsyncTask<String, Void, List<String>> {
    String a = null;
    chat.ola.vn.network.c b;

    f() {
    }

    private String a(String str) {
        HashMap map = new HashMap();
        map.put("gameCode", "ola");
        if (!m.a(str)) {
            map.put("deviceId", str);
        }
        if (!m.a(this.a)) {
            map.put(AccountKitGraphConstants.TOKEN_RESPONSE_TYPE, this.a);
        }
        return chat.ola.vn.util.http.a.a((String) null, "player/member/suggest", (Map<String, String>) map, false);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // android.os.AsyncTask
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public List<String> doInBackground(String... strArr) {
        ArrayList arrayList = null;
        try {
            String strE = chat.ola.vn.util.http.a.e(a(chat.ola.vn.h.g));
            if (!m.a(strE)) {
                JSONObject jSONObject = new JSONObject(strE);
                if (jSONObject.has("nicks")) {
                    JSONArray jSONArray = jSONObject.getJSONArray("nicks");
                    if (jSONArray.length() > 0) {
                        int length = jSONObject.length();
                        ArrayList arrayList2 = new ArrayList(length);
                        for (int i = 0; i < length; i++) {
                            try {
                                arrayList2.add(jSONArray.getString(i));
                            } catch (Throwable th) {
                                th = th;
                                arrayList = arrayList2;
                                th.printStackTrace();
                                return arrayList;
                            }
                        }
                        return arrayList2;
                    }
                }
            }
        } catch (Throwable th2) {
            th = th2;
        }
        return arrayList;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // android.os.AsyncTask
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public void onPostExecute(List<String> list) {
        try {
            this.b.b(list);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }
}
