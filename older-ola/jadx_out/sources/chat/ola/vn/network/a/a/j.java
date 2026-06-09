package chat.ola.vn.network.a.a;

import chat.ola.vn.R;
import chat.ola.vn.entity.OlaVenueEntity;
import com.facebook.accountkit.internal.AccountKitGraphConstants;
import com.facebook.share.internal.MessengerShareContentUtility;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class j extends chat.ola.vn.entity.m<OlaVenueEntity> {
    private chat.ola.vn.p.a c;
    private String d;
    private String e;
    private String f;
    private List<String> g;
    private String h;

    /* JADX WARN: Unreachable blocks removed: 1, instructions: 1 */
    public j(String str, String str2, List<String> list, String str3, String str4, long j) {
        super(j);
        this.h = str;
        this.d = str2;
        this.e = str3;
        this.f = str4;
        this.g = list != null ? new ArrayList(list) : new ArrayList(0);
    }

    @Override // chat.ola.vn.entity.m
    public String a() {
        try {
            String str = chat.ola.vn.util.m.c(this.h) ? "{" : "{\"id\": \"" + this.h + "\"";
            if (!chat.ola.vn.util.m.c(this.d)) {
                str = str + ",\"name\": \"" + this.d + "\"";
            }
            if (!chat.ola.vn.util.m.c(this.f)) {
                str = str + ",\"address\": \"" + this.f + "\"";
            }
            if (!chat.ola.vn.util.m.c(this.e)) {
                str = str + ",\"desc\": \"" + this.e + "\"";
            }
            if (this.g != null && this.g.size() > 0) {
                String str2 = str + ",\"medias\":[";
                for (int i = 0; i < this.g.size(); i++) {
                    str2 = str2 + ("\"" + this.g.get(i) + "\"");
                    if (i < this.g.size() - 1) {
                        str2 = str2 + ",";
                    }
                }
                str = str2 + "]";
            }
            return chat.ola.vn.util.http.a.a(chat.ola.vn.h.f(), "aurora/venue/update?info=" + chat.ola.vn.util.m.p(str + "}"), (Map<String, String>) null, true);
        } catch (Throwable th) {
            th.printStackTrace();
            return null;
        }
    }

    @Override // chat.ola.vn.entity.m
    public void a(OlaVenueEntity olaVenueEntity) {
        if (olaVenueEntity == null) {
            b((String) null);
        } else {
            try {
                this.c.b(olaVenueEntity);
            } catch (Throwable unused) {
            }
        }
    }

    public void a(chat.ola.vn.p.a aVar) {
        this.c = aVar;
    }

    @Override // chat.ola.vn.entity.m
    /* JADX INFO: renamed from: b, reason: merged with bridge method [inline-methods] */
    public OlaVenueEntity a(byte[] bArr) {
        JSONObject jSONObjectA;
        OlaVenueEntity olaVenueEntity = null;
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
            OlaVenueEntity olaVenueEntity2 = new OlaVenueEntity();
            try {
                if (jSONObject.has(AccountKitGraphConstants.EMAIL_ADDRESS_KEY)) {
                    olaVenueEntity2.d(jSONObject.getString(AccountKitGraphConstants.EMAIL_ADDRESS_KEY));
                }
                if (jSONObject.has("desc")) {
                    olaVenueEntity2.c(jSONObject.getString("desc"));
                }
                if (jSONObject.has("mediaCode")) {
                    olaVenueEntity2.e(jSONObject.getString("mediaCode"));
                }
                if (jSONObject.has("name")) {
                    olaVenueEntity2.b(jSONObject.getString("name"));
                }
                if (jSONObject.has("venueId")) {
                    olaVenueEntity2.a(jSONObject.getString("venueId"));
                }
                if (jSONObject.has("lon")) {
                    olaVenueEntity2.f(jSONObject.getString("lon"));
                }
                if (jSONObject.has("lat")) {
                    olaVenueEntity2.g(jSONObject.getString("lat"));
                }
                if (jSONObject.has("distance")) {
                    olaVenueEntity2.h(jSONObject.getString("distance"));
                }
                if (jSONObject.has("checkinNo")) {
                    olaVenueEntity2.a(jSONObject.getInt("checkinNo"));
                }
                return olaVenueEntity2;
            } catch (Throwable th2) {
                th = th2;
                olaVenueEntity = olaVenueEntity2;
            }
        }
        return olaVenueEntity;
        th.printStackTrace();
        return olaVenueEntity;
    }

    @Override // chat.ola.vn.entity.m
    public void b(String str) {
        try {
            if (chat.ola.vn.util.m.c(str)) {
                chat.ola.vn.c.c().getResources().getString(R.string.string_update_venue_info_fail);
            }
            this.c.a((short) 9, (String) null);
        } catch (Throwable unused) {
        }
    }
}
