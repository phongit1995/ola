package chat.ola.vn.entry.b;

import android.view.View;

/* JADX INFO: loaded from: classes.dex */
public abstract class b {
    protected View.OnClickListener a;
    protected View.OnLongClickListener b;
    protected View d;
    protected boolean c = true;
    protected int e = -1;

    public b(View view) {
        if (view != null) {
            this.d = view;
            view.setTag(this);
        }
    }

    public void a() {
    }

    public void a(View.OnClickListener onClickListener) {
        this.a = onClickListener;
    }

    public void a(View.OnLongClickListener onLongClickListener) {
        this.b = onLongClickListener;
    }

    public abstract void a(chat.ola.vn.message.d dVar, chat.ola.vn.message.d dVar2, chat.ola.vn.message.d dVar3);

    public View b() {
        return this.d;
    }

    public boolean equals(Object obj) {
        return false;
    }
}
