package chat.ola.vn.network.a.a;

import chat.ola.vn.R;
import chat.ola.vn.entity.OlaCheckInItemEntity;
import com.facebook.share.internal.MessengerShareContentUtility;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.json.JSONArray;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class g extends chat.ola.vn.entity.m<List<OlaCheckInItemEntity>> {
    private chat.ola.vn.p.a c;
    private String d;
    private String e;
    private String f;
    private int g;
    private int h;
    private String i;

    public g(String str, String str2, int i, String str3, String str4, long j) {
        super(j);
        this.g = 0;
        this.h = 0;
        this.d = str;
        this.e = str3;
        this.f = str4;
        this.g = i;
        this.i = str2;
    }

    @Override // chat.ola.vn.entity.m
    public String a() {
        try {
            String str = "{\"lat\": " + this.f + ", \"lon\": " + this.e;
            if (!chat.ola.vn.util.m.c(this.d)) {
                str = str + ",\"name\": \"" + this.d + "\"";
            }
            if (!chat.ola.vn.util.m.c(this.i)) {
                str = str + ",\"actionId\": \"" + this.i + "\"";
            }
            String strP = chat.ola.vn.util.m.p(str + "} ");
            if (this.g <= 0) {
                return chat.ola.vn.util.http.a.a(chat.ola.vn.h.f(), "aurora/item/find?info=" + strP, (Map<String, String>) null, true);
            }
            return chat.ola.vn.util.http.a.a(chat.ola.vn.h.f(), "aurora/item/find?info=" + strP + "&lmt=" + this.g, (Map<String, String>) null, true);
        } catch (Throwable th) {
            th.printStackTrace();
            return null;
        }
    }

    public void a(chat.ola.vn.p.a aVar) {
        this.c = aVar;
    }

    @Override // chat.ola.vn.entity.m
    public void a(List<OlaCheckInItemEntity> list) {
        if (list == null) {
            b((String) null);
        } else {
            try {
                this.c.c(list, this.h);
            } catch (Throwable unused) {
            }
        }
    }

    @Override // chat.ola.vn.entity.m
    /* JADX INFO: renamed from: b, reason: merged with bridge method [inline-methods] */
    public List<OlaCheckInItemEntity> a(byte[] bArr) {
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
                if (jSONObject.has("items")) {
                    JSONArray jSONArray = jSONObject.getJSONArray("items");
                    int length = jSONArray.length();
                    for (int i = 0; i < length; i++) {
                        OlaCheckInItemEntity olaCheckInItemEntity = new OlaCheckInItemEntity();
                        JSONObject jSONObject2 = jSONArray.getJSONObject(i);
                        if (jSONObject2.has("lastModified")) {
                            olaCheckInItemEntity.a(jSONObject2.getLong("lastModified"));
                        }
                        if (jSONObject2.has("mediaCode")) {
                            olaCheckInItemEntity.c(jSONObject2.getString("mediaCode"));
                        }
                        if (jSONObject2.has("name")) {
                            olaCheckInItemEntity.b(jSONObject2.getString("name"));
                        }
                        if (jSONObject2.has("id")) {
                            olaCheckInItemEntity.a(jSONObject2.getString("id"));
                        }
                        if (jSONObject2.has("lon")) {
                            olaCheckInItemEntity.d(jSONObject2.getString("lon"));
                        }
                        if (jSONObject2.has("lat")) {
                            olaCheckInItemEntity.e(jSONObject2.getString("lat"));
                        }
                        if (arrayList == null) {
                            arrayList = new ArrayList();
                        }
                        arrayList.add(olaCheckInItemEntity);
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
                str = chat.ola.vn.c.c().getResources().getString(R.string.string_loading_check_in_item_fail);
            }
            this.c.a((short) 2, str);
        } catch (Throwable unused) {
        }
    }
}
