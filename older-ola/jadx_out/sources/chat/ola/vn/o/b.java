package chat.ola.vn.o;

import android.content.Context;
import chat.ola.vn.R;
import chat.ola.vn.activity.OlaBirthdayCheerActivity;
import chat.ola.vn.util.m;

/* JADX INFO: loaded from: classes.dex */
public class b extends chat.ola.vn.entry.e {
    public b(int i) {
        super(R.string.general_tab_birthday, R.drawable.ic_tab_birthday, R.string.general_tab_birthday);
        this.h = "birthday.ola.vn";
        this.i = 1;
        this.g = 1;
        if (i > 0) {
            this.g = 2;
            this.d += "(" + m.a(i) + ")";
        }
    }

    @Override // chat.ola.vn.entry.e
    public boolean b(Context context) {
        try {
            OlaBirthdayCheerActivity.a(context);
            return true;
        } catch (Throwable unused) {
            return false;
        }
    }
}
