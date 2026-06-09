package chat.ola.vn.network.a.a;

import com.facebook.share.internal.MessengerShareContentUtility;
import java.util.Map;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class v extends chat.ola.vn.entity.m<chat.ola.vn.entity.p> {
    private chat.ola.vn.p.q c;
    private String d;
    private String e;

    public v(String str, String str2, long j) {
        super(j);
        this.d = str2;
        this.e = str;
    }

    @Override // chat.ola.vn.entity.m
    public String a() {
        return chat.ola.vn.util.http.a.a(chat.ola.vn.h.f(), "pay/ginapp/payload?packageName=" + this.e + "&productId=" + this.d, (Map<String, String>) null, true);
    }

    @Override // chat.ola.vn.entity.m
    public void a(chat.ola.vn.entity.p pVar) {
        if (pVar == null) {
            b((String) null);
        } else {
            try {
                this.c.a(pVar);
            } catch (Throwable unused) {
            }
        }
    }

    public void a(chat.ola.vn.p.q qVar) {
        this.c = qVar;
    }

    @Override // chat.ola.vn.entity.m
    /* JADX INFO: renamed from: b, reason: merged with bridge method [inline-methods] */
    public chat.ola.vn.entity.p a(byte[] bArr) throws JSONException {
        try {
            JSONObject jSONObjectA = chat.ola.vn.util.http.c.a(bArr);
            int i = 0;
            if (jSONObjectA.has("apiError")) {
                return null;
            }
            if (jSONObjectA.has("errorCode")) {
                try {
                    i = jSONObjectA.getInt("errorCode");
                } catch (Throwable unused) {
                }
            }
            if (i == 0 && jSONObjectA.has("productId")) {
                String string = jSONObjectA.getString("productId");
                if (jSONObjectA.has(MessengerShareContentUtility.ATTACHMENT_PAYLOAD)) {
                    String string2 = jSONObjectA.getString(MessengerShareContentUtility.ATTACHMENT_PAYLOAD);
                    chat.ola.vn.entity.p pVar = new chat.ola.vn.entity.p();
                    pVar.e = string2;
                    pVar.f = string;
                    return pVar;
                }
            }
        } catch (Throwable unused2) {
        }
        return null;
    }

    @Override // chat.ola.vn.entity.m
    public void b(String str) {
        try {
            this.c.b();
        } catch (Throwable unused) {
        }
    }
}
