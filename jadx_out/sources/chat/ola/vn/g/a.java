package chat.ola.vn.g;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;

/* JADX INFO: loaded from: classes.dex */
public abstract class a {
    protected int a = 7;
    protected boolean b = false;
    protected boolean c = false;

    public int a() {
        return this.a;
    }

    public abstract View a(LayoutInflater layoutInflater);

    public h a(View view, h hVar) {
        return null;
    }

    public void a(boolean z) {
        this.b = z;
    }

    public boolean a(Context context, View view, int i, long j) {
        return false;
    }

    public void b(Context context, View view, int i, long j) {
    }

    public void b(boolean z) {
        this.c = z;
    }
}
