package chat.ola.vn.w;

import java.util.ArrayList;
import java.util.List;
import org.json.JSONArray;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
class au implements bb {
    private String e;

    au() {
    }

    private List<chat.ola.vn.entity.ad> a(String str) {
        String string;
        try {
            JSONObject jSONObject = new JSONObject(str);
            JSONArray jSONArray = jSONObject.getJSONArray("articles");
            if (jSONObject.has("viewAll")) {
                this.e = jSONObject.getString("viewAll");
            }
            int length = jSONArray.length();
            if (length > 0) {
                int i = 3;
                ArrayList arrayList = new ArrayList(length);
                for (int i2 = 0; i2 < i && i2 < length; i2++) {
                    JSONObject jSONObject2 = jSONArray.getJSONObject(i2);
                    chat.ola.vn.entity.ad adVar = new chat.ola.vn.entity.ad();
                    if (jSONObject2.has("title")) {
                        string = jSONObject2.getString("title");
                        adVar.f(string);
                    } else {
                        string = null;
                    }
                    if (chat.ola.vn.util.m.a(string) || chat.ola.vn.util.m.b(string, "null")) {
                        i++;
                    } else {
                        if (jSONObject2.has("link")) {
                            adVar.e(jSONObject2.getString("link"));
                        }
                        if (jSONObject2.has("thumbnail")) {
                            adVar.d(jSONObject2.getString("thumbnail"));
                        }
                        if (jSONObject2.has("intro")) {
                            adVar.c(jSONObject2.getString("intro"));
                        }
                        arrayList.add(adVar);
                    }
                }
                return arrayList;
            }
        } catch (Throwable unused) {
        }
        return null;
    }

    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        short sA = sVar.a(sVar.b((short) 255, 0), (short) 0);
        String strB = sVar.b((short) 8);
        String strB2 = sVar.b((short) 207);
        String strB3 = sVar.b((short) 109);
        if (chat.ola.vn.util.m.a(strB3) || chat.ola.vn.util.m.b(strB3, "null")) {
            strB3 = "";
        }
        if (chat.ola.vn.util.m.a(strB) || chat.ola.vn.util.m.b(strB, "null")) {
            strB = "";
        }
        String strB4 = sVar.b((short) 29);
        long jA = sVar.a(sVar.b((short) 72, 0), 0L);
        short sA2 = sVar.a(sVar.b((short) 90, 0), (short) 0);
        int iA = sVar.a(sVar.b((short) 124, 0), 0);
        int iA2 = sVar.a(sVar.b((short) 125, 0), 0);
        chat.ola.vn.entity.ad adVar = new chat.ola.vn.entity.ad();
        adVar.f(strB3);
        adVar.e(strB2);
        adVar.c(jA);
        adVar.b(iA);
        adVar.c(iA2);
        adVar.g(strB4);
        adVar.b(sA2);
        adVar.a((short) -1);
        this.e = null;
        if (chat.ola.vn.util.m.a(strB)) {
            gVar.a(34, (short) 0, (String) null, (byte[]) null, (chat.ola.vn.entity.d[]) null, sA);
            return;
        }
        adVar.a(strB.replace("\r", "").split("\n"));
        String strB5 = sVar.b((short) 113);
        if (!chat.ola.vn.util.m.a(strB5)) {
            adVar.d(a(strB5));
            adVar.j(this.e);
        }
        gVar.a(adVar, sA);
    }
}
