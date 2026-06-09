package chat.ola.vn.network.a.a;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import org.json.JSONArray;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class ab extends chat.ola.vn.entity.m<List<chat.ola.vn.entity.l>> {
    private chat.ola.vn.p.n c;
    private String d;
    private String e;
    private String f;
    private List<chat.ola.vn.entity.i> g;

    public ab(long j) {
        super(j);
        this.d = null;
        this.e = null;
        this.g = null;
        this.e = null;
    }

    public ab(String str, long j) {
        super(j);
        this.d = null;
        this.e = null;
        this.g = null;
        if (!chat.ola.vn.util.m.a(str) && str.toLowerCase(Locale.US).startsWith("http") && str.indexOf("json/") > 0) {
            str = str.substring(str.indexOf("json/") + 5);
        }
        this.e = str;
    }

    @Override // chat.ola.vn.entity.m
    public String a() {
        try {
            return !chat.ola.vn.util.m.a(this.e) ? chat.ola.vn.util.http.a.a(chat.ola.vn.h.f(), this.e, true) : chat.ola.vn.util.http.a.a(chat.ola.vn.h.f(), "gallery", true);
        } catch (Throwable unused) {
            return null;
        }
    }

    public void a(chat.ola.vn.p.n nVar) {
        this.c = nVar;
    }

    @Override // chat.ola.vn.entity.m
    public void a(List<chat.ola.vn.entity.l> list) {
        if (list != null) {
            try {
                if ("cats".equals(this.f)) {
                    this.c.a(list, this.d);
                    return;
                } else if ("folders".equals(this.f)) {
                    this.c.a(this.e, list, this.d);
                    return;
                }
            } catch (Throwable unused) {
            }
        }
        if (this.g != null) {
            this.c.b(this.e, this.g, this.d);
        }
    }

    @Override // chat.ola.vn.entity.m
    /* JADX INFO: renamed from: b, reason: merged with bridge method [inline-methods] */
    public List<chat.ola.vn.entity.l> a(byte[] bArr) {
        chat.ola.vn.entity.l lVar;
        ArrayList arrayList = null;
        try {
            JSONObject jSONObjectA = chat.ola.vn.util.http.c.a(bArr);
            this.f = jSONObjectA.getString("type");
            if (jSONObjectA.has("morePath")) {
                this.d = jSONObjectA.getString("morePath");
            } else {
                this.d = null;
            }
            JSONArray jSONArray = jSONObjectA.getJSONArray("cats".equals(this.f) ? "cats" : "folders".equals(this.f) ? "folders" : "files");
            if (jSONArray != null && jSONArray.length() > 0) {
                int length = jSONArray.length();
                for (int i = 0; i < length; i++) {
                    try {
                    } catch (Throwable th) {
                        th.printStackTrace();
                    }
                    if ("cats".equals(this.f)) {
                        JSONObject jSONObject = jSONArray.getJSONObject(i);
                        lVar = new chat.ola.vn.entity.l();
                        lVar.e = this.f;
                        lVar.i = (short) 5;
                        if (jSONObject.has("name")) {
                            lVar.a = jSONObject.getString("name");
                        }
                        if (jSONObject.has("path")) {
                            lVar.b = jSONObject.getString("path");
                        }
                        if (jSONObject.has("coverUrl")) {
                            lVar.c = jSONObject.getString("coverUrl");
                        }
                        if (arrayList == null) {
                            arrayList = new ArrayList();
                        }
                    } else if ("folders".equals(this.f)) {
                        JSONObject jSONObject2 = jSONArray.getJSONObject(i);
                        lVar = new chat.ola.vn.entity.l();
                        lVar.e = this.f;
                        lVar.i = (short) 5;
                        if (jSONObject2.has("name")) {
                            lVar.a = jSONObject2.getString("name");
                        }
                        if (jSONObject2.has("path")) {
                            lVar.b = jSONObject2.getString("path");
                        }
                        if (jSONObject2.has("coverUrl")) {
                            lVar.c = jSONObject2.getString("coverUrl");
                        }
                        if (jSONObject2.has("count")) {
                            lVar.g = jSONObject2.getInt("count");
                        }
                        if (arrayList == null) {
                            arrayList = new ArrayList();
                        }
                    } else {
                        if ("files".equals(this.f)) {
                            JSONObject jSONObject3 = jSONArray.getJSONObject(i);
                            chat.ola.vn.entity.i iVar = new chat.ola.vn.entity.i();
                            iVar.j(jSONObject3.getString("url"));
                            if (this.g == null) {
                                this.g = new ArrayList();
                            }
                            this.g.add(iVar);
                        }
                    }
                    arrayList.add(lVar);
                }
            }
        } catch (Throwable unused) {
        }
        return arrayList;
    }

    @Override // chat.ola.vn.entity.m
    public void b(String str) {
    }
}
