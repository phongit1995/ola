package com.google.android.gms.internal.measurement;

import android.os.RemoteException;
import android.text.TextUtils;

/* JADX INFO: loaded from: classes2.dex */
final class zzis implements Runnable {
    private final /* synthetic */ zzeb zzapd;
    private final /* synthetic */ String zzapg;
    private final /* synthetic */ zzex zzaph;
    private final /* synthetic */ zzik zzaqv;
    private final /* synthetic */ boolean zzaqx;
    private final /* synthetic */ boolean zzaqy;

    zzis(zzik zzikVar, boolean z, boolean z2, zzex zzexVar, zzeb zzebVar, String str) {
        this.zzaqv = zzikVar;
        this.zzaqx = z;
        this.zzaqy = z2;
        this.zzaph = zzexVar;
        this.zzapd = zzebVar;
        this.zzapg = str;
    }

    @Override // java.lang.Runnable
    public final void run() {
        zzfa zzfaVar = this.zzaqv.zzaqp;
        if (zzfaVar == null) {
            this.zzaqv.zzgi().zziv().log("Discarding data. Failed to send event to service");
            return;
        }
        if (this.zzaqx) {
            this.zzaqv.zza(zzfaVar, this.zzaqy ? null : this.zzaph, this.zzapd);
        } else {
            try {
                if (TextUtils.isEmpty(this.zzapg)) {
                    zzfaVar.zza(this.zzaph, this.zzapd);
                } else {
                    zzfaVar.zza(this.zzaph, this.zzapg, this.zzaqv.zzgi().zzje());
                }
            } catch (RemoteException e) {
                this.zzaqv.zzgi().zziv().zzg("Failed to send event to the service", e);
            }
        }
        this.zzaqv.zzcu();
    }
}
