package chat.ola.vn.network.a.a;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.json.JSONArray;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class aa extends chat.ola.vn.entity.m<List<chat.ola.vn.entity.w>> {
    chat.ola.vn.entity.v c;
    private chat.ola.vn.p.m d;

    public aa(chat.ola.vn.entity.v vVar, long j) {
        super(j);
        this.c = vVar;
    }

    @Override // chat.ola.vn.entity.m
    public String a() {
        try {
            return chat.ola.vn.util.http.a.a(chat.ola.vn.h.f(), "gallery/folder/" + this.c.a(), (Map<String, String>) null, true);
        } catch (Throwable unused) {
            return null;
        }
    }

    public void a(chat.ola.vn.p.m mVar) {
        this.d = mVar;
    }

    @Override // chat.ola.vn.entity.m
    public void a(List<chat.ola.vn.entity.w> list) {
        try {
            this.d.a(this.c, list);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.entity.m
    /* JADX INFO: renamed from: b, reason: merged with bridge method [inline-methods] */
    public List<chat.ola.vn.entity.w> a(byte[] bArr) {
        ArrayList arrayList = null;
        try {
            JSONArray jSONArray = chat.ola.vn.util.http.c.a(bArr).getJSONArray("files");
            int length = jSONArray.length();
            if (length > 0) {
                ArrayList arrayList2 = new ArrayList(length);
                for (int i = 0; i < length; i++) {
                    try {
                        JSONObject jSONObject = jSONArray.getJSONObject(i);
                        chat.ola.vn.entity.w wVar = new chat.ola.vn.entity.w();
                        if (jSONObject.has("url")) {
                            wVar.a(jSONObject.getString("url"));
                        }
                        arrayList2.add(wVar);
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
