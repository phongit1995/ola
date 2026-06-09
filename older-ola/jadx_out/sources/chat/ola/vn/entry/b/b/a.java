package chat.ola.vn.entry.b.b;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import chat.ola.vn.message.d;
import chat.ola.vn.message.f;

/* JADX INFO: loaded from: classes.dex */
public abstract class a {
    protected Context a;
    protected LayoutInflater b;
    private View c = a();

    public a(Context context) {
        this.a = context;
        this.b = LayoutInflater.from(context);
    }

    protected abstract View a();

    public abstract void a(f fVar, d dVar);

    public View b() {
        return this.c;
    }
}
