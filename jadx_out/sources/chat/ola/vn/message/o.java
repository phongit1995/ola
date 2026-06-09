package chat.ola.vn.message;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class o extends f {
    protected chat.ola.vn.e.h a;

    public o() {
        super("unstrusted.people", (short) 7);
    }

    @Override // chat.ola.vn.message.f
    public List<f> F() {
        if (this.c == null) {
            this.c = new ArrayList();
        }
        return this.c;
    }

    public int Y() {
        try {
            return this.c.size();
        } catch (Throwable unused) {
            return 0;
        }
    }

    @Override // chat.ola.vn.message.f
    public long a() {
        try {
            return this.c.get(0).a();
        } catch (Throwable unused) {
            return 0L;
        }
    }

    @Override // chat.ola.vn.message.f
    public void a(List<f> list) {
        if (this.a == null) {
            this.a = new chat.ola.vn.e.h();
        }
        this.c = list;
        Collections.sort(this.c, this.a);
    }

    @Override // chat.ola.vn.message.f
    public int z() {
        int iZ = 0;
        try {
            Iterator<f> it2 = this.c.iterator();
            while (it2.hasNext()) {
                iZ += it2.next().z();
            }
        } catch (Throwable unused) {
        }
        return iZ;
    }
}
