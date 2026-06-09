package chat.ola.vn.w;

import java.util.ArrayList;

/* JADX INFO: loaded from: classes.dex */
class aw implements bb {
    aw() {
    }

    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        String strB = sVar.b((short) 83);
        if (strB != null) {
            String[] strArrE = chat.ola.vn.util.m.e(strB, "|");
            ArrayList arrayList = new ArrayList(strArrE.length / 2);
            int length = strArrE.length / 2;
            for (int i = 0; i < length; i++) {
                int i2 = i * 2;
                try {
                    String str = strArrE[i2];
                    if (!chat.ola.vn.util.m.b("#sh", str)) {
                        arrayList.add(new chat.ola.vn.entity.af(strArrE[i2 + 1], str));
                    }
                } catch (Throwable unused) {
                }
            }
            gVar.c(arrayList);
        }
    }
}
