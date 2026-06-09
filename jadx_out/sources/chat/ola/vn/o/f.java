package chat.ola.vn.o;

import android.content.Context;
import chat.ola.vn.R;
import chat.ola.vn.activity.OlaAppSettingActivity;

/* JADX INFO: loaded from: classes.dex */
public class f extends chat.ola.vn.entry.e {
    public f() {
        super(R.string.general_tab_setting, R.drawable.ic_tab_setting, R.string.general_tab_setting);
    }

    @Override // chat.ola.vn.entry.e
    public boolean b(Context context) {
        try {
            OlaAppSettingActivity.c(context);
            return true;
        } catch (Throwable unused) {
            return false;
        }
    }
}
