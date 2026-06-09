package com.google.android.gms.stats;

import com.google.android.gms.stats.WakeLock;

/* JADX INFO: loaded from: classes2.dex */
final class zza implements WakeLock.Configuration {
    zza() {
    }

    @Override // com.google.android.gms.stats.WakeLock.Configuration
    public final long getMaximumTimeout(String str, String str2) {
        return Long.MAX_VALUE;
    }

    @Override // com.google.android.gms.stats.WakeLock.Configuration
    public final boolean isWorkChainsEnabled() {
        return false;
    }
}
