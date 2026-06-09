package chat.ola.vn.network.a.a;

import chat.ola.vn.R;
import chat.ola.vn.entity.OlaCheckInActionEntity;
import chat.ola.vn.entity.OlaCheckInItemEntity;
import chat.ola.vn.entity.OlaVenueEntity;
import com.facebook.accountkit.internal.AccountKitGraphConstants;
import com.facebook.internal.NativeProtocol;
import com.facebook.share.internal.MessengerShareContentUtility;
import java.util.ArrayList;
import java.util.Map;
import org.json.JSONArray;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class f extends chat.ola.vn.entity.m<chat.ola.vn.entity.o> {
    private chat.ola.vn.p.a c;
    private String d;

    public f(String str, long j) {
        super(j);
        this.d = str;
    }

    @Override // chat.ola.vn.entity.m
    public String a() {
        if (chat.ola.vn.util.m.c(this.d)) {
            return null;
        }
        return chat.ola.vn.util.http.a.a(chat.ola.vn.h.f(), "aurora/checkin/get/full?chid=" + this.d, (Map<String, String>) null, true);
    }

    @Override // chat.ola.vn.entity.m
    public void a(chat.ola.vn.entity.o oVar) {
        if (oVar == null) {
            b((String) null);
        } else {
            try {
                this.c.a(oVar);
            } catch (Throwable unused) {
            }
        }
    }

    public void a(chat.ola.vn.p.a aVar) {
        this.c = aVar;
    }

    @Override // chat.ola.vn.entity.m
    /* JADX INFO: renamed from: b, reason: merged with bridge method [inline-methods] */
    public chat.ola.vn.entity.o a(byte[] bArr) {
        try {
            JSONObject jSONObjectA = chat.ola.vn.util.http.c.a(bArr);
            if (!jSONObjectA.has("apiError") && jSONObjectA.has("code") && jSONObjectA.getInt("code") == 0 && jSONObjectA.has(MessengerShareContentUtility.ATTACHMENT_PAYLOAD)) {
                JSONObject jSONObject = jSONObjectA.getJSONObject(MessengerShareContentUtility.ATTACHMENT_PAYLOAD);
                chat.ola.vn.entity.o oVar = new chat.ola.vn.entity.o();
                if (jSONObject.has("id")) {
                    oVar.a(jSONObject.getString("id"));
                }
                if (jSONObject.has("username")) {
                    oVar.b(jSONObject.getString("username"));
                }
                if (jSONObject.has("createTime")) {
                    oVar.a(jSONObject.getLong("createTime"));
                }
                if (jSONObject.has(NativeProtocol.WEB_DIALOG_ACTION)) {
                    JSONObject jSONObject2 = jSONObject.getJSONObject(NativeProtocol.WEB_DIALOG_ACTION);
                    OlaCheckInActionEntity olaCheckInActionEntity = new OlaCheckInActionEntity();
                    if (jSONObject2.has("id")) {
                        olaCheckInActionEntity.a(jSONObject2.getString("id"));
                    }
                    if (jSONObject2.has("name")) {
                        olaCheckInActionEntity.b(jSONObject2.getString("name"));
                    }
                    if (jSONObject2.has("icon")) {
                        olaCheckInActionEntity.c(jSONObject2.getString("icon"));
                    }
                    oVar.a(olaCheckInActionEntity);
                }
                if (jSONObject.has("venue")) {
                    JSONObject jSONObject3 = jSONObject.getJSONObject("venue");
                    OlaVenueEntity olaVenueEntity = new OlaVenueEntity();
                    if (jSONObject3.has("name")) {
                        olaVenueEntity.b(jSONObject3.getString("name"));
                    }
                    if (jSONObject3.has(AccountKitGraphConstants.EMAIL_ADDRESS_KEY)) {
                        olaVenueEntity.d(jSONObject3.getString(AccountKitGraphConstants.EMAIL_ADDRESS_KEY));
                    }
                    if (jSONObject3.has("mediaCode")) {
                        olaVenueEntity.e(jSONObject3.getString("mediaCode"));
                    }
                    if (jSONObject3.has("distance")) {
                        olaVenueEntity.h(jSONObject3.getString("distance"));
                    }
                    if (jSONObject3.has("venueId")) {
                        olaVenueEntity.a(jSONObject3.getString("venueId"));
                    }
                    oVar.a(olaVenueEntity);
                }
                if (jSONObject.has("items")) {
                    JSONArray jSONArray = jSONObject.getJSONArray("items");
                    int length = jSONArray.length();
                    ArrayList arrayList = null;
                    for (int i = 0; i < length; i++) {
                        OlaCheckInItemEntity olaCheckInItemEntity = new OlaCheckInItemEntity();
                        JSONObject jSONObject4 = jSONArray.getJSONObject(i);
                        if (jSONObject4.has("lastModified")) {
                            olaCheckInItemEntity.a(jSONObject4.getLong("lastModified"));
                        }
                        if (jSONObject4.has("mediaCode")) {
                            olaCheckInItemEntity.c(jSONObject4.getString("mediaCode"));
                        }
                        if (jSONObject4.has("name")) {
                            olaCheckInItemEntity.b(jSONObject4.getString("name"));
                        }
                        if (jSONObject4.has("id")) {
                            olaCheckInItemEntity.a(jSONObject4.getString("id"));
                        }
                        if (jSONObject4.has("lon")) {
                            olaCheckInItemEntity.d(jSONObject4.getString("lon"));
                        }
                        if (jSONObject4.has("lat")) {
                            olaCheckInItemEntity.e(jSONObject4.getString("lat"));
                        }
                        if (arrayList == null) {
                            arrayList = new ArrayList();
                        }
                        arrayList.add(olaCheckInItemEntity);
                    }
                    oVar.a(arrayList);
                }
                return oVar;
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
                str = chat.ola.vn.c.c().getResources().getString(R.string.string_loading_check_in_info_fail);
            }
            this.c.a((short) 8, str);
        } catch (Throwable unused) {
        }
    }
}
