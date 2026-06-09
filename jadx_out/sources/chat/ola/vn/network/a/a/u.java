package chat.ola.vn.network.a.a;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.json.JSONArray;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class u extends chat.ola.vn.entity.m<List<chat.ola.vn.message.f>> {
    int c;
    String d;
    public chat.ola.vn.p.k e;

    public u(String str, int i, long j) {
        super(j);
        this.c = 10;
        this.c = i;
        this.d = str;
    }

    @Override // chat.ola.vn.entity.m
    public String a() {
        if (this.d != null) {
            String strReplace = this.d;
            if (strReplace.startsWith("/json")) {
                strReplace = strReplace.replace("/json", "");
            }
            return chat.ola.vn.util.http.a.a(chat.ola.vn.h.f(), strReplace, (Map<String, String>) null, true);
        }
        HashMap map = new HashMap();
        map.put("ms", "" + System.currentTimeMillis());
        map.put("n", "" + this.c);
        return chat.ola.vn.util.http.a.a(chat.ola.vn.h.f(), "me/visit/more", (Map<String, String>) map, true);
    }

    @Override // chat.ola.vn.entity.m
    public void a(List<chat.ola.vn.message.f> list) {
        if (list == null) {
            b((String) null);
        } else if (this.e != null) {
            this.e.a(list, this.d);
        }
    }

    @Override // chat.ola.vn.entity.m
    /* JADX INFO: renamed from: b, reason: merged with bridge method [inline-methods] */
    public List<chat.ola.vn.message.f> a(byte[] bArr) {
        ArrayList arrayList = null;
        try {
            JSONObject jSONObjectA = chat.ola.vn.util.http.c.a(bArr);
            try {
                if (jSONObjectA.has("visits")) {
                    JSONArray jSONArray = jSONObjectA.getJSONArray("visits");
                    int length = jSONArray.length();
                    ArrayList arrayList2 = null;
                    for (int i = 0; i < length; i++) {
                        try {
                            JSONObject jSONObject = jSONArray.getJSONObject(i);
                            if (arrayList2 == null) {
                                arrayList2 = new ArrayList(length);
                            }
                            String string = jSONObject.getString("nick");
                            chat.ola.vn.message.f fVarD = chat.ola.vn.h.t.d(string);
                            if (fVarD == null) {
                                fVarD = new chat.ola.vn.message.f(string, (short) 0);
                            }
                            fVarD.q = Long.valueOf(jSONObject.getLong("dms"));
                            arrayList2.add(fVarD);
                        } catch (Throwable unused) {
                        }
                    }
                    arrayList = arrayList2;
                }
            } catch (Throwable unused2) {
            }
            if (jSONObjectA.has("more")) {
                this.d = jSONObjectA.getString("more");
            }
        } catch (Throwable unused3) {
        }
        return arrayList;
    }

    @Override // chat.ola.vn.entity.m
    public void b(String str) {
        if (this.e != null) {
            this.e.a();
        }
    }
}
