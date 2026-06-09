package com.google.firebase.iid;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.content.pm.ResolveInfo;
import android.os.Build;
import android.os.Looper;
import android.support.annotation.Keep;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.annotation.WorkerThread;
import android.util.Log;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.android.gms.measurement.AppMeasurement;
import com.google.android.gms.tasks.OnCompleteListener;
import com.google.android.gms.tasks.Task;
import com.google.android.gms.tasks.TaskCompletionSource;
import com.google.android.gms.tasks.Tasks;
import com.google.firebase.FirebaseApp;
import java.io.IOException;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.Executor;
import java.util.concurrent.Executors;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ScheduledThreadPoolExecutor;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;
import javax.annotation.concurrent.GuardedBy;

/* JADX INFO: loaded from: classes.dex */
public class FirebaseInstanceId {
    private static zzaq zzaj;

    @VisibleForTesting
    @GuardedBy("FirebaseInstanceId.class")
    private static ScheduledThreadPoolExecutor zzal;
    private final FirebaseApp zzan;
    private final zzah zzao;
    private IRpc zzap;
    private final zzak zzaq;
    private final zzau zzar;

    @GuardedBy("this")
    private boolean zzas;

    @GuardedBy("this")
    private boolean zzat;
    static final Executor zzah = zzn.zzba;
    private static final long zzai = TimeUnit.HOURS.toSeconds(8);
    private static final Executor zzak = Executors.newCachedThreadPool();
    private static final Executor zzam = new ThreadPoolExecutor(0, 1, 30, TimeUnit.SECONDS, new LinkedBlockingQueue());

    FirebaseInstanceId(FirebaseApp firebaseApp) {
        this(firebaseApp, new zzah(firebaseApp.getApplicationContext()));
    }

    private FirebaseInstanceId(FirebaseApp firebaseApp, zzah zzahVar) {
        this.zzaq = new zzak();
        this.zzas = false;
        if (zzah.zza(firebaseApp) == null) {
            throw new IllegalStateException("FirebaseInstanceId failed to initialize, FirebaseApp is missing project ID");
        }
        synchronized (FirebaseInstanceId.class) {
            if (zzaj == null) {
                zzaj = new zzaq(firebaseApp.getApplicationContext());
            }
        }
        this.zzan = firebaseApp;
        this.zzao = zzahVar;
        if (this.zzap == null) {
            IRpc iRpc = (IRpc) firebaseApp.get(IRpc.class);
            this.zzap = iRpc == null ? new zzo(firebaseApp, zzahVar, zzam) : iRpc;
        }
        this.zzap = this.zzap;
        this.zzar = new zzau(zzaj);
        this.zzat = zzl();
        if (zzn()) {
            zzd();
        }
    }

    public static FirebaseInstanceId getInstance() {
        return getInstance(FirebaseApp.getInstance());
    }

    @Keep
    public static synchronized FirebaseInstanceId getInstance(@NonNull FirebaseApp firebaseApp) {
        return (FirebaseInstanceId) firebaseApp.get(FirebaseInstanceId.class);
    }

    private final synchronized void startSync() {
        if (!this.zzas) {
            zza(0L);
        }
    }

    private final <T> T zza(Task<T> task) throws IOException {
        try {
            return (T) Tasks.await(task, 30000L, TimeUnit.MILLISECONDS);
        } catch (InterruptedException | TimeoutException unused) {
            throw new IOException("SERVICE_NOT_AVAILABLE");
        } catch (ExecutionException e) {
            Throwable cause = e.getCause();
            if (cause instanceof IOException) {
                if ("INSTANCE_ID_RESET".equals(cause.getMessage())) {
                    zzj();
                }
                throw ((IOException) cause);
            }
            if (cause instanceof RuntimeException) {
                throw ((RuntimeException) cause);
            }
            throw new IOException(e);
        }
    }

    static void zza(Runnable runnable, long j) {
        synchronized (FirebaseInstanceId.class) {
            if (zzal == null) {
                zzal = new ScheduledThreadPoolExecutor(1);
            }
            zzal.schedule(runnable, j, TimeUnit.SECONDS);
        }
    }

    private static String zzd(String str) {
        return (str.isEmpty() || str.equalsIgnoreCase(AppMeasurement.FCM_ORIGIN) || str.equalsIgnoreCase("gcm")) ? "*" : str;
    }

    private final void zzd() {
        zzar zzarVarZzg = zzg();
        if (zzarVarZzg == null || zzarVarZzg.zzj(this.zzao.zzx()) || this.zzar.zzaj()) {
            startSync();
        }
    }

    private static String zzf() {
        return zzah.zza(zzaj.zzg("").getKeyPair());
    }

    static boolean zzi() {
        if (Log.isLoggable("FirebaseInstanceId", 3)) {
            return true;
        }
        return Build.VERSION.SDK_INT == 23 && Log.isLoggable("FirebaseInstanceId", 3);
    }

    private final boolean zzl() {
        ApplicationInfo applicationInfo;
        Context applicationContext = this.zzan.getApplicationContext();
        SharedPreferences sharedPreferences = applicationContext.getSharedPreferences("com.google.firebase.messaging", 0);
        if (sharedPreferences.contains("auto_init")) {
            return sharedPreferences.getBoolean("auto_init", true);
        }
        try {
            PackageManager packageManager = applicationContext.getPackageManager();
            if (packageManager != null && (applicationInfo = packageManager.getApplicationInfo(applicationContext.getPackageName(), 128)) != null && applicationInfo.metaData != null && applicationInfo.metaData.containsKey("firebase_messaging_auto_init_enabled")) {
                return applicationInfo.metaData.getBoolean("firebase_messaging_auto_init_enabled");
            }
        } catch (PackageManager.NameNotFoundException unused) {
        }
        return zzm();
    }

    private final boolean zzm() {
        try {
            Class.forName("com.google.firebase.messaging.FirebaseMessaging");
            return true;
        } catch (ClassNotFoundException unused) {
            Context applicationContext = this.zzan.getApplicationContext();
            Intent intent = new Intent("com.google.firebase.MESSAGING_EVENT");
            intent.setPackage(applicationContext.getPackageName());
            ResolveInfo resolveInfoResolveService = applicationContext.getPackageManager().resolveService(intent, 0);
            return (resolveInfoResolveService == null || resolveInfoResolveService.serviceInfo == null) ? false : true;
        }
    }

    @WorkerThread
    public void deleteInstanceId() throws IOException {
        if (Looper.getMainLooper() == Looper.myLooper()) {
            throw new IOException("MAIN_THREAD");
        }
        zza(this.zzap.deleteInstanceId(zzf()));
        zzj();
    }

    @WorkerThread
    public void deleteToken(String str, String str2) throws IOException {
        if (Looper.getMainLooper() == Looper.myLooper()) {
            throw new IOException("MAIN_THREAD");
        }
        String strZzd = zzd(str2);
        zza(this.zzap.deleteToken(zzf(), str, strZzd));
        zzaj.zzd("", str, strZzd);
    }

    public long getCreationTime() {
        return zzaj.zzg("").getCreationTime();
    }

    @WorkerThread
    public String getId() {
        zzd();
        return zzf();
    }

    @Nullable
    public String getToken() {
        zzar zzarVarZzg = zzg();
        if (zzarVarZzg == null || zzarVarZzg.zzj(this.zzao.zzx())) {
            startSync();
        }
        if (zzarVarZzg != null) {
            return zzarVarZzg.zzcz;
        }
        return null;
    }

    @WorkerThread
    public String getToken(final String str, final String str2) throws IOException {
        if (Looper.getMainLooper() == Looper.myLooper()) {
            throw new IOException("MAIN_THREAD");
        }
        final String strZzd = zzd(str2);
        final TaskCompletionSource taskCompletionSource = new TaskCompletionSource();
        zzak.execute(new Runnable(this, str, str2, taskCompletionSource, strZzd) { // from class: com.google.firebase.iid.zzk
            private final FirebaseInstanceId zzau;
            private final String zzav;
            private final String zzaw;
            private final TaskCompletionSource zzax;
            private final String zzay;

            {
                this.zzau = this;
                this.zzav = str;
                this.zzaw = str2;
                this.zzax = taskCompletionSource;
                this.zzay = strZzd;
            }

            @Override // java.lang.Runnable
            public final void run() {
                this.zzau.zza(this.zzav, this.zzaw, this.zzax, this.zzay);
            }
        });
        return (String) zza(taskCompletionSource.getTask());
    }

    public final synchronized Task<Void> zza(String str) {
        Task<Void> taskZza;
        taskZza = this.zzar.zza(str);
        startSync();
        return taskZza;
    }

    final /* synthetic */ Task zza(String str, String str2, String str3) {
        return this.zzap.getToken(str, str2, str3);
    }

    final synchronized void zza(long j) {
        zza(new zzas(this, this.zzao, this.zzar, Math.min(Math.max(30L, j << 1), zzai)), j);
        this.zzas = true;
    }

    final /* synthetic */ void zza(String str, String str2, TaskCompletionSource taskCompletionSource, Task task) {
        if (!task.isSuccessful()) {
            taskCompletionSource.setException(task.getException());
            return;
        }
        String str3 = (String) task.getResult();
        zzaj.zza("", str, str2, str3, this.zzao.zzx());
        taskCompletionSource.setResult(str3);
    }

    final /* synthetic */ void zza(final String str, String str2, final TaskCompletionSource taskCompletionSource, final String str3) {
        zzar zzarVarZzc = zzaj.zzc("", str, str2);
        if (zzarVarZzc != null && !zzarVarZzc.zzj(this.zzao.zzx())) {
            taskCompletionSource.setResult(zzarVarZzc.zzcz);
        } else {
            final String strZzf = zzf();
            this.zzaq.zza(str, str3, new zzam(this, strZzf, str, str3) { // from class: com.google.firebase.iid.zzl
                private final FirebaseInstanceId zzau;
                private final String zzav;
                private final String zzaw;
                private final String zzaz;

                {
                    this.zzau = this;
                    this.zzav = strZzf;
                    this.zzaw = str;
                    this.zzaz = str3;
                }

                @Override // com.google.firebase.iid.zzam
                public final Task zzo() {
                    return this.zzau.zza(this.zzav, this.zzaw, this.zzaz);
                }
            }).addOnCompleteListener(zzak, new OnCompleteListener(this, str, str3, taskCompletionSource) { // from class: com.google.firebase.iid.zzm
                private final FirebaseInstanceId zzau;
                private final String zzav;
                private final String zzaw;
                private final TaskCompletionSource zzax;

                {
                    this.zzau = this;
                    this.zzav = str;
                    this.zzaw = str3;
                    this.zzax = taskCompletionSource;
                }

                @Override // com.google.android.gms.tasks.OnCompleteListener
                public final void onComplete(Task task) {
                    this.zzau.zza(this.zzav, this.zzaw, this.zzax, task);
                }
            });
        }
    }

    final synchronized void zza(boolean z) {
        this.zzas = z;
    }

    final void zzb(String str) throws IOException {
        zzar zzarVarZzg = zzg();
        if (zzarVarZzg == null || zzarVarZzg.zzj(this.zzao.zzx())) {
            throw new IOException("token not available");
        }
        zza(this.zzap.subscribeToTopic(zzf(), zzarVarZzg.zzcz, str));
    }

    @VisibleForTesting
    public final synchronized void zzb(boolean z) {
        SharedPreferences.Editor editorEdit = this.zzan.getApplicationContext().getSharedPreferences("com.google.firebase.messaging", 0).edit();
        editorEdit.putBoolean("auto_init", z);
        editorEdit.apply();
        if (!this.zzat && z) {
            zzd();
        }
        this.zzat = z;
    }

    final void zzc(String str) throws IOException {
        zzar zzarVarZzg = zzg();
        if (zzarVarZzg == null || zzarVarZzg.zzj(this.zzao.zzx())) {
            throw new IOException("token not available");
        }
        zza(this.zzap.unsubscribeFromTopic(zzf(), zzarVarZzg.zzcz, str));
    }

    final FirebaseApp zze() {
        return this.zzan;
    }

    @Nullable
    final zzar zzg() {
        return zzaj.zzc("", zzah.zza(this.zzan), "*");
    }

    final String zzh() {
        return getToken(zzah.zza(this.zzan), "*");
    }

    final synchronized void zzj() {
        zzaj.zzaf();
        if (zzn()) {
            startSync();
        }
    }

    final void zzk() {
        zzaj.zzh("");
        startSync();
    }

    @VisibleForTesting
    public final synchronized boolean zzn() {
        return this.zzat;
    }
}
