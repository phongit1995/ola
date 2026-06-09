package chat.ola.vn.o;

import android.content.Context;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.m.m;

/* JADX INFO: loaded from: classes.dex */
public class d extends chat.ola.vn.entry.e {
    public d() {
        super(R.string.general_tab_osimi, R.drawable.ic_tab_osimi, R.string.general_tab_osimi);
        this.h = "osimi.chat.ola.vn";
        this.i = 0;
        this.g = 1;
    }

    @Override // chat.ola.vn.entry.e
    public boolean b(Context context) {
        try {
            m.a(context, "osimi", context.getString(R.string.general_tab_osimi));
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
