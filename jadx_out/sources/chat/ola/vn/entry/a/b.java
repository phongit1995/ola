package chat.ola.vn.entry.a;

import chat.ola.vn.OlaApplication;
import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class b {
    private String a;
    private boolean b;
    private List<c> c;

    public b(int i) {
        this(OlaApplication.a(i));
    }

    public b(String str) {
        this.b = true;
        this.a = str;
    }

    public c a(int i) {
        try {
            return this.c.get(i);
        } catch (Throwable th) {
            th.printStackTrace();
            return null;
        }
    }

    public String a() {
        return this.a;
    }

    public void a(c cVar) {
        if (this.c == null) {
            this.c = new ArrayList();
        }
        this.c.add(cVar);
    }

    public int b() {
        if (this.c == null) {
            return 0;
        }
        return this.c.size();
    }
}
