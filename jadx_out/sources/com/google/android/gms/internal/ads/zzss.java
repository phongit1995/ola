package com.google.android.gms.internal.ads;

import android.content.Context;
import com.google.android.gms.common.util.VisibleForTesting;

/* JADX INFO: loaded from: classes.dex */
@VisibleForTesting
@zzadh
public final class zzss {
    private final Context mContext;
    private final com.google.android.gms.ads.internal.zzw zzwc;
    private final zzxn zzwh;
    private final zzang zzyf;

    zzss(Context context, zzxn zzxnVar, zzang zzangVar, com.google.android.gms.ads.internal.zzw zzwVar) {
        this.mContext = context;
        this.zzwh = zzxnVar;
        this.zzyf = zzangVar;
        this.zzwc = zzwVar;
    }

    @VisibleForTesting
    public final Context getApplicationContext() {
        return this.mContext.getApplicationContext();
    }

    @VisibleForTesting
    public final com.google.android.gms.ads.internal.zzal zzav(String str) {
        return new com.google.android.gms.ads.internal.zzal(this.mContext, new zzjn(), str, this.zzwh, this.zzyf, this.zzwc);
    }

    @VisibleForTesting
    public final com.google.android.gms.ads.internal.zzal zzaw(String str) {
        return new com.google.android.gms.ads.internal.zzal(this.mContext.getApplicationContext(), new zzjn(), str, this.zzwh, this.zzyf, this.zzwc);
    }

    @VisibleForTesting
    public final zzss zzlc() {
        return new zzss(this.mContext.getApplicationContext(), this.zzwh, this.zzyf, this.zzwc);
    }
}
