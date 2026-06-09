package chat.ola.vn.util.http;

import chat.ola.vn.entity.d;
import chat.ola.vn.entry.e;
import chat.ola.vn.h;
import chat.ola.vn.util.m;
import chat.ola.vn.util.o;
import java.util.List;
import org.json.JSONArray;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class b {
    public static String a(String str, String str2, List<e> list) {
        d dVar;
        if (list == null) {
            return str2;
        }
        String strA = a.a(str, "api/apps", true);
        if (m.a(strA)) {
            return str2;
        }
        String strE = a.e(strA);
        if (!m.a(strE)) {
            try {
                JSONObject jSONObject = new JSONObject(strE);
                String string = jSONObject.getString("version");
                if (m.b(str2, string)) {
                    return str2;
                }
                JSONArray jSONArray = jSONObject.getJSONArray("apps");
                if (jSONArray != null && jSONArray.length() > 0) {
                    int length = jSONArray.length();
                    for (int i = 0; i < length; i++) {
                        JSONObject jSONObject2 = jSONArray.getJSONObject(i);
                        String string2 = jSONObject2.getString("name");
                        String string3 = jSONObject2.has("notifyText") ? jSONObject2.getString("notifyText") : null;
                        boolean z = jSONObject2.has("isNotification") ? jSONObject2.getBoolean("isNotification") : false;
                        int i2 = jSONObject2.has("positionIndex") ? jSONObject2.getInt("positionIndex") : -1;
                        if (jSONObject2.has("appAction")) {
                            try {
                                dVar = o.a(jSONObject2.getString("appAction"), h.a())[0];
                            } catch (Throwable unused) {
                                dVar = null;
                            }
                        } else {
                            dVar = null;
                        }
                        String string4 = jSONObject2.getString("url");
                        chat.ola.vn.o.c cVar = new chat.ola.vn.o.c(string2, jSONObject2.getString("icon"));
                        if (i2 >= 0) {
                            cVar.a(i2);
                        }
                        cVar.a(dVar);
                        cVar.c(string3);
                        if (!m.a(string3)) {
                            if (z) {
                                cVar.b(2);
                            } else {
                                cVar.b(1);
                                cVar.d(string3);
                            }
                        }
                        cVar.b(string4);
                        list.add(cVar);
                    }
                }
                return string;
            } catch (Throwable unused2) {
            }
        }
        return str2;
    }
}
