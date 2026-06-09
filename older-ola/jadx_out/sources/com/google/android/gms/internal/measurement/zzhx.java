package com.google.android.gms.internal.measurement;

import java.util.concurrent.atomic.AtomicReference;

/* JADX INFO: loaded from: classes2.dex */
final class zzhx implements Runnable {
    private final /* synthetic */ AtomicReference zzapr;
    private final /* synthetic */ zzhm zzaps;

    zzhx(zzhm zzhmVar, AtomicReference atomicReference) {
        this.zzaps = zzhmVar;
        this.zzapr = atomicReference;
    }

    @Override // java.lang.Runnable
    public final void run() {
        synchronized (this.zzapr) {
            try {
                this.zzapr.set(this.zzaps.zzgk().zzba(this.zzaps.zzfz().zzah()));
            } finally {
                this.zzapr.notify();
            }
        }
    }
}
