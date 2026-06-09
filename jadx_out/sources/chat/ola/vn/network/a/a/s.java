package chat.ola.vn.network.a.a;

import com.google.firebase.analytics.FirebaseAnalytics;
import java.util.Map;
import org.json.JSONArray;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class s extends chat.ola.vn.entity.m<chat.ola.vn.entity.f> {
    public chat.ola.vn.p.c c;
    private long d;

    public s(long j, long j2) {
        super(j2);
        this.d = j;
    }

    private chat.ola.vn.entity.f a(String str, JSONObject jSONObject) {
        chat.ola.vn.entity.w wVar;
        try {
            chat.ola.vn.entity.f fVar = new chat.ola.vn.entity.f();
            fVar.k = str;
            if (jSONObject.has("id")) {
                String string = jSONObject.getString("id");
                try {
                    fVar.c = Long.parseLong(string);
                } catch (Throwable unused) {
                }
                fVar.b = new chat.ola.vn.entity.d("viewme");
                fVar.b.b(string);
                fVar.b.e("comment");
                if (jSONObject.has(FirebaseAnalytics.Param.CONTENT)) {
                    fVar.d = jSONObject.getString(FirebaseAnalytics.Param.CONTENT);
                }
                if (jSONObject.has("creator")) {
                    fVar.f = jSONObject.getString("creator");
                    fVar.q = fVar.f;
                    try {
                        chat.ola.vn.message.f fVarD = chat.ola.vn.h.t.d(fVar.f);
                        if (fVarD != null) {
                            fVar.q = fVarD.L();
                        }
                    } catch (Throwable unused2) {
                    }
                }
                if (jSONObject.has("createdDate")) {
                    try {
                        fVar.g = Long.parseLong(jSONObject.getString("createdDate"));
                    } catch (Throwable unused3) {
                    }
                    fVar.h = System.currentTimeMillis() - fVar.g;
                }
                if (jSONObject.has("deltaTime")) {
                    try {
                        fVar.h = Long.parseLong(jSONObject.getString("deltaTime"));
                    } catch (Throwable unused4) {
                    }
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
                    } catch (Throwable unused5) {
                    }
                }
                short sShortValue = jSONObject.has("kulId") ? Short.valueOf(jSONObject.getString("kulId")).shortValue() : (short) 0;
                if (sShortValue > 0) {
                    wVar = new chat.ola.vn.entity.w();
                    wVar.a(sShortValue);
                } else {
                    wVar = null;
                }
                if (jSONObject.has("mediaCode")) {
                    String string2 = jSONObject.getString("mediaCode");
                    if (chat.ola.vn.entity.w.b(string2) && wVar == null) {
                        wVar = new chat.ola.vn.entity.w();
                        wVar.a(string2);
                        string2 = null;
                    }
                    fVar.e = string2;
                }
                fVar.j = wVar;
                if (jSONObject.has("liked")) {
                    fVar.a(jSONObject.getBoolean("liked") ? (short) 1 : (short) 0);
                }
                if (jSONObject.has("likeCount")) {
                    fVar.r = jSONObject.getInt("likeCount");
                }
                if (jSONObject.has("noComments")) {
                    fVar.t = jSONObject.getInt("noComments");
                }
                if ((fVar.d == null || fVar.d.length() == 0) && chat.ola.vn.util.m.a(fVar.e) && chat.ola.vn.util.m.a(fVar.n) && chat.ola.vn.util.m.a(fVar.o)) {
                    return null;
                }
                if (fVar.g < 0) {
                    fVar.g = 0L;
                }
                return fVar;
            }
        } catch (Throwable unused6) {
        }
        return null;
    }

    @Override // chat.ola.vn.entity.m
    public String a() {
        return chat.ola.vn.util.http.a.a((String) null, "me/view/" + this.d, (Map<String, String>) null, true);
    }

    @Override // chat.ola.vn.entity.m
    public void a(chat.ola.vn.entity.f fVar) {
        if (fVar == null) {
            b((String) null);
            return;
        }
        try {
            if (chat.ola.vn.util.m.b(fVar.k, "me")) {
                this.c.a(this.d, fVar);
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.entity.m
    /* JADX INFO: renamed from: b, reason: merged with bridge method [inline-methods] */
    public chat.ola.vn.entity.f a(byte[] bArr) {
        try {
            return a("me", chat.ola.vn.util.http.c.a(bArr));
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
