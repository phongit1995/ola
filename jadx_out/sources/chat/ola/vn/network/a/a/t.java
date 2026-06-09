package chat.ola.vn.network.a.a;

import java.util.Map;
import org.json.JSONArray;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class t extends chat.ola.vn.entity.m<chat.ola.vn.entity.f> {
    public chat.ola.vn.p.c c;
    private long d;

    public t(long j, long j2) {
        super(j2);
        this.d = j;
    }

    private chat.ola.vn.entity.f a(String str, JSONObject jSONObject) {
        try {
            chat.ola.vn.entity.f fVar = new chat.ola.vn.entity.f();
            fVar.k = str;
            fVar.c = this.d;
            if (jSONObject.has("url")) {
                String string = jSONObject.getString("url");
                if (chat.ola.vn.util.m.b(str, "rss")) {
                    fVar.b = new chat.ola.vn.entity.d("rss");
                    fVar.b.b(string);
                }
            }
            if (jSONObject.has("title")) {
                fVar.l = jSONObject.getString("title");
            }
            if (jSONObject.has("intro")) {
                fVar.m = jSONObject.getString("intro");
            }
            if (jSONObject.has("media")) {
                fVar.e = jSONObject.getString("media");
            }
            if (jSONObject.has("noLikes")) {
                fVar.r = jSONObject.getInt("noLikes");
            }
            if (jSONObject.has("liked")) {
                fVar.a(jSONObject.getBoolean("liked") ? (short) 1 : (short) 0);
            }
            if (jSONObject.has("likes")) {
                try {
                    JSONArray jSONArray = jSONObject.getJSONArray("likes");
                    int length = jSONArray.length();
                    if (length > 0) {
                        fVar.i = new String[length];
                        for (int i = 0; i < length; i++) {
                            fVar.i[i] = jSONArray.getString(i);
                        }
                    }
                } catch (Throwable unused) {
                }
            }
            if (jSONObject.has("noComments")) {
                fVar.t = jSONObject.getInt("noComments");
            }
            return fVar;
        } catch (Throwable unused2) {
            return null;
        }
    }

    @Override // chat.ola.vn.entity.m
    public String a() {
        return chat.ola.vn.util.http.a.a((String) null, "me/attachs/" + this.d, (Map<String, String>) null, true);
    }

    @Override // chat.ola.vn.entity.m
    public void a(chat.ola.vn.entity.f fVar) {
        if (fVar == null) {
            b((String) null);
            return;
        }
        try {
            if (chat.ola.vn.util.m.b(fVar.k, "rss")) {
                this.c.a(this.d, fVar);
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.entity.m
    /* JADX INFO: renamed from: b, reason: merged with bridge method [inline-methods] */
    public chat.ola.vn.entity.f a(byte[] bArr) {
        try {
            JSONObject jSONObjectA = chat.ola.vn.util.http.c.a(bArr);
            if (!jSONObjectA.has("type")) {
                return null;
            }
            String string = jSONObjectA.getString("type");
            if (chat.ola.vn.util.m.b(string, "rss")) {
                return a(string, jSONObjectA);
            }
            return null;
        } catch (Throwable unused) {
            return null;
        }
    }

    @Override // chat.ola.vn.entity.m
    public void b(String str) {
        try {
            this.c.a(this.d);
        } catch (Throwable unused) {
        }
    }
}
