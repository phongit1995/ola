package com.google.firebase.auth.api.internal;

import android.support.annotation.NonNull;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.util.VisibleForTesting;
import java.util.Map;

/* JADX INFO: loaded from: classes2.dex */
@VisibleForTesting
final class zzak implements zzan {
    private final int zzgo;
    private final int zzgp;
    private final Map<String, Integer> zzgq;
    private final boolean zzgr = true;

    public zzak(int i, int i2, @NonNull Map<String, Integer> map, boolean z) {
        this.zzgo = i;
        this.zzgp = i2;
        this.zzgq = (Map) Preconditions.checkNotNull(map);
    }

    @Override // com.google.firebase.auth.api.internal.zzan
    public final boolean zzd(zzam zzamVar) {
        Integer num;
        if (this.zzgr) {
            return this.zzgp > this.zzgo && (num = this.zzgq.get(zzamVar.zzz())) != null && num.intValue() > this.zzgo && this.zzgp >= num.intValue();
        }
        return true;
    }
}
