package com.google.firebase.iid;

import android.content.Intent;
import android.util.Log;

/* JADX INFO: loaded from: classes2.dex */
final class zze implements Runnable {
    private final /* synthetic */ Intent zzp;
    private final /* synthetic */ zzd zzv;

    zze(zzd zzdVar, Intent intent) {
        this.zzv = zzdVar;
        this.zzp = intent;
    }

    @Override // java.lang.Runnable
    public final void run() {
        String action = this.zzp.getAction();
        StringBuilder sb = new StringBuilder(String.valueOf(action).length() + 61);
        sb.append("Service took too long to process intent: ");
        sb.append(action);
        sb.append(" App may get closed.");
        Log.w("EnhancedIntentService", sb.toString());
        this.zzv.finish();
    }
}
