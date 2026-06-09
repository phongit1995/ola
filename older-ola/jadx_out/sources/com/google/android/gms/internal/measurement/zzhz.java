package com.google.android.gms.internal.measurement;

import java.util.concurrent.atomic.AtomicReference;

/* JADX INFO: loaded from: classes2.dex */
final class zzhz implements Runnable {
    private final /* synthetic */ AtomicReference zzapr;
    private final /* synthetic */ zzhm zzaps;

    zzhz(zzhm zzhmVar, AtomicReference atomicReference) {
        this.zzaps = zzhmVar;
        this.zzapr = atomicReference;
    }

    @Override // java.lang.Runnable
    public final void run() {
        synchronized (this.zzapr) {
            try {
                this.zzapr.set(Integer.valueOf(this.zzaps.zzgk().zzb(this.zzaps.zzfz().zzah(), zzez.zzajo)));
            } finally {
                this.zzapr.notify();
            }
        }
    }
}
