package chat.ola.vn;

import android.content.Context;

/* JADX INFO: loaded from: classes.dex */
public class a {
    private static a a;
    private com.mg.ola.common.b.d b;
    private com.mg.ola.common.b.d c;
    private com.mg.ola.common.b.b d;
    private com.mg.ola.common.b.d e;
    private com.mg.ola.common.b.d f;

    private a() {
        Context contextA = OlaApplication.a();
        this.c = new com.mg.ola.common.b.d(contextA, R.string.app_state_session);
        this.d = new com.mg.ola.common.b.b(contextA, R.string.state_display_tab);
        this.b = new com.mg.ola.common.b.d(contextA, R.string.state_chat_session);
        this.f = new com.mg.ola.common.b.d(contextA, R.string.state_current_me_url);
        this.e = new com.mg.ola.common.b.d(contextA, R.string.state_current_rss_url);
    }

    public static a a() {
        if (a == null) {
            a = new a();
        }
        return a;
    }

    public void a(int i) {
        this.d.b(Integer.valueOf(i));
    }

    public void a(String str) {
        this.f.b(str);
    }
}
