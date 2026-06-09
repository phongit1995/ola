package chat.ola.vn.network.a.a;

import chat.ola.vn.R;
import com.facebook.share.internal.MessengerShareContentUtility;
import java.util.Map;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class i extends chat.ola.vn.entity.m<String> {
    private chat.ola.vn.p.a c;
    private String d;
    private String e;
    private String f;

    public i(String str, String str2, String str3, long j) {
        super(j);
        this.d = str;
        this.e = str2;
        this.f = str3;
    }

    @Override // chat.ola.vn.entity.m
    public String a() {
        StringBuilder sb;
        String str;
        try {
            if (chat.ola.vn.util.m.c(this.d) && chat.ola.vn.util.m.c(this.f)) {
                sb = new StringBuilder();
                sb.append("{\"venueId\":\"");
                sb.append(this.e);
                str = "\"}";
            } else if (chat.ola.vn.util.m.c(this.f)) {
                sb = new StringBuilder();
                sb.append("{ \"actionId\":\"");
                sb.append(this.d);
                sb.append("\",\"venueId\":\"");
                sb.append(this.e);
                str = "\"}";
            } else if (chat.ola.vn.util.m.c(this.d)) {
                sb = new StringBuilder();
                sb.append("{\"venueId\":\"");
                sb.append(this.e);
                sb.append("\",\"itemIds\":[\"");
                sb.append(this.f);
                str = "\"]}";
            } else {
                sb = new StringBuilder();
                sb.append("{ \"actionId\":\"");
                sb.append(this.d);
                sb.append("\",\"venueId\":\"");
                sb.append(this.e);
                sb.append("\",\"itemIds\":[\"");
                sb.append(this.f);
                str = "\"]}";
            }
            sb.append(str);
            String strP = chat.ola.vn.util.m.p(sb.toString());
            return chat.ola.vn.util.http.a.a(chat.ola.vn.h.f(), "aurora/preparecheckin?info=" + strP, (Map<String, String>) null, true);
        } catch (Throwable unused) {
            return null;
        }
    }

    public void a(chat.ola.vn.p.a aVar) {
        this.c = aVar;
    }

    @Override // chat.ola.vn.entity.m
    /* JADX INFO: renamed from: b, reason: merged with bridge method [inline-methods] */
    public String a(byte[] bArr) {
        try {
            JSONObject jSONObjectA = chat.ola.vn.util.http.c.a(bArr);
            if (!jSONObjectA.has("apiError") && jSONObjectA.has("code") && jSONObjectA.getInt("code") == 0 && jSONObjectA.has(MessengerShareContentUtility.ATTACHMENT_PAYLOAD)) {
                return jSONObjectA.getString(MessengerShareContentUtility.ATTACHMENT_PAYLOAD);
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
        return null;
    }

    @Override // chat.ola.vn.entity.m
    public void b(String str) {
        try {
            if (chat.ola.vn.util.m.c(str)) {
                str = chat.ola.vn.c.c().getResources().getString(R.string.string_prepare_check_in_fail);
            }
            this.c.a((short) 7, str);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.entity.m
    /* JADX INFO: renamed from: c, reason: merged with bridge method [inline-methods] */
    public void a(String str) {
        if (str == null) {
            b((String) null);
        } else {
            try {
                this.c.f(str);
            } catch (Throwable unused) {
            }
        }
    }
}
