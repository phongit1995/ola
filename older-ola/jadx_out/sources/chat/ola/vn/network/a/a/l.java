package chat.ola.vn.network.a.a;

import chat.ola.vn.entity.OlaVenueEntity;
import com.facebook.accountkit.internal.AccountKitGraphConstants;
import com.facebook.share.internal.MessengerShareContentUtility;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.json.JSONArray;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class l extends chat.ola.vn.entity.m<List<OlaVenueEntity>> {
    private a c;
    private String d;
    private String e;
    private double f;
    private int g;

    public interface a {
        void a(int i, String str);

        void a(List<OlaVenueEntity> list);
    }

    public l(double d, int i, String str, String str2, long j) {
        super(j);
        this.d = str;
        this.e = str2;
        this.f = d;
        this.g = i;
    }

    @Override // chat.ola.vn.entity.m
    public String a() {
        try {
            String str = "lon=" + this.d + "&lat=" + this.e + "&dist=" + this.f + "&size=" + this.g;
            return chat.ola.vn.util.http.a.a(chat.ola.vn.h.f(), "aurora/venue/find/opt?" + str, (Map<String, String>) null, true);
        } catch (Throwable th) {
            th.printStackTrace();
            return null;
        }
    }

    public void a(a aVar) {
        this.c = aVar;
    }

    @Override // chat.ola.vn.entity.m
    public void a(List<OlaVenueEntity> list) {
        if (list == null) {
            b((String) null);
        } else {
            try {
                this.c.a(list);
            } catch (Throwable unused) {
            }
        }
    }

    @Override // chat.ola.vn.entity.m
    /* JADX INFO: renamed from: b, reason: merged with bridge method [inline-methods] */
    public List<OlaVenueEntity> a(byte[] bArr) {
        try {
            JSONObject jSONObjectA = chat.ola.vn.util.http.c.a(bArr);
            if (jSONObjectA.has("apiError") || !jSONObjectA.has("code") || jSONObjectA.getInt("code") != 0 || !jSONObjectA.has(MessengerShareContentUtility.ATTACHMENT_PAYLOAD)) {
                return null;
            }
            JSONObject jSONObject = jSONObjectA.getJSONObject(MessengerShareContentUtility.ATTACHMENT_PAYLOAD);
            if (!jSONObject.has("venues")) {
                return null;
            }
            JSONArray jSONArray = jSONObject.getJSONArray("venues");
            int length = jSONArray.length();
            ArrayList arrayList = null;
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
            return arrayList;
        } catch (Throwable unused) {
            return null;
        }
    }

    @Override // chat.ola.vn.entity.m
    public void b(String str) {
        try {
            this.c.a(1, str);
        } catch (Throwable unused) {
        }
    }
}
