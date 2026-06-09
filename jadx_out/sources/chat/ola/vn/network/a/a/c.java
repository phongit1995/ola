package chat.ola.vn.network.a.a;

import chat.ola.vn.R;
import chat.ola.vn.entity.OlaCheckInItemEntity;
import com.facebook.share.internal.MessengerShareContentUtility;
import java.util.Map;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class c extends chat.ola.vn.entity.m<OlaCheckInItemEntity> {
    private chat.ola.vn.p.a c;
    private String d;
    private String e;
    private String f;
    private String g;
    private String h;

    public c(String str, String str2, String str3, String str4, String str5, long j) {
        super(j);
        this.d = str;
        this.f = str4;
        this.g = str5;
        this.e = str2;
        this.h = str3;
    }

    @Override // chat.ola.vn.entity.m
    public String a() {
        try {
            String str = "{\"lat\": " + this.g + ", \"lon\": " + this.f;
            if (!chat.ola.vn.util.m.c(this.d)) {
                str = str + ",\"name\": \"" + this.d + "\"";
            }
            if (!chat.ola.vn.util.m.c(this.e)) {
                str = str + ",\"mediaCode\": \"" + this.e + "\"";
            }
            if (!chat.ola.vn.util.m.c(this.h)) {
                str = str + ",\"actionId\": \"" + this.h + "\"";
            }
            String strP = chat.ola.vn.util.m.p(str + "}");
            return chat.ola.vn.util.http.a.a(chat.ola.vn.h.f(), "aurora/item/create?info=" + strP, (Map<String, String>) null, true);
        } catch (Throwable th) {
            th.printStackTrace();
            return null;
        }
    }

    @Override // chat.ola.vn.entity.m
    public void a(OlaCheckInItemEntity olaCheckInItemEntity) {
        if (olaCheckInItemEntity == null) {
            b((String) null);
        } else {
            try {
                this.c.a(olaCheckInItemEntity);
            } catch (Throwable unused) {
            }
        }
    }

    public void a(chat.ola.vn.p.a aVar) {
        this.c = aVar;
    }

    @Override // chat.ola.vn.entity.m
    /* JADX INFO: renamed from: b, reason: merged with bridge method [inline-methods] */
    public OlaCheckInItemEntity a(byte[] bArr) {
        JSONObject jSONObjectA;
        OlaCheckInItemEntity olaCheckInItemEntity = null;
        try {
            jSONObjectA = chat.ola.vn.util.http.c.a(bArr);
        } catch (Throwable th) {
            th = th;
        }
        if (jSONObjectA.has("apiError")) {
            return null;
        }
        if (jSONObjectA.has("code") && jSONObjectA.getInt("code") == 0 && jSONObjectA.has(MessengerShareContentUtility.ATTACHMENT_PAYLOAD)) {
            JSONObject jSONObject = jSONObjectA.getJSONObject(MessengerShareContentUtility.ATTACHMENT_PAYLOAD);
            OlaCheckInItemEntity olaCheckInItemEntity2 = new OlaCheckInItemEntity();
            try {
                if (jSONObject.has("id")) {
                    olaCheckInItemEntity2.a(jSONObject.getString("id"));
                }
                if (jSONObject.has("lastModified")) {
                    olaCheckInItemEntity2.a(jSONObject.getLong("lastModified"));
                }
                if (jSONObject.has("mediaCode")) {
                    olaCheckInItemEntity2.c(jSONObject.getString("mediaCode"));
                }
                if (jSONObject.has("name")) {
                    olaCheckInItemEntity2.b(jSONObject.getString("name"));
                }
                if (jSONObject.has("lon")) {
                    olaCheckInItemEntity2.d(jSONObject.getString("lon"));
                }
                if (jSONObject.has("actionId")) {
                    olaCheckInItemEntity2.f(jSONObject.getString("checkInItem.getString"));
                }
                if (jSONObject.has("lat")) {
                    olaCheckInItemEntity2.e(jSONObject.getString("lat"));
                }
                return olaCheckInItemEntity2;
            } catch (Throwable th2) {
                th = th2;
                olaCheckInItemEntity = olaCheckInItemEntity2;
            }
        }
        return olaCheckInItemEntity;
        th.printStackTrace();
        return olaCheckInItemEntity;
    }

    @Override // chat.ola.vn.entity.m
    public void b(String str) {
        try {
            if (chat.ola.vn.util.m.c(str)) {
                str = chat.ola.vn.c.c().getResources().getString(R.string.string_create_to_check_in_item_fail);
            }
            this.c.a((short) 4, str);
        } catch (Throwable unused) {
        }
    }
}
