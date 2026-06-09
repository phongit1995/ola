package com.google.android.gms.internal.measurement;

import java.util.concurrent.atomic.AtomicReference;

/* JADX INFO: loaded from: classes2.dex */
final class zzhp implements Runnable {
    private final /* synthetic */ boolean zzadv;
    private final /* synthetic */ AtomicReference zzapr;
    private final /* synthetic */ zzhm zzaps;

    zzhp(zzhm zzhmVar, AtomicReference atomicReference, boolean z) {
        this.zzaps = zzhmVar;
        this.zzapr = atomicReference;
        this.zzadv = z;
    }

    @Override // java.lang.Runnable
    public final void run() {
        this.zzaps.zzga().zza(this.zzapr, this.zzadv);
    }
}
