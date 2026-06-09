package com.google.firebase.iid;

import android.util.Log;

/* JADX INFO: loaded from: classes2.dex */
final class zzg implements Runnable {
    private final /* synthetic */ zzd zzx;
    private final /* synthetic */ zzf zzy;

    zzg(zzf zzfVar, zzd zzdVar) {
        this.zzy = zzfVar;
        this.zzx = zzdVar;
    }

    @Override // java.lang.Runnable
    public final void run() {
        if (Log.isLoggable("EnhancedIntentService", 3)) {
            Log.d("EnhancedIntentService", "bg processing of the intent starting now");
        }
        this.zzy.zzw.zzd(this.zzx.intent);
        this.zzx.finish();
    }
}
