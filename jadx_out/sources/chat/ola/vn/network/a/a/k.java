package chat.ola.vn.network.a.a;

import chat.ola.vn.R;
import chat.ola.vn.entity.OlaVenueEntity;
import com.facebook.accountkit.internal.AccountKitGraphConstants;
import com.facebook.share.internal.MessengerShareContentUtility;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.json.JSONArray;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class k extends chat.ola.vn.entity.m<List<OlaVenueEntity>> {
    private chat.ola.vn.p.a c;
    private String d;
    private String e;
    private String f;
    private int g;
    private int h;

    public k(String str, int i, String str2, String str3, long j) {
        super(j);
        this.g = 0;
        this.h = 0;
        this.d = str;
        this.e = str2;
        this.f = str3;
        this.g = i;
    }

    @Override // chat.ola.vn.entity.m
    public String a() {
        StringBuilder sb;
        try {
            if (chat.ola.vn.util.m.c(this.d)) {
                sb = new StringBuilder();
                sb.append("{\"lat\": ");
                sb.append(this.f);
                sb.append(", \"lon\": ");
                sb.append(this.e);
                sb.append("}");
            } else {
                sb = new StringBuilder();
                sb.append("{\"lat\": ");
                sb.append(this.f);
                sb.append(", \"lon\": ");
                sb.append(this.e);
                sb.append(",\"name\": \"");
                sb.append(this.d);
                sb.append("\"} ");
            }
            String strP = chat.ola.vn.util.m.p(sb.toString());
            if (this.g <= 0) {
                return chat.ola.vn.util.http.a.a(chat.ola.vn.h.f(), "aurora/venue/find?info=" + strP, (Map<String, String>) null, true);
            }
            return chat.ola.vn.util.http.a.a(chat.ola.vn.h.f(), "aurora/venue/find?info=" + strP + "&lmt=" + this.g, (Map<String, String>) null, true);
        } catch (Throwable th) {
            th.printStackTrace();
            return null;
        }
    }

    public void a(chat.ola.vn.p.a aVar) {
        this.c = aVar;
    }

    @Override // chat.ola.vn.entity.m
    public void a(List<OlaVenueEntity> list) {
        if (list == null) {
            b((String) null);
        } else {
            try {
                this.c.b(list, this.h);
            } catch (Throwable unused) {
            }
        }
    }

    @Override // chat.ola.vn.entity.m
    /* JADX INFO: renamed from: b, reason: merged with bridge method [inline-methods] */
    public List<OlaVenueEntity> a(byte[] bArr) {
        ArrayList arrayList = null;
        try {
            JSONObject jSONObjectA = chat.ola.vn.util.http.c.a(bArr);
            if (jSONObjectA.has("apiError")) {
                return null;
            }
            if (jSONObjectA.has("code") && jSONObjectA.getInt("code") == 0 && jSONObjectA.has(MessengerShareContentUtility.ATTACHMENT_PAYLOAD)) {
                JSONObject jSONObject = jSONObjectA.getJSONObject(MessengerShareContentUtility.ATTACHMENT_PAYLOAD);
                if (jSONObject.has("nextPage")) {
                    this.h = jSONObject.getInt("nextPage");
                } else {
                    this.h = 0;
                }
                if (jSONObject.has("venues")) {
                    JSONArray jSONArray = jSONObject.getJSONArray("venues");
                    int length = jSONArray.length();
                    for (int i = 0; i < length; i++) {
                        OlaVenueEntity olaVenueEntity = new OlaVenueEntity();
                        JSONObject jSONObject2 = jSONArray.getJSONObject(i);
                        if (jSONObject2.has(AccountKitGraphConstants.EMAIL_ADDRESS_KEY)) {
                            olaVenueEntity.d(jSONObject2.getString(AccountKitGraphConstants.EMAIL_ADDRESS_KEY));
                        }
                        if (jSONObject2.has("distanceMt")) {
                            olaVenueEntity.a(jSONObject2.getLong("distanceMt"));
                        }
                        if (jSONObject2.has("desc")) {
                            olaVenueEntity.c(jSONObject2.getString("desc"));
                        }
                        if (jSONObject2.has("mediaCode")) {
                            olaVenueEntity.e(jSONObject2.getString("mediaCode"));
                        }
                        if (jSONObject2.has("name")) {
                            olaVenueEntity.b(jSONObject2.getString("name"));
                        }
                        if (jSONObject2.has("venueId")) {
                            olaVenueEntity.a(jSONObject2.getString("venueId"));
                        }
                        if (jSONObject2.has("lon")) {
                            olaVenueEntity.f(jSONObject2.getString("lon"));
                        }
                        if (jSONObject2.has("lat")) {
                            olaVenueEntity.g(jSONObject2.getString("lat"));
                        }
                        if (jSONObject2.has("distance")) {
                            olaVenueEntity.h(jSONObject2.getString("distance"));
                        }
                        if (jSONObject2.has("checkinNo")) {
                            olaVenueEntity.a(jSONObject2.getInt("checkinNo"));
                        }
                        if (arrayList == null) {
                            arrayList = new ArrayList();
                        }
                        arrayList.add(olaVenueEntity);
                    }
                }
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
        return arrayList;
    }

    @Override // chat.ola.vn.entity.m
    public void b(String str) {
        try {
            if (chat.ola.vn.util.m.c(str)) {
                str = chat.ola.vn.c.c().getResources().getString(R.string.string_loading_check_in_venue_fail);
            }
            this.c.a((short) 1, str);
        } catch (Throwable unused) {
        }
    }
}
