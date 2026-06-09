package chat.ola.vn.network.a.a;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import org.json.JSONArray;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class ad extends chat.ola.vn.entity.m<chat.ola.vn.entity.q> {
    public String c;
    public String[] d;

    public ad(long j) {
        super(j);
        this.c = null;
        this.d = null;
    }

    @Override // chat.ola.vn.entity.m
    public String a() {
        try {
            HashMap map = new HashMap();
            JSONArray jSONArray = new JSONArray();
            if (this.d != null) {
                for (int i = 0; i < this.d.length; i++) {
                    jSONArray.put(this.d[i]);
                }
                map.put("ids", jSONArray.toString());
            }
            return chat.ola.vn.util.http.a.a(chat.ola.vn.h.f(), "like/gets/" + this.c, (Map<String, String>) map, true);
        } catch (Throwable unused) {
            return null;
        }
    }

    @Override // chat.ola.vn.entity.m
    public void a(chat.ola.vn.entity.q qVar) {
    }

    @Override // chat.ola.vn.entity.m
    /* JADX INFO: renamed from: b, reason: merged with bridge method [inline-methods] */
    public chat.ola.vn.entity.q a(byte[] bArr) {
        JSONArray jSONArray;
        int length;
        try {
            JSONObject jSONObjectA = chat.ola.vn.util.http.c.a(bArr);
            if (this.d != null) {
                ArrayList arrayList = null;
                for (int i = 0; i < this.d.length; i++) {
                    if (jSONObjectA.has(this.d[i])) {
                        JSONObject jSONObject = jSONObjectA.getJSONObject(this.d[i]);
                        chat.ola.vn.entity.q qVar = new chat.ola.vn.entity.q();
                        qVar.b = this.c;
                        qVar.c = this.d[i];
                        if (jSONObject.has("1")) {
                            qVar.d = jSONObject.getInt("1");
                        }
                        if (jSONObject.has("2")) {
                            qVar.e = jSONObject.getInt("2");
                        }
                        if (jSONObject.has("liked")) {
                            qVar.f = (short) jSONObject.getInt("liked");
                        }
                        if (jSONObject.has("likers") && (length = (jSONArray = jSONObject.getJSONArray("likers")).length()) > 0) {
                            qVar.a = new String[length];
                            for (int i2 = 0; i2 < length; i2++) {
                                qVar.a[i2] = jSONArray.getString(i2);
                            }
                        }
                        if (arrayList == null) {
                            arrayList = new ArrayList();
                        }
                        arrayList.add(qVar);
                    }
                }
                chat.ola.vn.r.a.e.f(arrayList);
                return null;
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
        return null;
    }

    @Override // chat.ola.vn.entity.m
    public void b(String str) {
    }
}
