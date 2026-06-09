package chat.ola.vn.o;

import android.content.Context;
import chat.ola.vn.R;
import chat.ola.vn.util.m;

/* JADX INFO: loaded from: classes.dex */
public class c extends chat.ola.vn.entry.e {
    protected chat.ola.vn.entity.d m;

    public c(String str, String str2) {
        super(R.string.general_tab_web_app, str, str2);
        this.m = null;
    }

    public void a(chat.ola.vn.entity.d dVar) {
        this.m = dVar;
    }

    @Override // chat.ola.vn.entry.e
    public boolean b(Context context) {
        try {
            if (this.m != null) {
                this.m.a(context);
                return true;
            }
            if (m.a(g())) {
                return true;
            }
            chat.ola.vn.m.m.a(context, g(), f());
            return true;
        } catch (Throwable unused) {
            return false;
        }
    }
}
