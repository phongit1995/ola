package chat.ola.vn.network.a.a;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.json.JSONArray;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class p extends chat.ola.vn.entity.m<List<String>> {
    private String c;
    private a d;

    public interface a {
        void a(String str, List<String> list);
    }

    public p(String str, long j) {
        super(j);
        this.c = str;
        this.b = false;
    }

    @Override // chat.ola.vn.entity.m
    public String a() {
        try {
            HashMap map = new HashMap();
            map.put("kitToken", this.c);
            map.put("gameCode", "ola.acckit");
            map.put("act", "nicks");
            return chat.ola.vn.util.http.a.a((String) null, "player/member/acckit", (Map<String, String>) map, false);
        } catch (Throwable unused) {
            return null;
        }
    }

    public void a(a aVar) {
        this.d = aVar;
    }

    @Override // chat.ola.vn.entity.m
    public void a(List<String> list) {
        try {
            this.d.a(this.c, list);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.entity.m
    /* JADX INFO: renamed from: b, reason: merged with bridge method [inline-methods] */
    public List<String> a(byte[] bArr) {
        JSONArray jSONArray;
        int length;
        try {
            JSONObject jSONObjectA = chat.ola.vn.util.http.c.a(bArr);
            if ((jSONObjectA.has("error") ? jSONObjectA.getInt("error") : 0) != 0 || !jSONObjectA.has("nicks") || (length = (jSONArray = jSONObjectA.getJSONArray("nicks")).length()) <= 0) {
                return null;
            }
            ArrayList arrayList = new ArrayList(length);
            for (int i = 0; i < length; i++) {
                arrayList.add(jSONArray.getString(i));
            }
            return arrayList;
        } catch (Throwable th) {
            th.printStackTrace();
            return null;
        }
    }

    @Override // chat.ola.vn.entity.m
    public void b(String str) {
    }
}
