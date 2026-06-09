package com.google.android.gms.internal.measurement;

import android.content.Context;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.util.VisibleForTesting;

/* JADX INFO: loaded from: classes2.dex */
@VisibleForTesting
public final class zzjy {
    final Context zzqx;

    @VisibleForTesting
    public zzjy(Context context) {
        Preconditions.checkNotNull(context);
        Context applicationContext = context.getApplicationContext();
        Preconditions.checkNotNull(applicationContext);
        this.zzqx = applicationContext;
    }
}
