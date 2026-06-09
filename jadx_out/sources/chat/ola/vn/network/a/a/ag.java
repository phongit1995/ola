package chat.ola.vn.network.a.a;

import java.util.HashMap;
import java.util.Map;
import org.json.JSONArray;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class ag extends chat.ola.vn.entity.m<chat.ola.vn.entity.q> {
    public String c;
    public String d;
    public short e;

    public ag(long j) {
        super(j);
        this.c = null;
        this.d = null;
        this.e = (short) 0;
    }

    @Override // chat.ola.vn.entity.m
    public String a() {
        try {
            HashMap map = new HashMap();
            map.put("act", "" + ((int) this.e));
            return chat.ola.vn.util.http.a.a(chat.ola.vn.h.f(), "like/act/" + this.c + "/" + this.d, (Map<String, String>) map, true);
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
            chat.ola.vn.entity.q qVar = new chat.ola.vn.entity.q();
            qVar.b = this.c;
            if (!chat.ola.vn.util.m.b(this.c, "me")) {
                return null;
            }
            qVar.c = this.d;
            if (jSONObjectA.has("1")) {
                qVar.d = jSONObjectA.getInt("1");
            }
            if (jSONObjectA.has("2")) {
                qVar.e = jSONObjectA.getInt("2");
            }
            if (jSONObjectA.has("liked")) {
                qVar.f = (short) jSONObjectA.getInt("liked");
            }
            if (jSONObjectA.has("likers") && (length = (jSONArray = jSONObjectA.getJSONArray("likers")).length()) > 0) {
                qVar.a = new String[length];
                for (int i = 0; i < length; i++) {
                    qVar.a[i] = jSONArray.getString(i);
                }
            }
            chat.ola.vn.r.a.e.a(qVar);
            return null;
        } catch (Throwable th) {
            th.printStackTrace();
            return null;
        }
    }

    @Override // chat.ola.vn.entity.m
    public void b(String str) {
    }
}
