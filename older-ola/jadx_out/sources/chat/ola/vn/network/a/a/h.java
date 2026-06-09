package chat.ola.vn.network.a.a;

import chat.ola.vn.R;
import com.facebook.places.model.PlaceFields;
import com.facebook.share.internal.MessengerShareContentUtility;
import com.google.firebase.analytics.FirebaseAnalytics;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.json.JSONArray;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class h extends chat.ola.vn.entity.m<List<chat.ola.vn.entity.g>> {
    private chat.ola.vn.p.a c;
    private String d;
    private long e;
    private long f;

    public h(String str, long j, long j2) {
        super(j2);
        this.d = str;
        this.e = j;
    }

    @Override // chat.ola.vn.entity.m
    public String a() {
        try {
            if (this.e <= 0) {
                return chat.ola.vn.util.http.a.a(chat.ola.vn.h.f(), "aurora/checkin/list?id=" + this.d, (Map<String, String>) null, true);
            }
            return chat.ola.vn.util.http.a.a(chat.ola.vn.h.f(), "aurora/checkin/list?id=" + this.d + "&mid=" + this.e, (Map<String, String>) null, true);
        } catch (Throwable th) {
            th.printStackTrace();
            return null;
        }
    }

    public void a(chat.ola.vn.p.a aVar) {
        this.c = aVar;
    }

    @Override // chat.ola.vn.entity.m
    public void a(List<chat.ola.vn.entity.g> list) {
        if (list == null) {
            b((String) null);
        } else {
            try {
                this.c.a(list, this.f);
            } catch (Throwable unused) {
            }
        }
    }

    @Override // chat.ola.vn.entity.m
    /* JADX INFO: renamed from: b, reason: merged with bridge method [inline-methods] */
    public List<chat.ola.vn.entity.g> a(byte[] bArr) {
        try {
            JSONObject jSONObjectA = chat.ola.vn.util.http.c.a(bArr);
            if (!jSONObjectA.has("apiError") && jSONObjectA.has("code") && jSONObjectA.getInt("code") == 0 && jSONObjectA.has(MessengerShareContentUtility.ATTACHMENT_PAYLOAD)) {
                JSONObject jSONObject = jSONObjectA.getJSONObject(MessengerShareContentUtility.ATTACHMENT_PAYLOAD);
                ArrayList arrayList = new ArrayList(0);
                if (jSONObject.has("nextMeId")) {
                    this.f = jSONObject.getLong("nextMeId");
                } else {
                    this.f = 0L;
                }
                if (jSONObject.has(PlaceFields.CHECKINS)) {
                    JSONArray jSONArray = jSONObject.getJSONArray(PlaceFields.CHECKINS);
                    int length = jSONArray.length();
                    for (int i = 0; i < length; i++) {
                        chat.ola.vn.entity.g gVar = new chat.ola.vn.entity.g();
                        JSONObject jSONObject2 = jSONArray.getJSONObject(i);
                        if (jSONObject2.has("meId")) {
                            gVar.b(Long.parseLong(jSONObject2.getString("meId")));
                        }
                        if (jSONObject2.has(FirebaseAnalytics.Param.CONTENT)) {
                            gVar.b(jSONObject2.getString(FirebaseAnalytics.Param.CONTENT));
                        }
                        if (jSONObject2.has("username")) {
                            gVar.a(jSONObject2.getString("username"));
                        }
                        if (jSONObject2.has("id")) {
                            gVar.k(jSONObject2.getString("id"));
                        }
                        if (jSONObject2.has("createTime")) {
                            long j = jSONObject2.getLong("createTime");
                            gVar.a(System.currentTimeMillis() - j);
                            gVar.c(j);
                        }
                        if (jSONObject2.has("mediaCode")) {
                            gVar.c(jSONObject2.getString("mediaCode"));
                        }
                        if (jSONObject2.has("timeAgo")) {
                            gVar.a(jSONObject2.getLong("timeAgo"));
                        }
                        gVar.d((short) 0);
                        arrayList.add(gVar);
                    }
                }
                return arrayList;
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
                str = chat.ola.vn.c.c().getResources().getString(R.string.string_loading_me_list_fail);
            }
            this.c.a((short) 6, str);
        } catch (Throwable unused) {
        }
    }
}
