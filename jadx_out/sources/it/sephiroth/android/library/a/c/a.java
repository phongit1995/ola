package it.sephiroth.android.library.a.c;

import android.annotation.TargetApi;
import android.view.View;

/* JADX INFO: loaded from: classes2.dex */
public class a extends it.sephiroth.android.library.a.b.a {
    public a(View view) {
        super(view);
    }

    @Override // it.sephiroth.android.library.a.a.b, it.sephiroth.android.library.a.a.AbstractC0084a
    @TargetApi(16)
    public void a(Runnable runnable) {
        this.a.postOnAnimation(runnable);
    }
}
