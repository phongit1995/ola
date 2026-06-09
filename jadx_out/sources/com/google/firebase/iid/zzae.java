package com.google.firebase.iid;

import android.os.Bundle;
import android.util.Log;
import com.google.android.gms.tasks.TaskCompletionSource;

/* JADX INFO: loaded from: classes2.dex */
abstract class zzae<T> {
    final int what;
    final int zzby;
    final TaskCompletionSource<T> zzbz = new TaskCompletionSource<>();
    final Bundle zzca;

    zzae(int i, int i2, Bundle bundle) {
        this.zzby = i;
        this.what = i2;
        this.zzca = bundle;
    }

    final void finish(T t) {
        if (Log.isLoggable("MessengerIpcClient", 3)) {
            String strValueOf = String.valueOf(this);
            String strValueOf2 = String.valueOf(t);
            StringBuilder sb = new StringBuilder(String.valueOf(strValueOf).length() + 16 + String.valueOf(strValueOf2).length());
            sb.append("Finishing ");
            sb.append(strValueOf);
            sb.append(" with ");
            sb.append(strValueOf2);
            Log.d("MessengerIpcClient", sb.toString());
        }
        this.zzbz.setResult(t);
    }

    public String toString() {
        int i = this.what;
        int i2 = this.zzby;
        boolean zZzv = zzv();
        StringBuilder sb = new StringBuilder(55);
        sb.append("Request { what=");
        sb.append(i);
        sb.append(" id=");
        sb.append(i2);
        sb.append(" oneWay=");
        sb.append(zZzv);
        sb.append("}");
        return sb.toString();
    }

    final void zza(zzaf zzafVar) {
        if (Log.isLoggable("MessengerIpcClient", 3)) {
            String strValueOf = String.valueOf(this);
            String strValueOf2 = String.valueOf(zzafVar);
            StringBuilder sb = new StringBuilder(String.valueOf(strValueOf).length() + 14 + String.valueOf(strValueOf2).length());
            sb.append("Failing ");
            sb.append(strValueOf);
            sb.append(" with ");
            sb.append(strValueOf2);
            Log.d("MessengerIpcClient", sb.toString());
        }
        this.zzbz.setException(zzafVar);
    }

    abstract void zzb(Bundle bundle);

    abstract boolean zzv();
}
