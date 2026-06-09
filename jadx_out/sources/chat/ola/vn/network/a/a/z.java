package chat.ola.vn.network.a.a;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.json.JSONArray;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class z extends chat.ola.vn.entity.m<List<chat.ola.vn.entity.v>> {
    private chat.ola.vn.p.m c;

    public z(long j) {
        super(j);
    }

    @Override // chat.ola.vn.entity.m
    public String a() {
        try {
            return chat.ola.vn.util.http.a.a(chat.ola.vn.h.f(), "gallery/cat/sticker", (Map<String, String>) null, true);
        } catch (Throwable unused) {
            return null;
        }
    }

    public void a(chat.ola.vn.p.m mVar) {
        this.c = mVar;
    }

    @Override // chat.ola.vn.entity.m
    public void a(List<chat.ola.vn.entity.v> list) {
        if (list == null) {
            b((String) null);
        } else {
            try {
                this.c.a(list);
            } catch (Throwable unused) {
            }
        }
    }

    @Override // chat.ola.vn.entity.m
    /* JADX INFO: renamed from: b, reason: merged with bridge method [inline-methods] */
    public List<chat.ola.vn.entity.v> a(byte[] bArr) {
        ArrayList arrayList = null;
        try {
            JSONArray jSONArray = chat.ola.vn.util.http.c.a(bArr).getJSONArray("folders");
            int length = jSONArray.length();
            if (length > 0) {
                ArrayList arrayList2 = new ArrayList(length);
                for (int i = 0; i < length; i++) {
                    try {
                        JSONObject jSONObject = jSONArray.getJSONObject(i);
                        chat.ola.vn.entity.v vVar = new chat.ola.vn.entity.v();
                        if (jSONObject.has("id")) {
                            vVar.a(jSONObject.getString("id"));
                        }
                        if (jSONObject.has("name")) {
                            vVar.b(jSONObject.getString("name"));
                        }
                        if (jSONObject.has("coverUrl")) {
                            vVar.c(jSONObject.getString("coverUrl"));
                        }
                        if (jSONObject.has("path")) {
                            vVar.d(jSONObject.getString("path"));
                        }
                        if (jSONObject.has("count")) {
                            vVar.a(jSONObject.getInt("count"));
                        }
                        arrayList2.add(vVar);
                    } catch (Throwable th) {
                        th = th;
                        arrayList = arrayList2;
                        th.printStackTrace();
                        return arrayList;
                    }
                }
                return arrayList2;
            }
        } catch (Throwable th2) {
            th = th2;
        }
        return arrayList;
    }

    @Override // chat.ola.vn.entity.m
    public void b(String str) {
    }
}
