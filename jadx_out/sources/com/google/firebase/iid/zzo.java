package com.google.firebase.iid;

import android.os.Build;
import android.os.Bundle;
import android.support.annotation.VisibleForTesting;
import android.util.Log;
import com.google.android.gms.tasks.Task;
import com.google.android.gms.tasks.TaskCompletionSource;
import com.google.android.gms.tasks.Tasks;
import com.google.firebase.FirebaseApp;
import java.io.IOException;
import java.util.concurrent.Executor;

/* JADX INFO: loaded from: classes2.dex */
final class zzo implements IRpc {
    private final FirebaseApp zzan;
    private final zzah zzao;

    @VisibleForTesting
    private final zzan zzbe;
    private final Executor zzbf;

    zzo(FirebaseApp firebaseApp, zzah zzahVar, Executor executor) {
        this(firebaseApp, zzahVar, executor, new zzan(firebaseApp.getApplicationContext(), zzahVar));
    }

    @VisibleForTesting
    private zzo(FirebaseApp firebaseApp, zzah zzahVar, Executor executor, zzan zzanVar) {
        this.zzan = firebaseApp;
        this.zzao = zzahVar;
        this.zzbe = zzanVar;
        this.zzbf = executor;
    }

    private final Task<Bundle> zza(String str, String str2, String str3, final Bundle bundle) {
        bundle.putString("scope", str3);
        bundle.putString("sender", str2);
        bundle.putString("subtype", str2);
        bundle.putString("appid", str);
        bundle.putString("gmp_app_id", this.zzan.getOptions().getApplicationId());
        bundle.putString("gmsv", Integer.toString(this.zzao.zzz()));
        bundle.putString("osv", Integer.toString(Build.VERSION.SDK_INT));
        bundle.putString("app_ver", this.zzao.zzx());
        bundle.putString("app_ver_name", this.zzao.zzy());
        bundle.putString("cliv", "fiid-12451000");
        final TaskCompletionSource taskCompletionSource = new TaskCompletionSource();
        this.zzbf.execute(new Runnable(this, bundle, taskCompletionSource) { // from class: com.google.firebase.iid.zzp
            private final zzo zzbg;
            private final Bundle zzbh;
            private final TaskCompletionSource zzbi;

            {
                this.zzbg = this;
                this.zzbh = bundle;
                this.zzbi = taskCompletionSource;
            }

            @Override // java.lang.Runnable
            public final void run() {
                this.zzbg.zza(this.zzbh, this.zzbi);
            }
        });
        return taskCompletionSource.getTask();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public static String zza(Bundle bundle) throws IOException {
        if (bundle == null) {
            throw new IOException("SERVICE_NOT_AVAILABLE");
        }
        String string = bundle.getString("registration_id");
        if (string != null) {
            return string;
        }
        String string2 = bundle.getString("unregistered");
        if (string2 != null) {
            return string2;
        }
        String string3 = bundle.getString("error");
        if ("RST".equals(string3)) {
            throw new IOException("INSTANCE_ID_RESET");
        }
        if (string3 != null) {
            throw new IOException(string3);
        }
        String strValueOf = String.valueOf(bundle);
        StringBuilder sb = new StringBuilder(String.valueOf(strValueOf).length() + 21);
        sb.append("Unexpected response: ");
        sb.append(strValueOf);
        Log.w("FirebaseInstanceId", sb.toString(), new Throwable());
        throw new IOException("SERVICE_NOT_AVAILABLE");
    }

    private final <T> Task<Void> zzb(Task<T> task) {
        return task.continueWith(this.zzbf, new zzq(this));
    }

    private final Task<String> zzc(Task<Bundle> task) {
        return task.continueWith(this.zzbf, new zzr(this));
    }

    @Override // com.google.firebase.iid.IRpc
    public final Task<Void> ackMessage(String str) {
        return null;
    }

    @Override // com.google.firebase.iid.IRpc
    public final Task<String> buildChannel(String str) {
        return Tasks.forResult("");
    }

    @Override // com.google.firebase.iid.IRpc
    public final Task<Void> deleteInstanceId(String str) {
        Bundle bundle = new Bundle();
        bundle.putString("iid-operation", "delete");
        bundle.putString("delete", "1");
        return zzb(zzc(zza(str, "*", "*", bundle)));
    }

    @Override // com.google.firebase.iid.IRpc
    public final Task<Void> deleteToken(String str, String str2, String str3) {
        Bundle bundle = new Bundle();
        bundle.putString("delete", "1");
        return zzb(zzc(zza(str, str2, str3, bundle)));
    }

    @Override // com.google.firebase.iid.IRpc
    public final Task<String> getToken(String str, String str2, String str3) {
        return zzc(zza(str, str2, str3, new Bundle()));
    }

    @Override // com.google.firebase.iid.IRpc
    public final Task<Void> subscribeToTopic(String str, String str2, String str3) {
        Bundle bundle = new Bundle();
        String strValueOf = String.valueOf("/topics/");
        String strValueOf2 = String.valueOf(str3);
        bundle.putString("gcm.topic", strValueOf2.length() != 0 ? strValueOf.concat(strValueOf2) : new String(strValueOf));
        String strValueOf3 = String.valueOf("/topics/");
        String strValueOf4 = String.valueOf(str3);
        return zzb(zzc(zza(str, str2, strValueOf4.length() != 0 ? strValueOf3.concat(strValueOf4) : new String(strValueOf3), bundle)));
    }

    @Override // com.google.firebase.iid.IRpc
    public final Task<Void> unsubscribeFromTopic(String str, String str2, String str3) {
        Bundle bundle = new Bundle();
        String strValueOf = String.valueOf("/topics/");
        String strValueOf2 = String.valueOf(str3);
        bundle.putString("gcm.topic", strValueOf2.length() != 0 ? strValueOf.concat(strValueOf2) : new String(strValueOf));
        bundle.putString("delete", "1");
        String strValueOf3 = String.valueOf("/topics/");
        String strValueOf4 = String.valueOf(str3);
        return zzb(zzc(zza(str, str2, strValueOf4.length() != 0 ? strValueOf3.concat(strValueOf4) : new String(strValueOf3), bundle)));
    }

    final /* synthetic */ void zza(Bundle bundle, TaskCompletionSource taskCompletionSource) {
        try {
            taskCompletionSource.setResult(this.zzbe.zzc(bundle));
        } catch (IOException e) {
            taskCompletionSource.setException(e);
        }
    }
}
