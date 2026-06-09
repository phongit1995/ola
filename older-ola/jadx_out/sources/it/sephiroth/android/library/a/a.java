package it.sephiroth.android.library.a;

import android.os.Build;
import android.util.Log;
import android.view.View;

/* JADX INFO: loaded from: classes2.dex */
public class a {

    /* JADX INFO: renamed from: it.sephiroth.android.library.a.a$a, reason: collision with other inner class name */
    public static abstract class AbstractC0084a {
        protected View a;

        protected AbstractC0084a(View view) {
            this.a = view;
        }

        public abstract void a(int i);

        public abstract void a(Runnable runnable);

        public abstract boolean a();
    }

    public static class b extends AbstractC0084a {
        public b(View view) {
            super(view);
        }

        @Override // it.sephiroth.android.library.a.a.AbstractC0084a
        public void a(int i) {
            Log.d("ViewHelper", "setScrollX: " + i);
            this.a.scrollTo(i, this.a.getScrollY());
        }

        @Override // it.sephiroth.android.library.a.a.AbstractC0084a
        public void a(Runnable runnable) {
            this.a.post(runnable);
        }

        @Override // it.sephiroth.android.library.a.a.AbstractC0084a
        public boolean a() {
            return false;
        }
    }

    public static final AbstractC0084a a(View view) {
        int i = Build.VERSION.SDK_INT;
        return i >= 16 ? new it.sephiroth.android.library.a.c.a(view) : i >= 14 ? new it.sephiroth.android.library.a.b.a(view) : new b(view);
    }
}
