package chat.ola.vn.network.a.a;

import com.google.firebase.analytics.FirebaseAnalytics;
import java.util.Map;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class r extends chat.ola.vn.entity.m<chat.ola.vn.entity.f> {
    public chat.ola.vn.p.c c;
    private long d;

    public r(long j, long j2) {
        super(j2);
        this.d = j;
    }

    private chat.ola.vn.entity.f a(String str, JSONObject jSONObject) {
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
                    String strD = chat.ola.vn.util.i.d(jSONObject.getString(FirebaseAnalytics.Param.CONTENT), "");
                    if (chat.ola.vn.util.m.a(strD)) {
                        fVar.d = "";
                    } else {
                        fVar.d = chat.ola.vn.util.i.c(strD);
                        String strG = chat.ola.vn.util.i.g(strD);
                        if (chat.ola.vn.util.m.a(strG)) {
                            String strD2 = chat.ola.vn.util.i.d(strD);
                            if (!chat.ola.vn.util.m.a(strD2)) {
                                fVar.n = strD2;
                            }
                        } else {
                            fVar.o = strG;
                        }
                    }
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
                if (jSONObject.has("mediaCode")) {
                    fVar.e = jSONObject.getString("mediaCode");
                }
                if (jSONObject.has("liked")) {
                    fVar.a(jSONObject.getBoolean("liked") ? (short) 1 : (short) 0);
                }
                if (jSONObject.has("likeCount")) {
                    fVar.r = jSONObject.getInt("likeCount");
                }
                if (jSONObject.has("replyCount")) {
                    fVar.t = jSONObject.getInt("replyCount");
                }
                if ((fVar.d == null || fVar.d.length() == 0) && chat.ola.vn.util.m.a(fVar.e) && chat.ola.vn.util.m.a(fVar.n)) {
                    if (chat.ola.vn.util.m.a(fVar.o)) {
                        return null;
                    }
                }
                return fVar;
            }
        } catch (Throwable unused3) {
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
