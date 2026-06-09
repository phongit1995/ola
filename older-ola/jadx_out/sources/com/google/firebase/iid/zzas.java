package com.google.firebase.iid;

import android.content.Context;
import android.content.Intent;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.PowerManager;
import android.util.Log;
import com.google.android.gms.common.util.VisibleForTesting;
import java.io.IOException;

/* JADX INFO: loaded from: classes2.dex */
final class zzas implements Runnable {
    private final zzah zzao;
    private final zzau zzar;
    private final long zzdb;
    private final PowerManager.WakeLock zzdc = ((PowerManager) getContext().getSystemService("power")).newWakeLock(1, "fiid-sync");
    private final FirebaseInstanceId zzdd;

    @VisibleForTesting
    zzas(FirebaseInstanceId firebaseInstanceId, zzah zzahVar, zzau zzauVar, long j) {
        this.zzdd = firebaseInstanceId;
        this.zzao = zzahVar;
        this.zzar = zzauVar;
        this.zzdb = j;
        this.zzdc.setReferenceCounted(false);
    }

    @VisibleForTesting
    private final boolean zzag() {
        zzar zzarVarZzg = this.zzdd.zzg();
        if (zzarVarZzg != null && !zzarVarZzg.zzj(this.zzao.zzx())) {
            return true;
        }
        try {
            String strZzh = this.zzdd.zzh();
            if (strZzh == null) {
                Log.e("FirebaseInstanceId", "Token retrieval failed: null");
                return false;
            }
            if (Log.isLoggable("FirebaseInstanceId", 3)) {
                Log.d("FirebaseInstanceId", "Token successfully retrieved");
            }
            if (zzarVarZzg == null || (zzarVarZzg != null && !strZzh.equals(zzarVarZzg.zzcz))) {
                Context context = getContext();
                Intent intent = new Intent("com.google.firebase.iid.TOKEN_REFRESH");
                Intent intent2 = new Intent("com.google.firebase.INSTANCE_ID_EVENT");
                intent2.setClass(context, FirebaseInstanceIdReceiver.class);
                intent2.putExtra("wrapped_intent", intent);
                context.sendBroadcast(intent2);
            }
            return true;
        } catch (IOException | SecurityException e) {
            String strValueOf = String.valueOf(e.getMessage());
            Log.e("FirebaseInstanceId", strValueOf.length() != 0 ? "Token retrieval failed: ".concat(strValueOf) : new String("Token retrieval failed: "));
            return false;
        }
    }

    final Context getContext() {
        return this.zzdd.zze().getApplicationContext();
    }

    @Override // java.lang.Runnable
    public final void run() {
        FirebaseInstanceId firebaseInstanceId;
        this.zzdc.acquire();
        try {
            boolean z = true;
            this.zzdd.zza(true);
            if (this.zzao.zzw() == 0) {
                z = false;
            }
            if (z) {
                if (!zzah()) {
                    new zzat(this).zzai();
                } else if (zzag() && this.zzar.zza(this.zzdd)) {
                    firebaseInstanceId = this.zzdd;
                } else {
                    this.zzdd.zza(this.zzdb);
                }
            }
            firebaseInstanceId = this.zzdd;
            firebaseInstanceId.zza(false);
        } finally {
            this.zzdc.release();
        }
    }

    final boolean zzah() {
        ConnectivityManager connectivityManager = (ConnectivityManager) getContext().getSystemService("connectivity");
        NetworkInfo activeNetworkInfo = connectivityManager != null ? connectivityManager.getActiveNetworkInfo() : null;
        return activeNetworkInfo != null && activeNetworkInfo.isConnected();
    }
}
