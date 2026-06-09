package chat.ola.vn.w;

import android.annotation.SuppressLint;
import chat.ola.vn.OlaApplication;
import java.util.ArrayList;
import java.util.Collections;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
class ed implements bb {
    private long e;

    ed() {
    }

    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        this.e = bkVar.V;
        cgVar.a((short) 108, bkVar.V);
        if (bkVar.S != 0) {
            cgVar.a((short) 72, bkVar.S);
        }
        if (bkVar.aj != 0) {
            cgVar.a((short) 255, (byte) bkVar.aj);
        }
    }

    @Override // chat.ola.vn.w.bb
    @SuppressLint({"DefaultLocale"})
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        short s;
        ArrayList arrayList;
        int i;
        boolean z;
        int i2;
        chat.ola.vn.entity.w wVar;
        byte b = 0;
        short sA = sVar.a(sVar.b((short) 255, 0), (short) 0);
        if (ciVar.p != sA) {
            return;
        }
        int iC = sVar.c((short) 8);
        if (iC > 0) {
            arrayList = new ArrayList(iC);
            short s2 = 67;
            int iA = sVar.a((short) 67, -1);
            boolean z2 = false;
            ArrayList arrayList2 = null;
            while (!z2) {
                int iA2 = sVar.a(s2, iA);
                boolean z3 = iA2 < 0 ? true : z2;
                String lowerCase = sVar.c(iA).toLowerCase();
                String strB = sVar.b((short) 22, iA, iA2);
                short sA2 = sVar.a((short) 45, iA, iA2, b);
                short s3 = 72;
                ArrayList arrayList3 = arrayList2;
                int iA3 = sVar.a((short) 72, iA);
                boolean z4 = false;
                while (!z4) {
                    int iA4 = sVar.a(s3, iA3, iA2);
                    if (iA4 < 0) {
                        i2 = iA2;
                        i = i2;
                        z = true;
                    } else {
                        i = iA2;
                        z = z4;
                        i2 = iA4;
                    }
                    long jA = sVar.a(iA3, 0L);
                    ArrayList arrayList4 = arrayList3 == null ? new ArrayList() : arrayList3;
                    arrayList4.add("" + jA);
                    short sA3 = (short) sVar.a((short) 221, iA3, i2, b);
                    short sA4 = (short) sVar.a((short) 220, iA3, i2, b);
                    int iA5 = sVar.a((short) 125, iA3, i2, (int) b);
                    ArrayList arrayList5 = arrayList4;
                    int i3 = i2;
                    short s4 = sA2;
                    String str = lowerCase;
                    String str2 = strB;
                    long jA2 = sVar.a((short) 9, iA3, i3, 0L);
                    String strB2 = sVar.b((short) 8, iA3, i3);
                    String strB3 = sVar.b((short) 24, iA3, i3);
                    boolean z5 = z3;
                    sVar.a((short) 114, iA3, i3, b);
                    String strB4 = sVar.b((short) 38, iA3, i3);
                    chat.ola.vn.entity.g gVar2 = new chat.ola.vn.entity.g();
                    short s5 = sA;
                    String strB5 = sVar.b((short) 113, iA3, i3);
                    if (!chat.ola.vn.util.m.a(strB5)) {
                        try {
                            JSONObject jSONObject = new JSONObject(strB5);
                            if (jSONObject.has("checkInId")) {
                                String string = jSONObject.getString("checkInId");
                                if (!chat.ola.vn.util.m.b(string, "null")) {
                                    gVar2.k(string);
                                }
                            }
                        } catch (Throwable unused) {
                        }
                    }
                    gVar2.b(jA);
                    gVar2.a(str);
                    gVar2.e(s4);
                    gVar2.i(str2);
                    gVar2.b(iA5);
                    gVar2.b(sA3);
                    if (sA4 > 0) {
                        wVar = new chat.ola.vn.entity.w();
                        wVar.a(sA4);
                    } else {
                        wVar = null;
                    }
                    if (wVar == null && chat.ola.vn.entity.w.b(strB3)) {
                        wVar = new chat.ola.vn.entity.w();
                        wVar.a(strB3);
                        strB3 = null;
                    }
                    gVar2.a(wVar);
                    gVar2.a(jA2);
                    gVar2.b(strB2);
                    gVar2.c(strB3);
                    gVar2.f(strB4);
                    gVar2.a(this.e == jA);
                    arrayList.add(gVar2);
                    strB = str2;
                    iA3 = i3;
                    sA2 = s4;
                    z4 = z;
                    iA2 = i;
                    arrayList3 = arrayList5;
                    z3 = z5;
                    sA = s5;
                    lowerCase = str;
                    s3 = 72;
                    b = 0;
                    s2 = 67;
                }
                arrayList2 = arrayList3;
                iA = iA2;
                z2 = z3;
            }
            s = sA;
            Collections.sort(arrayList, new chat.ola.vn.e.c(false));
            chat.ola.vn.r.a.e.e(arrayList);
            try {
                OlaApplication.b.a(arrayList2);
            } catch (Throwable unused2) {
            }
        } else {
            s = sA;
            arrayList = null;
        }
        if (arrayList == null || arrayList.size() <= 0) {
            return;
        }
        gVar.a(arrayList.remove(arrayList.size() - 1), arrayList, s);
    }
}
