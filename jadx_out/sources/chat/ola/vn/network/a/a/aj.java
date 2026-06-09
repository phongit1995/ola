package chat.ola.vn.network.a.a;

import com.facebook.share.internal.MessengerShareContentUtility;
import java.util.HashMap;
import java.util.Map;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class aj extends chat.ola.vn.entity.m<chat.ola.vn.entity.z> {
    private a c;
    private String d;

    public interface a {
        void a(chat.ola.vn.entity.z zVar);

        void a(String str);
    }

    public aj(String str, a aVar, long j) {
        super(j);
        this.d = str;
        this.c = aVar;
    }

    @Override // chat.ola.vn.entity.m
    public String a() {
        try {
            HashMap map = new HashMap();
            map.put("url", this.d);
            return chat.ola.vn.util.http.a.a(chat.ola.vn.h.f(), "scrape/http/get", (Map<String, String>) map, true);
        } catch (Throwable unused) {
            return null;
        }
    }

    @Override // chat.ola.vn.entity.m
    public void a(chat.ola.vn.entity.z zVar) {
        try {
            if (zVar != null) {
                this.c.a(zVar);
            } else {
                this.c.a(this.d);
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.entity.m
    /* JADX INFO: renamed from: b, reason: merged with bridge method [inline-methods] */
    public chat.ola.vn.entity.z a(byte[] bArr) {
        try {
            JSONObject jSONObjectA = chat.ola.vn.util.http.c.a(bArr);
            String string = jSONObjectA.has("site") ? jSONObjectA.getString("site") : null;
            String string2 = jSONObjectA.has("title") ? jSONObjectA.getString("title") : null;
            String string3 = jSONObjectA.has("desc") ? jSONObjectA.getString("desc") : null;
            String string4 = jSONObjectA.has(MessengerShareContentUtility.MEDIA_IMAGE) ? jSONObjectA.getString(MessengerShareContentUtility.MEDIA_IMAGE) : null;
            String string5 = jSONObjectA.has("redirect") ? jSONObjectA.getString("redirect") : null;
            if (chat.ola.vn.util.m.a(string2) && chat.ola.vn.util.m.a(string3) && chat.ola.vn.util.m.a(string4)) {
                return null;
            }
            chat.ola.vn.entity.z zVar = new chat.ola.vn.entity.z();
            zVar.d = string;
            zVar.a = this.d;
            zVar.b = this.d;
            if (!chat.ola.vn.util.m.a(string5)) {
                zVar.b = string5;
            }
            zVar.c = string2;
            zVar.e = string3;
            zVar.f = string4;
            return zVar;
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
