package chat.ola.vn.v;

import chat.ola.vn.message.f;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class b {
    String a;
    int b;
    int c;
    List<f> d;

    void a() {
        this.a = null;
        if (this.d != null) {
            this.d.clear();
            this.d = null;
        }
    }

    public void a(int i) {
        this.b = i;
    }

    public void a(String str) {
        this.a = str;
    }

    public void b(int i) {
        this.c = i;
    }
}
