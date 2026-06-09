package com.google.firebase.iid;

import android.support.v4.util.ArrayMap;
import android.util.Log;
import android.util.Pair;
import com.google.android.gms.tasks.Continuation;
import com.google.android.gms.tasks.Task;
import java.util.Map;
import javax.annotation.concurrent.GuardedBy;

/* JADX INFO: loaded from: classes2.dex */
final class zzak {

    @GuardedBy("this")
    private final Map<Pair<String, String>, Task<String>> zzch = new ArrayMap();

    zzak() {
    }

    final /* synthetic */ Task zza(Pair pair, Task task) {
        synchronized (this) {
            this.zzch.remove(pair);
        }
        return task;
    }

    final synchronized Task<String> zza(String str, String str2, zzam zzamVar) {
        final Pair<String, String> pair = new Pair<>(str, str2);
        Task<String> task = this.zzch.get(pair);
        if (task != null) {
            if (Log.isLoggable("FirebaseInstanceId", 3)) {
                String strValueOf = String.valueOf(pair);
                StringBuilder sb = new StringBuilder(String.valueOf(strValueOf).length() + 29);
                sb.append("Joining ongoing request for: ");
                sb.append(strValueOf);
                Log.d("FirebaseInstanceId", sb.toString());
            }
            return task;
        }
        if (Log.isLoggable("FirebaseInstanceId", 3)) {
            String strValueOf2 = String.valueOf(pair);
            StringBuilder sb2 = new StringBuilder(String.valueOf(strValueOf2).length() + 24);
            sb2.append("Making new request for: ");
            sb2.append(strValueOf2);
            Log.d("FirebaseInstanceId", sb2.toString());
        }
        Task taskContinueWithTask = zzamVar.zzo().continueWithTask(FirebaseInstanceId.zzah, new Continuation(this, pair) { // from class: com.google.firebase.iid.zzal
            private final zzak zzci;
            private final Pair zzcj;

            {
                this.zzci = this;
                this.zzcj = pair;
            }

            @Override // com.google.android.gms.tasks.Continuation
            public final Object then(Task task2) {
                return this.zzci.zza(this.zzcj, task2);
            }
        });
        this.zzch.put(pair, (Task<String>) taskContinueWithTask);
        return taskContinueWithTask;
    }
}
