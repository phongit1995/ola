package chat.ola.vn.network.a.a;

import com.google.firebase.analytics.FirebaseAnalytics;
import java.util.Map;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class x extends chat.ola.vn.entity.m<chat.ola.vn.entity.u> {
    private chat.ola.vn.p.l c;
    private String d;

    public x(String str, long j) {
        super(j);
        this.d = str;
    }

    @Override // chat.ola.vn.entity.m
    public String a() {
        try {
            if (chat.ola.vn.util.m.c(this.d)) {
                return chat.ola.vn.util.http.a.a(chat.ola.vn.h.f(), "rss/get", (Map<String, String>) null, true);
            }
            return chat.ola.vn.util.http.a.a(chat.ola.vn.h.f(), "rss/get/" + this.d, (Map<String, String>) null, true);
        } catch (Throwable unused) {
            return null;
        }
    }

    @Override // chat.ola.vn.entity.m
    public void a(chat.ola.vn.entity.u uVar) {
        if (uVar == null) {
            b((String) null);
        } else {
            try {
                this.c.a(uVar);
            } catch (Throwable unused) {
            }
        }
    }

    public void a(chat.ola.vn.p.l lVar) {
        this.c = lVar;
    }

    @Override // chat.ola.vn.entity.m
    /* JADX INFO: renamed from: b, reason: merged with bridge method [inline-methods] */
    public chat.ola.vn.entity.u a(byte[] bArr) {
        JSONObject jSONObjectA;
        try {
            jSONObjectA = chat.ola.vn.util.http.c.a(bArr);
        } catch (Throwable th) {
            th.printStackTrace();
        }
        switch (jSONObjectA.has("type") ? jSONObjectA.getInt("type") : 0) {
            case 1:
            case 2:
            case 3:
                return null;
            default:
                String string = jSONObjectA.has("title") ? jSONObjectA.getString("title") : null;
                String string2 = jSONObjectA.has(FirebaseAnalytics.Param.CONTENT) ? jSONObjectA.getString(FirebaseAnalytics.Param.CONTENT) : null;
                String string3 = jSONObjectA.has("thumbCode") ? jSONObjectA.getString("thumbCode") : null;
                if (chat.ola.vn.util.m.a(string3)) {
                    try {
                        string3 = chat.ola.vn.util.i.b((CharSequence) string2).get(0);
                    } catch (Throwable unused) {
                    }
                }
                long j = jSONObjectA.has("meId") ? Long.parseLong(jSONObjectA.getString("meId")) : 0L;
                int i = jSONObjectA.has("noLikes") ? jSONObjectA.getInt("noLikes") : 0;
                boolean z = jSONObjectA.has("liked") ? jSONObjectA.getBoolean("liked") : false;
                int i2 = jSONObjectA.has("noComments") ? jSONObjectA.getInt("noComments") : 0;
                chat.ola.vn.entity.u uVar = new chat.ola.vn.entity.u();
                uVar.d(this.d);
                uVar.a(string);
                uVar.b(string2);
                uVar.c(string3);
                uVar.a(j);
                uVar.b(i);
                uVar.a(z);
                uVar.a(i2);
                return uVar;
        }
        th.printStackTrace();
        return null;
    }

    @Override // chat.ola.vn.entity.m
    public void b(String str) {
        try {
            if (chat.ola.vn.util.m.c(str)) {
                str = "";
            }
            this.c.a((short) 0, str);
        } catch (Throwable unused) {
        }
    }
}
