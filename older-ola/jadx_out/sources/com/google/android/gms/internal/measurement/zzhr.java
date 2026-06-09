package com.google.android.gms.internal.measurement;

import java.util.concurrent.atomic.AtomicReference;

/* JADX INFO: loaded from: classes2.dex */
final class zzhr implements Runnable {
    private final /* synthetic */ AtomicReference zzapr;
    private final /* synthetic */ zzhm zzaps;

    zzhr(zzhm zzhmVar, AtomicReference atomicReference) {
        this.zzaps = zzhmVar;
        this.zzapr = atomicReference;
    }

    @Override // java.lang.Runnable
    public final void run() {
        this.zzaps.zzga().zza(this.zzapr);
    }
}
