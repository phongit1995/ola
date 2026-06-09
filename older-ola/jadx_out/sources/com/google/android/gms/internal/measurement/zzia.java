package com.google.android.gms.internal.measurement;

import java.util.concurrent.atomic.AtomicReference;

/* JADX INFO: loaded from: classes2.dex */
final class zzia implements Runnable {
    private final /* synthetic */ AtomicReference zzapr;
    private final /* synthetic */ zzhm zzaps;

    zzia(zzhm zzhmVar, AtomicReference atomicReference) {
        this.zzaps = zzhmVar;
        this.zzapr = atomicReference;
    }

    @Override // java.lang.Runnable
    public final void run() {
        synchronized (this.zzapr) {
            try {
                this.zzapr.set(Double.valueOf(this.zzaps.zzgk().zzc(this.zzaps.zzfz().zzah(), zzez.zzajp)));
            } finally {
                this.zzapr.notify();
            }
        }
    }
}
