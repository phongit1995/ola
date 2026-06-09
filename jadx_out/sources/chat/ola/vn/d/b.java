package chat.ola.vn.d;

import chat.ola.vn.entity.d;
import chat.ola.vn.entity.i;
import chat.ola.vn.entry.c.e;
import chat.ola.vn.h;
import chat.ola.vn.util.m;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class b extends e {
    private chat.ola.vn.entry.b a;

    public b(chat.ola.vn.entry.b bVar) {
        this.a = bVar;
    }

    @Override // chat.ola.vn.entry.c.e
    public short a() {
        return (short) 72;
    }

    @Override // chat.ola.vn.entry.c.e
    public void a(int i, short s, String str, d[] dVarArr) {
    }

    @Override // chat.ola.vn.entry.c.e
    public void a(Object... objArr) {
        try {
            String str = (String) objArr[0];
            List<i> listK = ((i) objArr[1]).k();
            if (listK == null || m.a(str) || m.b(str, h.a()) || m.b(str, this.a.b.a()) || m.b(str, "rss") || m.b(str, "mall")) {
                return;
            }
            String[] strArr = new String[listK.size()];
            for (int i = 0; i < strArr.length; i++) {
                strArr[i] = listK.get(i).d();
            }
            this.a.e = strArr;
            this.a.f = str;
        } catch (Throwable unused) {
        }
    }
}
