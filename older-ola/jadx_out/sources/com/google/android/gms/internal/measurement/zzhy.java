package com.google.android.gms.internal.measurement;

import java.util.concurrent.atomic.AtomicReference;

/* JADX INFO: loaded from: classes2.dex */
final class zzhy implements Runnable {
    private final /* synthetic */ AtomicReference zzapr;
    private final /* synthetic */ zzhm zzaps;

    zzhy(zzhm zzhmVar, AtomicReference atomicReference) {
        this.zzaps = zzhmVar;
        this.zzapr = atomicReference;
    }

    @Override // java.lang.Runnable
    public final void run() {
        synchronized (this.zzapr) {
            try {
                this.zzapr.set(Long.valueOf(this.zzaps.zzgk().zza(this.zzaps.zzfz().zzah(), zzez.zzajn)));
            } finally {
                this.zzapr.notify();
            }
        }
    }
}
