package chat.ola.vn.m;

import android.content.Context;
import java.util.ArrayList;
import java.util.Iterator;

/* JADX INFO: loaded from: classes.dex */
public abstract class p<T> extends f {
    private T a;
    protected ArrayList<chat.ola.vn.mediastore.a> c;

    public abstract ArrayList<chat.ola.vn.mediastore.a> a(Context context);

    public void a(T t) {
        this.a = t;
    }

    public chat.ola.vn.mediastore.a b(Context context) {
        return null;
    }

    public chat.ola.vn.mediastore.a c(Context context) {
        return null;
    }

    public void f_() {
    }

    public T g() {
        if (this.a != null) {
            return this.a;
        }
        return null;
    }

    public void h() {
        try {
            if (this.c != null) {
                Iterator<chat.ola.vn.mediastore.a> it2 = this.c.iterator();
                while (it2.hasNext()) {
                    it2.next().a(false);
                }
                this.c.clear();
                this.c = null;
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    @Override // android.support.v4.app.Fragment
    public void onDetach() {
        try {
            h();
        } catch (Throwable unused) {
        }
        super.onDetach();
    }
}
