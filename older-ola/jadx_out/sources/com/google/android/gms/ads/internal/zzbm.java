package com.google.android.gms.ads.internal;

import com.google.android.gms.internal.ads.zzakb;
import com.google.android.gms.internal.ads.zzjj;
import java.lang.ref.WeakReference;

/* JADX INFO: loaded from: classes.dex */
final class zzbm implements Runnable {
    private final /* synthetic */ WeakReference zzaas;
    private final /* synthetic */ zzbl zzaat;

    zzbm(zzbl zzblVar, WeakReference weakReference) {
        this.zzaat = zzblVar;
        this.zzaas = weakReference;
    }

    @Override // java.lang.Runnable
    public final void run() {
        zzbl.zza(this.zzaat, false);
        zza zzaVar = (zza) this.zzaas.get();
        if (zzaVar != null) {
            zzjj zzjjVar = this.zzaat.zzaao;
            if (zzaVar.zzc(zzjjVar)) {
                zzaVar.zzb(zzjjVar);
            } else {
                zzakb.zzdj("Ad is not visible. Not refreshing ad.");
                zzaVar.zzvv.zzg(zzjjVar);
            }
        }
    }
}
