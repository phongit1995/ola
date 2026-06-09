package chat.ola.vn.entry.a;

import android.content.Context;

/* JADX INFO: loaded from: classes.dex */
public class a extends c<String> {
    public a(short s, String str, String str2, String str3) {
        super(s, (short) 4, str, str2, str3);
    }

    @Override // chat.ola.vn.entry.a.c
    public boolean a(Context context) {
        if (this.e == null) {
            return false;
        }
        this.e.a(this, this.d);
        return true;
    }
}
