package com.google.android.gms.internal.measurement;

import java.util.concurrent.atomic.AtomicReference;

/* JADX INFO: loaded from: classes2.dex */
final class zzhn implements Runnable {
    private final /* synthetic */ AtomicReference zzapr;
    private final /* synthetic */ zzhm zzaps;

    zzhn(zzhm zzhmVar, AtomicReference atomicReference) {
        this.zzaps = zzhmVar;
        this.zzapr = atomicReference;
    }

    @Override // java.lang.Runnable
    public final void run() {
        synchronized (this.zzapr) {
            try {
                this.zzapr.set(Boolean.valueOf(this.zzaps.zzgk().zzaz(this.zzaps.zzfz().zzah())));
            } finally {
                this.zzapr.notify();
            }
        }
    }
}
