package chat.ola.vn.network.a.a;

import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import com.facebook.GraphRequest;
import com.facebook.internal.NativeProtocol;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.json.JSONArray;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class w extends chat.ola.vn.entity.m<chat.ola.vn.entity.ag> {
    public chat.ola.vn.p.g c;
    public chat.ola.vn.p.d d;
    public short e;
    private String f;
    private List<String> g;
    private int h;
    private boolean i;

    public w(String str, long j) {
        super(j);
        this.g = null;
        this.h = 36;
        this.e = (short) 0;
        this.i = false;
        this.f = str;
        this.i = false;
    }

    private void a(chat.ola.vn.entity.ag agVar, String str) {
        chat.ola.vn.message.f fVar = new chat.ola.vn.message.f(agVar.c, (short) 0);
        fVar.c(str);
        agVar.a = fVar.L();
    }

    @Override // chat.ola.vn.entity.m
    public String a() {
        HashMap map = new HashMap();
        if (!chat.ola.vn.util.m.a(this.f)) {
            map.put(this.i ? "phone" : "un", this.f);
        }
        if (this.g != null && this.g.size() > 0) {
            String str = this.g.get(0);
            int size = this.g.size();
            String str2 = str;
            for (int i = 1; i < size; i++) {
                str2 = str2 + "," + this.g.get(i);
            }
            map.put(GraphRequest.FIELDS_PARAM, str2);
        }
        return chat.ola.vn.util.http.a.a(chat.ola.vn.h.f(), "id/profile", (Map<String, String>) map, true);
    }

    @Override // chat.ola.vn.entity.m
    public void a(chat.ola.vn.entity.ag agVar) {
        try {
            if (agVar != null) {
                if (this.d != null) {
                    this.d.a(agVar);
                }
            } else if (this.d != null) {
                this.d.a(this.h);
            }
        } catch (Throwable unused) {
        }
    }

    public void a(String... strArr) {
        if (strArr == null || strArr.length == 0) {
            return;
        }
        if (this.g == null) {
            this.g = new ArrayList(strArr.length);
        }
        for (String str : strArr) {
            this.g.add(str);
        }
    }

    @Override // chat.ola.vn.entity.m
    /* JADX INFO: renamed from: b, reason: merged with bridge method [inline-methods] */
    public chat.ola.vn.entity.ag a(byte[] bArr) {
        chat.ola.vn.entity.ag agVar;
        JSONArray jSONArray;
        int length;
        JSONArray jSONArray2;
        int length2;
        JSONArray jSONArray3;
        int length3;
        if (bArr != null) {
            try {
            } catch (Throwable th) {
                th = th;
                agVar = null;
            }
            if (bArr.length != 0) {
                JSONObject jSONObjectA = chat.ola.vn.util.http.c.a(bArr);
                if (jSONObjectA.has("apiError")) {
                    return null;
                }
                if (jSONObjectA.has("errorCode")) {
                    try {
                        this.h = jSONObjectA.getInt("errorCode");
                    } catch (Throwable unused) {
                    }
                }
                if (jSONObjectA.has("nick")) {
                    agVar = new chat.ola.vn.entity.ag();
                    try {
                        agVar.c = jSONObjectA.getString("nick");
                        if (jSONObjectA.has("name")) {
                            String string = jSONObjectA.getString("name");
                            agVar.k = string;
                            if (chat.ola.vn.util.m.b(agVar.c, "rss")) {
                                string = OlaApplication.a(R.string.general_tab_rss);
                            }
                            if (chat.ola.vn.util.m.b(agVar.c, "kho")) {
                                string = OlaApplication.a(R.string.general_tab_ola_mall);
                            }
                            a(agVar, string);
                        }
                        if (jSONObjectA.has("gender")) {
                            agVar.w = (byte) jSONObjectA.getInt("gender");
                        }
                        if (jSONObjectA.has("birthday")) {
                            agVar.l = jSONObjectA.getLong("birthday");
                        }
                        if (jSONObjectA.has("registerMs")) {
                            agVar.m = jSONObjectA.getLong("registerMs");
                        }
                        if (jSONObjectA.has("lastActiveAgo")) {
                            agVar.n = jSONObjectA.getLong("lastActiveAgo");
                        }
                        if (jSONObjectA.has("socialLinkType")) {
                            agVar.b = Integer.valueOf(jSONObjectA.getInt("socialLinkType"));
                        }
                        if (jSONObjectA.has("noFans")) {
                            agVar.r = Integer.valueOf(jSONObjectA.getInt("noFans")).intValue();
                        }
                        if (jSONObjectA.has("noFriends")) {
                            agVar.p = Integer.valueOf(jSONObjectA.getInt("noFriends")).intValue();
                        }
                        if (jSONObjectA.has("noMedias")) {
                            agVar.o = Integer.valueOf(jSONObjectA.getInt("noMedias")).intValue();
                        }
                        if (jSONObjectA.has("statusMessage")) {
                            agVar.d = jSONObjectA.getString("statusMessage");
                        }
                        if (jSONObjectA.has("cared")) {
                            agVar.y = jSONObjectA.getBoolean("cared");
                        }
                        if (jSONObjectA.has("isFan")) {
                            agVar.z = jSONObjectA.getBoolean("isFan");
                        }
                        if (jSONObjectA.has("blocked")) {
                            agVar.A = jSONObjectA.getBoolean("blocked");
                        }
                        if (jSONObjectA.has("boxSpouse")) {
                            agVar.e = jSONObjectA.getString("boxSpouse");
                        }
                        if (jSONObjectA.has("vip")) {
                            agVar.u = (short) jSONObjectA.getInt("vip");
                        }
                        if (jSONObjectA.has("phone")) {
                            JSONObject jSONObject = jSONObjectA.getJSONObject("phone");
                            if (jSONObject.has("number")) {
                                agVar.f = jSONObject.getString("number");
                                if (!chat.ola.vn.util.m.a(agVar.f)) {
                                    agVar.g = chat.ola.vn.util.o.c(agVar.f);
                                    agVar.f = chat.ola.vn.util.o.a(agVar.f);
                                }
                            }
                            if (jSONObject.has("verified")) {
                                agVar.x = jSONObject.getBoolean("verified");
                            }
                            if (jSONObject.has("protect")) {
                                agVar.B = jSONObject.getBoolean("protect");
                            }
                        }
                        if (jSONObjectA.has("like")) {
                            JSONObject jSONObject2 = jSONObjectA.getJSONObject("like");
                            if (jSONObject2.has("1")) {
                                agVar.s = jSONObject2.getInt("1");
                            }
                            if (jSONObject2.has("3")) {
                                agVar.t = jSONObject2.getInt("3");
                            }
                            if (jSONObject2.has("liked")) {
                                agVar.v = (short) jSONObject2.getInt("liked");
                            }
                        }
                        if (this.i) {
                            agVar.f = this.f;
                            if (!chat.ola.vn.util.m.a(agVar.f)) {
                                agVar.g = chat.ola.vn.util.o.c(agVar.f);
                                agVar.f = chat.ola.vn.util.o.a(agVar.f);
                            }
                        }
                        try {
                            if (jSONObjectA.has(NativeProtocol.AUDIENCE_FRIENDS) && (length3 = (jSONArray3 = jSONObjectA.getJSONArray(NativeProtocol.AUDIENCE_FRIENDS)).length()) > 0) {
                                agVar.i = new String[length3];
                                for (int i = 0; i < length3; i++) {
                                    agVar.i[i] = jSONArray3.getString(i);
                                }
                            }
                        } catch (Throwable unused2) {
                        }
                        try {
                            if (jSONObjectA.has("fans") && (length2 = (jSONArray2 = jSONObjectA.getJSONArray("fans")).length()) > 0) {
                                agVar.h = new String[length2];
                                for (int i2 = 0; i2 < length2; i2++) {
                                    agVar.h[i2] = jSONArray2.getString(i2);
                                }
                            }
                        } catch (Throwable unused3) {
                        }
                        try {
                            if (jSONObjectA.has("medias") && (length = (jSONArray = jSONObjectA.getJSONArray("medias")).length()) > 0) {
                                agVar.j = new String[length];
                                for (int i3 = 0; i3 < length; i3++) {
                                    agVar.j[i3] = jSONArray.getString(i3);
                                }
                            }
                        } catch (Throwable unused4) {
                        }
                    } catch (Throwable th2) {
                        th = th2;
                        th.printStackTrace();
                    }
                }
                th.printStackTrace();
            }
            agVar = null;
        } else {
            agVar = null;
        }
        if (agVar != null) {
            try {
                this.c.a(agVar, this.e);
                return agVar;
            } catch (Throwable unused5) {
            }
        } else {
            try {
                this.c.a(this.h, (short) 0, (String) null, (byte[]) null, (chat.ola.vn.entity.d[]) null, this.e);
                return agVar;
            } catch (Throwable th3) {
                th3.printStackTrace();
            }
        }
        return agVar;
    }

    @Override // chat.ola.vn.entity.m
    public void b(String str) {
    }

    public void c(String str) {
        this.f = str;
        this.i = true;
    }
}
