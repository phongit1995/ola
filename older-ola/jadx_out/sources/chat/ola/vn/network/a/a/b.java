package chat.ola.vn.network.a.a;

import chat.ola.vn.R;
import chat.ola.vn.entity.OlaCheckInActionEntity;
import chat.ola.vn.entity.OlaCheckInItemEntity;
import com.facebook.share.internal.MessengerShareContentUtility;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.json.JSONArray;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class b extends chat.ola.vn.entity.m<List<OlaCheckInActionEntity>> {
    private chat.ola.vn.p.a c;
    private String d;

    public b(String str, long j) {
        super(j);
        this.d = str;
    }

    @Override // chat.ola.vn.entity.m
    public String a() {
        return chat.ola.vn.util.http.a.a(chat.ola.vn.h.f(), "aurora/action", (Map<String, String>) null, true);
    }

    public void a(chat.ola.vn.p.a aVar) {
        this.c = aVar;
    }

    @Override // chat.ola.vn.entity.m
    public void a(List<OlaCheckInActionEntity> list) {
        if (list == null) {
            b((String) null);
        } else {
            try {
                this.c.c(list);
            } catch (Throwable unused) {
            }
        }
    }

    @Override // chat.ola.vn.entity.m
    /* JADX INFO: renamed from: b, reason: merged with bridge method [inline-methods] */
    public List<OlaCheckInActionEntity> a(byte[] bArr) {
        JSONObject jSONObjectA;
        ArrayList arrayList = null;
        try {
            jSONObjectA = chat.ola.vn.util.http.c.a(bArr);
        } catch (Throwable th) {
            th = th;
        }
        if (jSONObjectA.has("apiError")) {
            return null;
        }
        if (jSONObjectA.has("code") && jSONObjectA.getInt("code") == 0 && jSONObjectA.has(MessengerShareContentUtility.ATTACHMENT_PAYLOAD)) {
            JSONArray jSONArray = jSONObjectA.getJSONArray(MessengerShareContentUtility.ATTACHMENT_PAYLOAD);
            int length = jSONArray.length();
            ArrayList arrayList2 = null;
            for (int i = 0; i < length; i++) {
                try {
                    OlaCheckInActionEntity olaCheckInActionEntity = new OlaCheckInActionEntity();
                    JSONObject jSONObject = jSONArray.getJSONObject(i);
                    if (jSONObject.has("id")) {
                        olaCheckInActionEntity.a(jSONObject.getString("id"));
                    }
                    if (jSONObject.has("name")) {
                        olaCheckInActionEntity.b(jSONObject.getString("name"));
                    }
                    if (jSONObject.has("icon")) {
                        olaCheckInActionEntity.c(jSONObject.getString("icon"));
                    }
                    if (jSONObject.has("placeholder")) {
                        olaCheckInActionEntity.d(jSONObject.getString("placeholder"));
                    }
                    if (arrayList2 == null) {
                        arrayList2 = new ArrayList();
                    }
                    if (jSONObject.has("allowDefined")) {
                        olaCheckInActionEntity.a(jSONObject.getBoolean("allowDefined"));
                    }
                    if (jSONObject.has("items")) {
                        try {
                            JSONArray jSONArray2 = jSONObject.getJSONArray("items");
                            ArrayList arrayList3 = new ArrayList(0);
                            for (int i2 = 0; i2 < jSONArray2.length(); i2++) {
                                JSONObject jSONObject2 = jSONArray2.getJSONObject(i2);
                                OlaCheckInItemEntity olaCheckInItemEntity = new OlaCheckInItemEntity();
                                if (jSONObject2.has("mediaCode")) {
                                    olaCheckInItemEntity.c(jSONObject2.getString("mediaCode"));
                                }
                                if (jSONObject2.has("name")) {
                                    olaCheckInItemEntity.b(jSONObject2.getString("name"));
                                }
                                if (jSONObject2.has("id")) {
                                    olaCheckInItemEntity.a(jSONObject2.getString("id"));
                                }
                                arrayList3.add(olaCheckInItemEntity);
                            }
                            olaCheckInActionEntity.a(arrayList3);
                        } catch (Throwable th2) {
                            th2.printStackTrace();
                        }
                    }
                    if (jSONObject.has("icons")) {
                        try {
                            JSONArray jSONArray3 = jSONObject.getJSONArray("icons");
                            int length2 = jSONArray3.length();
                            if (length2 > 0) {
                                ArrayList arrayList4 = new ArrayList(0);
                                for (int i3 = 0; i3 < length2; i3++) {
                                    arrayList4.add((String) jSONArray3.get(i3));
                                }
                                olaCheckInActionEntity.b(arrayList4);
                            }
                        } catch (Throwable th3) {
                            th3.printStackTrace();
                        }
                    }
                    arrayList2.add(olaCheckInActionEntity);
                } catch (Throwable th4) {
                    th = th4;
                    arrayList = arrayList2;
                }
            }
            return arrayList2;
        }
        return arrayList;
        th.printStackTrace();
        return arrayList;
    }

    @Override // chat.ola.vn.entity.m
    public void b(String str) {
        try {
            if (chat.ola.vn.util.m.c(str)) {
                str = chat.ola.vn.c.c().getResources().getString(R.string.string_loading_check_in_action_fail);
            }
            this.c.a((short) 0, str);
        } catch (Throwable unused) {
        }
    }
}
