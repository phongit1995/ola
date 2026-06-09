package com.google.android.gms.internal.measurement;

import android.os.RemoteException;
import android.text.TextUtils;

/* JADX INFO: loaded from: classes2.dex */
final class zzit implements Runnable {
    private final /* synthetic */ zzeb zzapd;
    private final /* synthetic */ zzik zzaqv;
    private final /* synthetic */ boolean zzaqx;
    private final /* synthetic */ boolean zzaqy;
    private final /* synthetic */ zzef zzaqz;
    private final /* synthetic */ zzef zzara;

    zzit(zzik zzikVar, boolean z, boolean z2, zzef zzefVar, zzeb zzebVar, zzef zzefVar2) {
        this.zzaqv = zzikVar;
        this.zzaqx = z;
        this.zzaqy = z2;
        this.zzaqz = zzefVar;
        this.zzapd = zzebVar;
        this.zzara = zzefVar2;
    }

    @Override // java.lang.Runnable
    public final void run() {
        zzfa zzfaVar = this.zzaqv.zzaqp;
        if (zzfaVar == null) {
            this.zzaqv.zzgi().zziv().log("Discarding data. Failed to send conditional user property to service");
            return;
        }
        if (this.zzaqx) {
            this.zzaqv.zza(zzfaVar, this.zzaqy ? null : this.zzaqz, this.zzapd);
        } else {
            try {
                if (TextUtils.isEmpty(this.zzara.packageName)) {
                    zzfaVar.zza(this.zzaqz, this.zzapd);
                } else {
                    zzfaVar.zzb(this.zzaqz);
                }
            } catch (RemoteException e) {
                this.zzaqv.zzgi().zziv().zzg("Failed to send conditional user property to the service", e);
            }
        }
        this.zzaqv.zzcu();
    }
}
