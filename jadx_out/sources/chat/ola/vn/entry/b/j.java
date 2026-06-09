package chat.ola.vn.entry.b;

import android.content.Context;
import android.view.View;

/* JADX INFO: loaded from: classes.dex */
public abstract class j {
    protected View.OnClickListener a;
    protected chat.ola.vn.entry.b b;
    protected View c;
    protected View d;
    protected View.OnLongClickListener e;
    protected int f = chat.ola.vn.e.c / 3;
    protected int g = (chat.ola.vn.e.c * 2) / 3;
    protected int h = chat.ola.vn.e.c;

    public abstract void a();

    public void a(int i) {
        this.c.setBackgroundResource(i);
    }

    public void a(int i, int i2, int i3, int i4) {
        this.c.setPadding(i, i2, i3, i4);
    }

    public void a(View.OnClickListener onClickListener) {
        this.a = onClickListener;
    }

    public void a(View.OnLongClickListener onLongClickListener) {
        this.e = onLongClickListener;
    }

    public void a(View view) {
        this.c = view;
        view.setTag(this);
    }

    public void a(chat.ola.vn.entry.b bVar) {
        this.b = bVar;
    }

    public void a(boolean z) {
    }

    public void b() {
    }

    public View c() {
        return this.c;
    }

    public Context d() {
        return this.c.getContext();
    }
}
