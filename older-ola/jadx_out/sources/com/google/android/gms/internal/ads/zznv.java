package com.google.android.gms.internal.ads;

import android.support.annotation.Nullable;
import javax.annotation.ParametersAreNonnullByDefault;

/* JADX INFO: loaded from: classes.dex */
@ParametersAreNonnullByDefault
@zzadh
public final class zznv {
    private final long zzbgj;

    @Nullable
    private final String zzbgk;

    @Nullable
    private final zznv zzbgl;

    public zznv(long j, @Nullable String str, @Nullable zznv zznvVar) {
        this.zzbgj = j;
        this.zzbgk = str;
        this.zzbgl = zznvVar;
    }

    public final long getTime() {
        return this.zzbgj;
    }

    public final String zzjg() {
        return this.zzbgk;
    }

    @Nullable
    public final zznv zzjh() {
        return this.zzbgl;
    }
}
