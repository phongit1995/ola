package chat.ola.vn.network.a.a;

import chat.ola.vn.R;
import com.facebook.accountkit.internal.AccountKitGraphConstants;
import com.facebook.share.internal.MessengerShareContentUtility;
import java.util.ArrayList;
import java.util.Map;
import java.util.Random;
import org.json.JSONArray;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class e extends chat.ola.vn.entity.m<chat.ola.vn.entity.y> {
    private chat.ola.vn.p.a c;
    private String d;

    public e(String str, long j) {
        super(j);
        this.d = str;
    }

    @Override // chat.ola.vn.entity.m
    public String a() {
        try {
            return chat.ola.vn.util.http.a.a(chat.ola.vn.h.f(), "aurora/venue/watch?id=" + this.d, (Map<String, String>) null, true);
        } catch (Throwable th) {
            th.printStackTrace();
            return null;
        }
    }

    @Override // chat.ola.vn.entity.m
    public void a(chat.ola.vn.entity.y yVar) {
        if (yVar == null) {
            b((String) null);
        } else {
            try {
                this.c.a(yVar);
            } catch (Throwable unused) {
            }
        }
    }

    public void a(chat.ola.vn.p.a aVar) {
        this.c = aVar;
    }

    @Override // chat.ola.vn.entity.m
    /* JADX INFO: renamed from: b, reason: merged with bridge method [inline-methods] */
    public chat.ola.vn.entity.y a(byte[] bArr) {
        JSONArray jSONArray;
        int length;
        try {
            JSONObject jSONObjectA = chat.ola.vn.util.http.c.a(bArr);
            if (!jSONObjectA.has("apiError") && jSONObjectA.has("code") && jSONObjectA.getInt("code") == 0 && jSONObjectA.has(MessengerShareContentUtility.ATTACHMENT_PAYLOAD)) {
                JSONObject jSONObject = jSONObjectA.getJSONObject(MessengerShareContentUtility.ATTACHMENT_PAYLOAD);
                chat.ola.vn.entity.y yVar = new chat.ola.vn.entity.y();
                if (jSONObject.has(AccountKitGraphConstants.EMAIL_ADDRESS_KEY)) {
                    yVar.d(jSONObject.getString(AccountKitGraphConstants.EMAIL_ADDRESS_KEY));
                }
                if (jSONObject.has("mediaCode")) {
                    yVar.g(jSONObject.getString("mediaCode"));
                }
                if (jSONObject.has("name")) {
                    yVar.b(jSONObject.getString("name"));
                }
                if (jSONObject.has("desc")) {
                    yVar.c(jSONObject.getString("desc"));
                }
                if (jSONObject.has("venueId")) {
                    yVar.a(jSONObject.getString("venueId"));
                }
                if (jSONObject.has("lon")) {
                    yVar.e(jSONObject.getString("lon"));
                }
                if (jSONObject.has("lat")) {
                    yVar.f(jSONObject.getString("lat"));
                }
                if (jSONObject.has("distance")) {
                    yVar.i(jSONObject.getString("distance"));
                }
                if (jSONObject.has("checkinNo")) {
                    yVar.a(jSONObject.getInt("checkinNo"));
                }
                if (jSONObject.has("mediaCodes") && (length = (jSONArray = jSONObject.getJSONArray("mediaCodes")).length()) > 0) {
                    ArrayList arrayList = new ArrayList(0);
                    int iNextInt = length > 1 ? new Random().nextInt(length) : 0;
                    for (int i = 0; i < length; i++) {
                        String str = (String) jSONArray.get(i);
                        arrayList.add(str);
                        if (length > 1 && i == iNextInt) {
                            yVar.g(str);
                        }
                    }
                    yVar.a(arrayList);
                }
                if (jSONObject.has("type")) {
                    yVar.b(jSONObject.getInt("type"));
                }
                if (jSONObject.has("wifi")) {
                    yVar.a(jSONObject.getBoolean("wifi"));
                }
                if (jSONObject.has("familiar")) {
                    JSONObject jSONObject2 = jSONObject.getJSONObject("familiar");
                    if (jSONObject2.has("userName")) {
                        yVar.h(jSONObject2.getString("userName"));
                    }
                    if (jSONObject2.has("checkinNo")) {
                        yVar.c(jSONObject2.getInt("checkinNo"));
                    }
                }
                return yVar;
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
                str = chat.ola.vn.c.c().getResources().getString(R.string.string_loading_venue_detail_fail);
            }
            this.c.a((short) 5, str);
        } catch (Throwable unused) {
        }
    }
}
