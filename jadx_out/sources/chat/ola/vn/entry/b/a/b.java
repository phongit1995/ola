package chat.ola.vn.entry.b.a;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import chat.ola.vn.entry.b.ab;

/* JADX INFO: loaded from: classes.dex */
public abstract class b {
    protected Context a;
    protected chat.ola.vn.entry.b b;
    protected View c;
    protected View.OnClickListener d;

    public b(Context context, ViewGroup viewGroup, View.OnClickListener onClickListener) {
        try {
            viewGroup.removeAllViews();
        } catch (Throwable unused) {
        }
        this.a = context;
        this.c = viewGroup;
        this.d = onClickListener;
    }

    abstract void a(ab abVar);

    public final void a(ab abVar, chat.ola.vn.entry.b bVar) {
        this.b = bVar;
        if (this.b == null) {
            b(abVar);
        } else {
            a(abVar);
        }
    }

    public abstract boolean a(byte b);

    public chat.ola.vn.entry.b b() {
        return this.b;
    }

    abstract void b(ab abVar);
}
