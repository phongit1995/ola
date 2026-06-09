package chat.ola.vn.entry.a;

import android.content.Context;

/* JADX INFO: loaded from: classes.dex */
public class e extends c<Boolean> {
    public e(short s, String str, String str2, Boolean bool) {
        super(s, (short) 0, str, str2, bool);
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference failed for: r3v5, types: [T, java.lang.Boolean] */
    @Override // chat.ola.vn.entry.a.c
    public boolean a(Context context) {
        this.d = Boolean.valueOf(!((Boolean) this.d).booleanValue());
        if (this.e != null) {
            this.e.a(this, this.d);
        }
        return true;
    }
}
