package chat.ola.vn.w;

import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class e implements bb {
    private void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar, short s) {
        short s2;
        int iC = sVar.c((short) 110);
        if (iC > 0) {
            ArrayList arrayList = new ArrayList(iC);
            int iB = sVar.b((short) 110, 0);
            int i = 0;
            while (i < iC) {
                int iA = sVar.a((short) 110, iB);
                String strC = sVar.c(iB);
                short sA = sVar.a(sVar.a((short) 20, iB, iA), (short) 0);
                if (sA == 0) {
                    s2 = 0;
                } else if (sA == 1) {
                    s2 = 2;
                } else {
                    i++;
                    iB = iA;
                }
                int iA2 = sVar.a(sVar.a((short) 124, iB, iA), 0);
                if (iA2 > 0) {
                    chat.ola.vn.message.f fVar = new chat.ola.vn.message.f(strC, s2);
                    fVar.a(iA2);
                    arrayList.add(fVar);
                }
                i++;
                iB = iA;
            }
        }
    }

    private void a(s sVar, short s, chat.ola.vn.p.g gVar, ci ciVar, short s2) {
        int i;
        int i2;
        String str;
        ArrayList arrayList;
        ArrayList arrayList2;
        String strB = sVar.b((short) 110);
        short s3 = 0;
        byte bA = sVar.a(sVar.b((short) 20, 0), (short) 0);
        short s4 = 7;
        int iC = sVar.c((short) 7);
        String strB2 = sVar.b((short) 112);
        if (strB2 == null) {
            strB2 = "null";
        }
        String str2 = strB2;
        ArrayList arrayList3 = null;
        if (bA == 0) {
            i = 0;
        } else {
            if (bA != 1) {
                if (s == 1) {
                    gVar.b(strB, bA, str2, null, s2);
                    return;
                } else {
                    if (s == 2) {
                        gVar.a(strB, bA, str2, (List<chat.ola.vn.message.d>) null, s2);
                        return;
                    }
                    return;
                }
            }
            i = 2;
        }
        ArrayList arrayList4 = null;
        if (iC > 0) {
            arrayList3 = new ArrayList(iC);
            int iB = sVar.b((short) 7, 0);
            ArrayList arrayList5 = null;
            int i3 = 0;
            while (i3 < iC) {
                int iA = sVar.a(s4, iB);
                String strC = sVar.c(iB);
                int i4 = iB;
                int i5 = i3;
                int i6 = i;
                ArrayList arrayList6 = arrayList3;
                long jA = sVar.a((short) 9, i4, iA, 0L);
                long jA2 = sVar.a((short) 130, i4, iA, 0L);
                String strB3 = sVar.b((short) 8, i4, iA);
                String strB4 = sVar.b((short) 111, i4, iA);
                short sA = sVar.a(sVar.a((short) 220, i4, iA), s3);
                short sA2 = sVar.a(sVar.a((short) 45, i4, iA), s3);
                int i7 = iC;
                boolean z = sVar.a(sVar.a((short) 116, i4, iA), s3) == 1;
                String str3 = strB;
                boolean z2 = sVar.a(sVar.a((short) 117, i4, iA), (short) 0) == 1;
                byte bA2 = sVar.a(sVar.a((short) 137, i4, iA), (byte) 0);
                chat.ola.vn.message.d dVar = new chat.ola.vn.message.d();
                dVar.d(strC);
                dVar.h(strB4);
                dVar.a(jA);
                dVar.a(bA2);
                dVar.f(strB3);
                dVar.b(sA);
                dVar.a(sA2);
                dVar.i(str2);
                dVar.w = z;
                dVar.x = z2;
                dVar.p = Long.valueOf(System.currentTimeMillis() + jA2);
                chat.ola.vn.message.d dVarA = chat.ola.vn.message.e.a(dVar, chat.ola.vn.util.m.b(ciVar.f, strC) ? (byte) 2 : (byte) 1);
                if (dVarA.e() == 3) {
                    if (arrayList5 == null) {
                        try {
                            arrayList2 = new ArrayList(20);
                        } catch (Throwable unused) {
                        }
                    } else {
                        arrayList2 = arrayList5;
                    }
                    try {
                        arrayList2.add(((chat.ola.vn.message.aa) dVarA).C());
                    } catch (Throwable unused2) {
                    }
                    arrayList5 = arrayList2;
                }
                if (dVarA != null) {
                    arrayList = arrayList6;
                    arrayList.add(dVarA);
                } else {
                    arrayList = arrayList6;
                }
                arrayList3 = arrayList;
                i3 = i5 + 1;
                i = i6;
                iC = i7;
                strB = str3;
                iB = iA;
                s3 = 0;
                s4 = 7;
            }
            i2 = i;
            str = strB;
            arrayList4 = arrayList5;
        } else {
            i2 = i;
            str = strB;
        }
        if (s == 1) {
            gVar.b(str, (short) i2, str2, arrayList3, s2);
        } else {
            int i8 = i2;
            if (s == 2) {
                gVar.a(str, (short) i8, str2, arrayList3, s2);
            }
        }
        if (arrayList4 != null) {
            try {
                if (arrayList4.size() > 0) {
                    String[] strArr = new String[arrayList4.size()];
                    for (int i9 = 0; i9 < strArr.length; i9++) {
                        strArr[i9] = (String) arrayList4.get(i9);
                    }
                    ciVar.a("inbox:" + ciVar.f, strArr, (short) 0);
                }
            } catch (Throwable unused3) {
            }
        }
    }

    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        if (bkVar.as != 0) {
            cgVar.a((short) 114, bkVar.as);
        }
        if (bkVar.al != 0) {
            cgVar.a((short) 20, (byte) bkVar.al);
        }
        if (!chat.ola.vn.util.m.a(bkVar.z)) {
            cgVar.a((short) 109, bkVar.z);
        }
        if (!chat.ola.vn.util.m.a(bkVar.A)) {
            cgVar.a((short) 110, bkVar.A);
        }
        if (!chat.ola.vn.util.m.a(bkVar.C)) {
            cgVar.a((short) 112, bkVar.C);
        }
        if (bkVar.aj != 0) {
            cgVar.a((short) 255, (byte) bkVar.aj);
        }
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        short sA = sVar.a(sVar.b((short) 255, 0), (short) 0);
        byte bA = sVar.a(sVar.b((short) 114, 0), (short) 0);
        switch (bA) {
            case 0:
                a(sVar, gVar, ciVar, sA);
                break;
            case 1:
            case 2:
                a(sVar, bA, gVar, ciVar, sA);
                break;
        }
    }
}
