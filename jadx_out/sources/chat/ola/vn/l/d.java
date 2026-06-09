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
class d extends AsyncTask<String, Void, List<String>> {
    int a = 0;
    String b = null;
    String c = null;
    chat.ola.vn.network.c d;

    d() {
    }

    private String a(String str) {
        HashMap map = new HashMap();
        map.put("gameCode", "ola");
        if (!m.a(str)) {
            map.put("deviceId", str);
        }
        if (!m.a(this.c)) {
            map.put(AccountKitGraphConstants.TOKEN_RESPONSE_TYPE, this.c);
        }
        if (!m.a(this.b)) {
            map.put("socialToken", this.b);
            map.put("socialType", "" + this.a);
        }
        return chat.ola.vn.util.http.a.a((String) null, "player/member/list", (Map<String, String>) map, false);
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
                if ((jSONObject.has("error") ? jSONObject.getInt("error") : 0) == 0 && jSONObject.has("nicks")) {
                    JSONArray jSONArray = jSONObject.getJSONArray("nicks");
                    if (jSONArray.length() > 0) {
                        int length = jSONArray.length();
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
            this.d.a(list);
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }
}
