package com.google.firebase.iid;

import android.support.annotation.GuardedBy;
import android.support.annotation.Nullable;
import android.support.annotation.WorkerThread;
import android.support.v4.util.ArrayMap;
import android.text.TextUtils;
import android.util.Log;
import com.google.android.gms.tasks.Task;
import com.google.android.gms.tasks.TaskCompletionSource;
import java.io.IOException;
import java.util.Map;

/* JADX INFO: loaded from: classes2.dex */
final class zzau {

    @GuardedBy("itself")
    private final zzaq zzaj;

    @GuardedBy("this")
    private int zzdf = 0;

    @GuardedBy("this")
    private final Map<Integer, TaskCompletionSource<Void>> zzdg = new ArrayMap();

    zzau(zzaq zzaqVar) {
        this.zzaj = zzaqVar;
    }

    @WorkerThread
    private static boolean zza(FirebaseInstanceId firebaseInstanceId, String str) {
        String str2;
        String str3;
        String[] strArrSplit = str.split("!");
        if (strArrSplit.length == 2) {
            String str4 = strArrSplit[0];
            String str5 = strArrSplit[1];
            byte b = -1;
            try {
                int iHashCode = str4.hashCode();
                if (iHashCode != 83) {
                    if (iHashCode == 85 && str4.equals("U")) {
                        b = 1;
                    }
                } else if (str4.equals("S")) {
                    b = 0;
                }
                switch (b) {
                    case 0:
                        firebaseInstanceId.zzb(str5);
                        if (FirebaseInstanceId.zzi()) {
                            str2 = "FirebaseInstanceId";
                            str3 = "subscribe operation succeeded";
                            Log.d(str2, str3);
                        }
                        break;
                    case 1:
                        firebaseInstanceId.zzc(str5);
                        if (FirebaseInstanceId.zzi()) {
                            str2 = "FirebaseInstanceId";
                            str3 = "unsubscribe operation succeeded";
                            Log.d(str2, str3);
                        }
                        break;
                }
                return true;
            } catch (IOException e) {
                String strValueOf = String.valueOf(e.getMessage());
                Log.e("FirebaseInstanceId", strValueOf.length() != 0 ? "Topic sync failed: ".concat(strValueOf) : new String("Topic sync failed: "));
                return false;
            }
        }
        return true;
    }

    @GuardedBy("this")
    @Nullable
    private final String zzak() {
        String strZzae;
        synchronized (this.zzaj) {
            strZzae = this.zzaj.zzae();
        }
        if (TextUtils.isEmpty(strZzae)) {
            return null;
        }
        String[] strArrSplit = strZzae.split(",");
        if (strArrSplit.length <= 1 || TextUtils.isEmpty(strArrSplit[1])) {
            return null;
        }
        return strArrSplit[1];
    }

    private final synchronized boolean zzk(String str) {
        synchronized (this.zzaj) {
            String strZzae = this.zzaj.zzae();
            String strValueOf = String.valueOf(",");
            String strValueOf2 = String.valueOf(str);
            if (!strZzae.startsWith(strValueOf2.length() != 0 ? strValueOf.concat(strValueOf2) : new String(strValueOf))) {
                return false;
            }
            String strValueOf3 = String.valueOf(",");
            String strValueOf4 = String.valueOf(str);
            this.zzaj.zzf(strZzae.substring((strValueOf4.length() != 0 ? strValueOf3.concat(strValueOf4) : new String(strValueOf3)).length()));
            return true;
        }
    }

    final synchronized Task<Void> zza(String str) {
        String strZzae;
        TaskCompletionSource<Void> taskCompletionSource;
        synchronized (this.zzaj) {
            strZzae = this.zzaj.zzae();
            zzaq zzaqVar = this.zzaj;
            StringBuilder sb = new StringBuilder(String.valueOf(strZzae).length() + 1 + String.valueOf(str).length());
            sb.append(strZzae);
            sb.append(",");
            sb.append(str);
            zzaqVar.zzf(sb.toString());
        }
        taskCompletionSource = new TaskCompletionSource<>();
        this.zzdg.put(Integer.valueOf(this.zzdf + (TextUtils.isEmpty(strZzae) ? 0 : strZzae.split(",").length - 1)), taskCompletionSource);
        return taskCompletionSource.getTask();
    }

    @WorkerThread
    final boolean zza(FirebaseInstanceId firebaseInstanceId) {
        TaskCompletionSource<Void> taskCompletionSourceRemove;
        while (true) {
            synchronized (this) {
                String strZzak = zzak();
                if (strZzak == null) {
                    Log.d("FirebaseInstanceId", "topic sync succeeded");
                    return true;
                }
                if (!zza(firebaseInstanceId, strZzak)) {
                    return false;
                }
                synchronized (this) {
                    taskCompletionSourceRemove = this.zzdg.remove(Integer.valueOf(this.zzdf));
                    zzk(strZzak);
                    this.zzdf++;
                }
                if (taskCompletionSourceRemove != null) {
                    taskCompletionSourceRemove.setResult(null);
                }
            }
        }
    }

    final synchronized boolean zzaj() {
        return zzak() != null;
    }
}
