package com.google.android.gms.internal.ads;

import android.support.annotation.Nullable;
import android.view.View;

/* JADX INFO: loaded from: classes.dex */
public final class zzey implements zzgd {

    @Nullable
    private final View mView;

    @Nullable
    private final zzajh zzafn;

    public zzey(View view, zzajh zzajhVar) {
        this.mView = view;
        this.zzafn = zzajhVar;
    }

    @Override // com.google.android.gms.internal.ads.zzgd
    public final View zzgh() {
        return this.mView;
    }

    @Override // com.google.android.gms.internal.ads.zzgd
    public final boolean zzgi() {
        return this.zzafn == null || this.mView == null;
    }

    @Override // com.google.android.gms.internal.ads.zzgd
    public final zzgd zzgj() {
        return this;
    }
}
