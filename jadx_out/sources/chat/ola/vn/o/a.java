package chat.ola.vn.o;

import android.content.Context;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.m.m;

/* JADX INFO: loaded from: classes.dex */
public class a extends chat.ola.vn.entry.e {
    public a() {
        super(R.string.general_tab_adme, R.drawable.app_icon_adme, R.string.general_tab_post_adme);
        this.h = "adme.ola.vn";
        this.i = 0;
        this.g = 1;
    }

    @Override // chat.ola.vn.entry.e
    public boolean b(Context context) {
        try {
            m.a(context, "adme", context.getString(R.string.general_tab_post_adme));
            return true;
        } catch (Throwable unused) {
            return false;
        }
    }

    @Override // chat.ola.vn.entry.e
    public String h() {
        this.j = OlaApplication.a(R.string.string_new);
        return super.h();
    }
}
