package chat.ola.vn.w;

import java.util.ArrayList;
import org.json.JSONArray;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class al implements bb {
    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        cgVar.a((short) 24, bkVar.s);
        if (bkVar.aj != 0) {
            cgVar.a((short) 255, (byte) bkVar.aj);
        }
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        JSONArray jSONArray;
        int length;
        short sA = sVar.a(sVar.b((short) 255, 0), (short) 0);
        String strB = sVar.b((short) 7);
        String strB2 = sVar.b((short) 24);
        String strB3 = sVar.b((short) 109);
        String strB4 = sVar.b((short) 110);
        String strB5 = sVar.b((short) 111);
        chat.ola.vn.entity.i iVar = new chat.ola.vn.entity.i();
        String strB6 = sVar.b((short) 113);
        if (!chat.ola.vn.util.m.a(strB6)) {
            try {
                JSONObject jSONObject = new JSONObject(strB6);
                if (jSONObject.has("suggestedMedias") && (length = (jSONArray = jSONObject.getJSONArray("suggestedMedias")).length()) > 0) {
                    ArrayList arrayList = new ArrayList(length);
                    for (int i = 0; i < length; i++) {
                        String string = jSONArray.getString(i);
                        if (chat.ola.vn.entity.i.i(string) == 1) {
                            chat.ola.vn.entity.i iVar2 = new chat.ola.vn.entity.i();
                            iVar2.a(string);
                            arrayList.add(iVar2);
                        }
                    }
                    if (arrayList.size() > 0) {
                        iVar.a(arrayList);
                    }
                }
            } catch (Throwable unused) {
            }
        }
        iVar.a(strB2);
        iVar.j(strB5);
        long jA = sVar.a(sVar.b((short) 9, 0), 0L);
        if (0 != jA) {
            iVar.a(Long.valueOf(jA));
        }
        chat.ola.vn.entity.l lVar = new chat.ola.vn.entity.l();
        lVar.b = strB3;
        lVar.a = strB4;
        gVar.a(strB, iVar, lVar, sA);
    }
}
