package chat.ola.vn.w;

import chat.ola.vn.OlaApplication;
import java.util.ArrayList;
import java.util.Random;
import org.json.JSONArray;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
public class p implements bb {
    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        if (bkVar.as != 0) {
            cgVar.a((short) 114, bkVar.as);
        }
        if (bkVar.aa != 0) {
            cgVar.a((short) 124, bkVar.aa);
        }
        if (bkVar.aj != 0) {
            cgVar.a((short) 255, (byte) bkVar.aj);
        }
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        int i;
        JSONArray jSONArray;
        String str;
        String str2;
        Float fValueOf;
        String str3;
        String string;
        String string2;
        String string3;
        String string4;
        String string5;
        String string6;
        String string7;
        String string8;
        String str4;
        String str5;
        long jC;
        int i2 = 0;
        short sA = sVar.a(sVar.b((short) 255, 0), (short) 0);
        switch (sVar.a(sVar.b((short) 114, 0), (short) 0)) {
            case 0:
                try {
                    jC = chat.ola.vn.e.a().c();
                } catch (Throwable unused) {
                    jC = 0;
                }
                if (System.currentTimeMillis() - jC >= 10800000) {
                    String strB = sVar.b((short) 28);
                    long jA = sVar.a(sVar.b((short) 130, 0), 0L);
                    int iA = sVar.a(sVar.b((short) 124, 0), 0);
                    String strB2 = sVar.b((short) 109);
                    String strB3 = sVar.b((short) 110);
                    String strB4 = sVar.b((short) 111);
                    String strB5 = sVar.b((short) 112);
                    String strB6 = sVar.b((short) 113);
                    String strF = chat.ola.vn.util.m.a(strB5) ? chat.ola.vn.util.m.f(strB2) : strB5;
                    if (!chat.ola.vn.util.b.k(OlaApplication.a(), strF)) {
                        gVar.a(strB, jA, strB2, strF, strB3, strB4, iA, strB6);
                    } else {
                        chat.ola.vn.e.a().a(iA);
                    }
                }
                break;
            case 1:
                try {
                    JSONArray jSONArray2 = new JSONArray(sVar.b((short) 109));
                    int length = jSONArray2.length();
                    if (length > 0) {
                        ArrayList arrayList = new ArrayList(length);
                        while (i2 < length) {
                            JSONObject jSONObject = jSONArray2.getJSONObject(i2);
                            if (jSONObject.has("title")) {
                                String string9 = jSONObject.getString("title");
                                string = jSONObject.has("slogan") ? jSONObject.getString("slogan") : null;
                                string2 = jSONObject.has("description") ? jSONObject.getString("description") : null;
                                string3 = jSONObject.has("adId") ? jSONObject.getString("adId") : null;
                                string4 = jSONObject.has("appId") ? jSONObject.getString("appId") : null;
                                if (jSONObject.has("downloadUrl")) {
                                    string5 = jSONObject.getString("downloadUrl");
                                    if (chat.ola.vn.util.m.a(string4)) {
                                        string4 = chat.ola.vn.util.m.f(string5);
                                    }
                                } else {
                                    string5 = null;
                                }
                                string6 = jSONObject.has("shareUrl") ? jSONObject.getString("shareUrl") : null;
                                string7 = jSONObject.has("appIconUrl") ? jSONObject.getString("appIconUrl") : null;
                                string8 = jSONObject.has("youtubeCode") ? jSONObject.getString("youtubeCode") : null;
                                if (jSONObject.has("bannerMediaCode")) {
                                    try {
                                        String string10 = jSONObject.getString("bannerMediaCode");
                                        i = length;
                                        try {
                                            String[] strArrE = chat.ola.vn.util.m.e(string10, ";");
                                            if (strArrE != null) {
                                                jSONArray = jSONArray2;
                                                try {
                                                    str4 = string9;
                                                    if (strArrE.length > 1) {
                                                        try {
                                                            str5 = string10;
                                                            try {
                                                                string10 = strArrE[new Random(System.nanoTime()).nextInt(strArrE.length)];
                                                                break;
                                                            } catch (Throwable unused2) {
                                                            }
                                                        } catch (Throwable unused3) {
                                                        }
                                                    }
                                                } catch (Throwable unused4) {
                                                    str4 = string9;
                                                }
                                            } else {
                                                jSONArray = jSONArray2;
                                                str4 = string9;
                                            }
                                        } catch (Throwable unused5) {
                                            jSONArray = jSONArray2;
                                        }
                                        str5 = string10;
                                    } catch (Throwable unused6) {
                                        i = length;
                                        jSONArray = jSONArray2;
                                        str4 = string9;
                                        str5 = null;
                                    }
                                    str3 = str5;
                                } else {
                                    i = length;
                                    jSONArray = jSONArray2;
                                    str4 = string9;
                                    str3 = null;
                                }
                                String string11 = jSONObject.has("downloadDetails") ? jSONObject.getString("downloadDetails") : null;
                                if (jSONObject.has("rating")) {
                                    try {
                                        fValueOf = Float.valueOf(jSONObject.getString("rating"));
                                        str2 = string11;
                                        str = str4;
                                    } catch (Throwable unused7) {
                                        str2 = string11;
                                        str = str4;
                                        fValueOf = null;
                                    }
                                } else {
                                    str2 = string11;
                                    str = str4;
                                    fValueOf = null;
                                }
                            } else {
                                i = length;
                                jSONArray = jSONArray2;
                                str = null;
                                str2 = null;
                                fValueOf = null;
                                str3 = null;
                                string = null;
                                string2 = null;
                                string3 = null;
                                string4 = null;
                                string5 = null;
                                string6 = null;
                                string7 = null;
                                string8 = null;
                            }
                            chat.ola.vn.entity.k kVar = new chat.ola.vn.entity.k();
                            kVar.a = str;
                            kVar.e = string;
                            kVar.f = string2;
                            kVar.g = string3;
                            kVar.h = string5;
                            kVar.i = string6;
                            kVar.j = string7;
                            kVar.k = str3;
                            kVar.b = string8;
                            kVar.l = str2;
                            kVar.n = fValueOf;
                            kVar.m = string4;
                            arrayList.add(kVar);
                            i2++;
                            length = i;
                            jSONArray2 = jSONArray;
                        }
                        gVar.d(arrayList, sA);
                    }
                } catch (Throwable unused8) {
                    return;
                }
                break;
        }
    }
}
