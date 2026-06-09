package it.sephiroth.android.library.a.b;

import android.annotation.TargetApi;
import android.view.View;
import it.sephiroth.android.library.a.a;

/* JADX INFO: loaded from: classes2.dex */
public class a extends a.b {
    public a(View view) {
        super(view);
    }

    @Override // it.sephiroth.android.library.a.a.b, it.sephiroth.android.library.a.a.AbstractC0084a
    @TargetApi(14)
    public void a(int i) {
        this.a.setScrollX(i);
    }

    @Override // it.sephiroth.android.library.a.a.b, it.sephiroth.android.library.a.a.AbstractC0084a
    @TargetApi(11)
    public boolean a() {
        return this.a.isHardwareAccelerated();
    }
}
