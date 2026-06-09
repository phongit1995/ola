package chat.ola.vn.network.a.a;

import com.facebook.share.internal.MessengerShareContentUtility;
import java.util.Map;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class ac extends chat.ola.vn.entity.m<chat.ola.vn.entity.ai> {
    public chat.ola.vn.p.o c;
    private String d;

    public ac(String str, long j) {
        super(j);
        this.d = str;
    }

    @Override // chat.ola.vn.entity.m
    public String a() {
        if (chat.ola.vn.util.m.a(this.d)) {
            return null;
        }
        return chat.ola.vn.util.http.a.a(chat.ola.vn.h.f(), "mall/yt?id=" + this.d, (Map<String, String>) null, true);
    }

    @Override // chat.ola.vn.entity.m
    public void a(chat.ola.vn.entity.ai aiVar) {
        if (this.c != null) {
            if (aiVar != null) {
                this.c.a(aiVar);
            } else {
                b((String) null);
            }
        }
    }

    @Override // chat.ola.vn.entity.m
    /* JADX INFO: renamed from: b, reason: merged with bridge method [inline-methods] */
    public chat.ola.vn.entity.ai a(byte[] bArr) {
        chat.ola.vn.entity.ai aiVar;
        try {
            JSONObject jSONObjectA = chat.ola.vn.util.http.c.a(bArr);
            try {
                aiVar = new chat.ola.vn.entity.ai();
                try {
                    aiVar.c = this.d;
                    JSONObject jSONObject = jSONObjectA.getJSONObject(MessengerShareContentUtility.ATTACHMENT_PAYLOAD);
                    if (jSONObject.has("title")) {
                        aiVar.a = jSONObject.getString("title");
                    }
                    if (jSONObject.has("duration")) {
                        aiVar.e = jSONObject.getInt("duration");
                        aiVar.d = com.mg.ola.common.d.i.a(aiVar.e, ":", ":");
                    }
                    if (jSONObject.has("hqThumbnailUrl")) {
                        aiVar.b = jSONObject.getString("hqThumbnailUrl");
                    }
                } catch (Throwable unused) {
                }
            } catch (Throwable unused2) {
                aiVar = null;
            }
            return aiVar;
        } catch (Throwable unused3) {
            return null;
        }
    }

    @Override // chat.ola.vn.entity.m
    public void b(String str) {
        if (this.c != null) {
            this.c.a();
        }
    }
}
