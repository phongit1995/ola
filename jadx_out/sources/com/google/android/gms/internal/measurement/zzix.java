package com.google.android.gms.internal.measurement;

import android.os.RemoteException;
import java.util.concurrent.atomic.AtomicReference;

/* JADX INFO: loaded from: classes2.dex */
final class zzix implements Runnable {
    private final /* synthetic */ boolean zzadv;
    private final /* synthetic */ zzeb zzapd;
    private final /* synthetic */ zzik zzaqv;
    private final /* synthetic */ AtomicReference zzaqw;

    zzix(zzik zzikVar, AtomicReference atomicReference, zzeb zzebVar, boolean z) {
        this.zzaqv = zzikVar;
        this.zzaqw = atomicReference;
        this.zzapd = zzebVar;
        this.zzadv = z;
    }

    @Override // java.lang.Runnable
    public final void run() {
        AtomicReference atomicReference;
        zzfa zzfaVar;
        synchronized (this.zzaqw) {
            try {
                try {
                    zzfaVar = this.zzaqv.zzaqp;
                } catch (RemoteException e) {
                    this.zzaqv.zzgi().zziv().zzg("Failed to get user properties", e);
                    atomicReference = this.zzaqw;
                }
                if (zzfaVar == null) {
                    this.zzaqv.zzgi().zziv().log("Failed to get user properties");
                    return;
                }
                this.zzaqw.set(zzfaVar.zza(this.zzapd, this.zzadv));
                this.zzaqv.zzcu();
                atomicReference = this.zzaqw;
                atomicReference.notify();
            } finally {
                this.zzaqw.notify();
            }
        }
    }
}
