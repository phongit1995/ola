package com.google.firebase;

import android.annotation.TargetApi;
import android.app.Application;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.SharedPreferences;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.os.Handler;
import android.os.Looper;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.annotation.UiThread;
import android.support.annotation.VisibleForTesting;
import android.support.v4.content.ContextCompat;
import android.support.v4.util.ArrayMap;
import android.text.TextUtils;
import android.util.Log;
import com.google.android.gms.common.annotation.KeepForSdk;
import com.google.android.gms.common.api.internal.BackgroundDetector;
import com.google.android.gms.common.internal.Objects;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.util.Base64Utils;
import com.google.android.gms.common.util.PlatformVersion;
import com.google.android.gms.common.util.ProcessUtils;
import com.google.android.gms.tasks.Task;
import com.google.android.gms.tasks.Tasks;
import com.google.firebase.auth.GetTokenResult;
import com.google.firebase.components.Component;
import com.google.firebase.components.zzc;
import com.google.firebase.components.zzd;
import com.google.firebase.events.Event;
import com.google.firebase.events.Publisher;
import com.google.firebase.internal.InternalTokenProvider;
import com.google.firebase.internal.InternalTokenResult;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.concurrent.Executor;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.atomic.AtomicReference;
import javax.annotation.concurrent.GuardedBy;

/* JADX INFO: loaded from: classes2.dex */
public class FirebaseApp {
    public static final String DEFAULT_APP_NAME = "[DEFAULT]";
    private final Context zzi;
    private final String zzj;
    private final FirebaseOptions zzk;
    private final zzd zzl;
    private final SharedPreferences zzm;
    private final Publisher zzn;
    private InternalTokenProvider zzu;
    private static final List<String> zzb = Arrays.asList("com.google.firebase.auth.FirebaseAuth", "com.google.firebase.iid.FirebaseInstanceId");
    private static final List<String> zzc = Collections.singletonList("com.google.firebase.crash.FirebaseCrash");
    private static final List<String> zzd = Arrays.asList("com.google.android.gms.measurement.AppMeasurement");
    private static final List<String> zze = Arrays.asList(new String[0]);
    private static final Set<String> zzf = Collections.emptySet();
    private static final Object zzg = new Object();
    private static final Executor zzh = new zza(0);

    @GuardedBy("LOCK")
    static final Map<String, FirebaseApp> zza = new ArrayMap();
    private final AtomicBoolean zzo = new AtomicBoolean(false);
    private final AtomicBoolean zzp = new AtomicBoolean();
    private final List<IdTokenListener> zzr = new CopyOnWriteArrayList();
    private final List<BackgroundStateChangeListener> zzs = new CopyOnWriteArrayList();
    private final List<com.google.firebase.zza> zzt = new CopyOnWriteArrayList();
    private IdTokenListenersCountChangedListener zzv = new com.google.firebase.internal.zza();
    private final AtomicBoolean zzq = new AtomicBoolean(zzb());

    @KeepForSdk
    public interface BackgroundStateChangeListener {
        void onBackgroundStateChanged(boolean z);
    }

    @KeepForSdk
    public interface IdTokenListener {
        void onIdTokenChanged(@NonNull InternalTokenResult internalTokenResult);
    }

    @KeepForSdk
    public interface IdTokenListenersCountChangedListener {
        void onListenerCountChanged(int i);
    }

    static class zza implements Executor {
        private static final Handler zza = new Handler(Looper.getMainLooper());

        private zza() {
        }

        /* synthetic */ zza(byte b) {
            this();
        }

        @Override // java.util.concurrent.Executor
        public final void execute(@NonNull Runnable runnable) {
            zza.post(runnable);
        }
    }

    @TargetApi(24)
    static class zzb extends BroadcastReceiver {
        private static AtomicReference<zzb> zza = new AtomicReference<>();
        private final Context zzb;

        private zzb(Context context) {
            this.zzb = context;
        }

        static /* synthetic */ void zza(Context context) {
            if (zza.get() == null) {
                zzb zzbVar = new zzb(context);
                if (zza.compareAndSet(null, zzbVar)) {
                    context.registerReceiver(zzbVar, new IntentFilter("android.intent.action.USER_UNLOCKED"));
                }
            }
        }

        @Override // android.content.BroadcastReceiver
        public final void onReceive(Context context, Intent intent) {
            synchronized (FirebaseApp.zzg) {
                Iterator<FirebaseApp> it2 = FirebaseApp.zza.values().iterator();
                while (it2.hasNext()) {
                    it2.next().zze();
                }
            }
            this.zzb.unregisterReceiver(this);
        }
    }

    protected FirebaseApp(Context context, String str, FirebaseOptions firebaseOptions) {
        this.zzi = (Context) Preconditions.checkNotNull(context);
        this.zzj = Preconditions.checkNotEmpty(str);
        this.zzk = (FirebaseOptions) Preconditions.checkNotNull(firebaseOptions);
        this.zzm = context.getSharedPreferences("com.google.firebase.common.prefs", 0);
        this.zzl = new zzd(zzh, new zzc(context).zza(), Component.of(context, Context.class, new Class[0]), Component.of(this, FirebaseApp.class, new Class[0]), Component.of(firebaseOptions, FirebaseOptions.class, new Class[0]));
        this.zzn = (Publisher) this.zzl.get(Publisher.class);
    }

    @VisibleForTesting
    public static void clearInstancesForTest() {
        synchronized (zzg) {
            zza.clear();
        }
    }

    public static List<FirebaseApp> getApps(Context context) {
        ArrayList arrayList;
        synchronized (zzg) {
            arrayList = new ArrayList(zza.values());
        }
        return arrayList;
    }

    @Nullable
    public static FirebaseApp getInstance() {
        FirebaseApp firebaseApp;
        synchronized (zzg) {
            firebaseApp = zza.get(DEFAULT_APP_NAME);
            if (firebaseApp == null) {
                throw new IllegalStateException("Default FirebaseApp is not initialized in this process " + ProcessUtils.getMyProcessName() + ". Make sure to call FirebaseApp.initializeApp(Context) first.");
            }
        }
        return firebaseApp;
    }

    public static FirebaseApp getInstance(@NonNull String str) {
        FirebaseApp firebaseApp;
        String str2;
        synchronized (zzg) {
            firebaseApp = zza.get(str.trim());
            if (firebaseApp == null) {
                List<String> listZzd = zzd();
                if (listZzd.isEmpty()) {
                    str2 = "";
                } else {
                    str2 = "Available app names: " + TextUtils.join(", ", listZzd);
                }
                throw new IllegalStateException(String.format("FirebaseApp with name %s doesn't exist. %s", str, str2));
            }
        }
        return firebaseApp;
    }

    public static String getPersistenceKey(String str, FirebaseOptions firebaseOptions) {
        return Base64Utils.encodeUrlSafeNoPadding(str.getBytes()) + "+" + Base64Utils.encodeUrlSafeNoPadding(firebaseOptions.getApplicationId().getBytes());
    }

    @Nullable
    public static FirebaseApp initializeApp(Context context) {
        synchronized (zzg) {
            if (zza.containsKey(DEFAULT_APP_NAME)) {
                return getInstance();
            }
            FirebaseOptions firebaseOptionsFromResource = FirebaseOptions.fromResource(context);
            if (firebaseOptionsFromResource == null) {
                return null;
            }
            return initializeApp(context, firebaseOptionsFromResource);
        }
    }

    public static FirebaseApp initializeApp(Context context, FirebaseOptions firebaseOptions) {
        return initializeApp(context, firebaseOptions, DEFAULT_APP_NAME);
    }

    public static FirebaseApp initializeApp(Context context, FirebaseOptions firebaseOptions, String str) {
        FirebaseApp firebaseApp;
        if (PlatformVersion.isAtLeastIceCreamSandwich() && (context.getApplicationContext() instanceof Application)) {
            BackgroundDetector.initialize((Application) context.getApplicationContext());
            BackgroundDetector.getInstance().addListener(new BackgroundDetector.BackgroundStateChangeListener() { // from class: com.google.firebase.FirebaseApp.1
                @Override // com.google.android.gms.common.api.internal.BackgroundDetector.BackgroundStateChangeListener
                public final void onBackgroundStateChanged(boolean z) {
                    FirebaseApp.onBackgroundStateChanged(z);
                }
            });
        }
        String strTrim = str.trim();
        if (context.getApplicationContext() != null) {
            context = context.getApplicationContext();
        }
        synchronized (zzg) {
            Preconditions.checkState(!zza.containsKey(strTrim), "FirebaseApp name " + strTrim + " already exists!");
            Preconditions.checkNotNull(context, "Application context cannot be null.");
            firebaseApp = new FirebaseApp(context, strTrim, firebaseOptions);
            zza.put(strTrim, firebaseApp);
        }
        firebaseApp.zze();
        return firebaseApp;
    }

    public static void onBackgroundStateChanged(boolean z) {
        synchronized (zzg) {
            for (FirebaseApp firebaseApp : new ArrayList(zza.values())) {
                if (firebaseApp.zzo.get()) {
                    firebaseApp.zza(z);
                }
            }
        }
    }

    /* JADX WARN: Multi-variable type inference failed */
    private static <T> void zza(Class<T> cls, T t, Iterable<String> iterable, boolean z) {
        for (String str : iterable) {
            if (z) {
                try {
                } catch (ClassNotFoundException unused) {
                    if (zzf.contains(str)) {
                        throw new IllegalStateException(str + " is missing, but is required. Check if it has been removed by Proguard.");
                    }
                    Log.d("FirebaseApp", str + " is not linked. Skipping initialization.");
                } catch (IllegalAccessException e) {
                    Log.wtf("FirebaseApp", "Failed to initialize " + str, e);
                } catch (NoSuchMethodException unused2) {
                    throw new IllegalStateException(str + "#getInstance has been removed by Proguard. Add keep rule to prevent it.");
                } catch (InvocationTargetException e2) {
                    Log.wtf("FirebaseApp", "Firebase API initialization failure.", e2);
                }
                if (zze.contains(str)) {
                }
            }
            Method method = Class.forName(str).getMethod("getInstance", cls);
            int modifiers = method.getModifiers();
            if (Modifier.isPublic(modifiers) && Modifier.isStatic(modifiers)) {
                method.invoke(null, t);
            }
        }
    }

    private void zza(boolean z) {
        Log.d("FirebaseApp", "Notifying background state change listeners.");
        Iterator<BackgroundStateChangeListener> it2 = this.zzs.iterator();
        while (it2.hasNext()) {
            it2.next().onBackgroundStateChanged(z);
        }
    }

    private boolean zzb() {
        ApplicationInfo applicationInfo;
        if (this.zzm.contains("firebase_automatic_data_collection_enabled")) {
            return this.zzm.getBoolean("firebase_automatic_data_collection_enabled", true);
        }
        try {
            PackageManager packageManager = this.zzi.getPackageManager();
            if (packageManager != null && (applicationInfo = packageManager.getApplicationInfo(this.zzi.getPackageName(), 128)) != null && applicationInfo.metaData != null && applicationInfo.metaData.containsKey("firebase_automatic_data_collection_enabled")) {
                return applicationInfo.metaData.getBoolean("firebase_automatic_data_collection_enabled");
            }
        } catch (PackageManager.NameNotFoundException unused) {
        }
        return true;
    }

    private void zzc() {
        Preconditions.checkState(!this.zzp.get(), "FirebaseApp was deleted");
    }

    private static List<String> zzd() {
        ArrayList arrayList = new ArrayList();
        synchronized (zzg) {
            Iterator<FirebaseApp> it2 = zza.values().iterator();
            while (it2.hasNext()) {
                arrayList.add(it2.next().getName());
            }
        }
        Collections.sort(arrayList);
        return arrayList;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void zze() {
        boolean zIsDeviceProtectedStorage = ContextCompat.isDeviceProtectedStorage(this.zzi);
        if (zIsDeviceProtectedStorage) {
            zzb.zza(this.zzi);
        } else {
            this.zzl.zza(isDefaultApp());
        }
        zza(FirebaseApp.class, this, zzb, zIsDeviceProtectedStorage);
        if (isDefaultApp()) {
            zza(FirebaseApp.class, this, zzc, zIsDeviceProtectedStorage);
            zza(Context.class, this.zzi, zzd, zIsDeviceProtectedStorage);
        }
    }

    public void addBackgroundStateChangeListener(BackgroundStateChangeListener backgroundStateChangeListener) {
        zzc();
        if (this.zzo.get() && BackgroundDetector.getInstance().isInBackground()) {
            backgroundStateChangeListener.onBackgroundStateChanged(true);
        }
        this.zzs.add(backgroundStateChangeListener);
    }

    public void addIdTokenListener(@NonNull IdTokenListener idTokenListener) {
        zzc();
        Preconditions.checkNotNull(idTokenListener);
        this.zzr.add(idTokenListener);
        this.zzv.onListenerCountChanged(this.zzr.size());
    }

    public void addLifecycleEventListener(@NonNull com.google.firebase.zza zzaVar) {
        zzc();
        Preconditions.checkNotNull(zzaVar);
        this.zzt.add(zzaVar);
    }

    public void delete() {
        if (this.zzp.compareAndSet(false, true)) {
            synchronized (zzg) {
                zza.remove(this.zzj);
            }
            Iterator<com.google.firebase.zza> it2 = this.zzt.iterator();
            while (it2.hasNext()) {
                it2.next();
            }
        }
    }

    public boolean equals(Object obj) {
        if (obj instanceof FirebaseApp) {
            return this.zzj.equals(((FirebaseApp) obj).getName());
        }
        return false;
    }

    public <T> T get(Class<T> cls) {
        zzc();
        return (T) this.zzl.get(cls);
    }

    @NonNull
    public Context getApplicationContext() {
        zzc();
        return this.zzi;
    }

    public List<IdTokenListener> getListeners() {
        zzc();
        return this.zzr;
    }

    @NonNull
    public String getName() {
        zzc();
        return this.zzj;
    }

    @NonNull
    public FirebaseOptions getOptions() {
        zzc();
        return this.zzk;
    }

    public String getPersistenceKey() {
        return Base64Utils.encodeUrlSafeNoPadding(getName().getBytes()) + "+" + Base64Utils.encodeUrlSafeNoPadding(getOptions().getApplicationId().getBytes());
    }

    public Task<GetTokenResult> getToken(boolean z) {
        zzc();
        return this.zzu == null ? Tasks.forException(new FirebaseApiNotAvailableException("firebase-auth is not linked, please fall back to unauthenticated mode.")) : this.zzu.getAccessToken(z);
    }

    @Nullable
    public String getUid() throws FirebaseApiNotAvailableException {
        zzc();
        if (this.zzu == null) {
            throw new FirebaseApiNotAvailableException("firebase-auth is not linked, please fall back to unauthenticated mode.");
        }
        return this.zzu.getUid();
    }

    public int hashCode() {
        return this.zzj.hashCode();
    }

    public boolean isAutomaticDataCollectionEnabled() {
        zzc();
        return this.zzq.get();
    }

    @VisibleForTesting
    public boolean isDefaultApp() {
        return DEFAULT_APP_NAME.equals(getName());
    }

    @UiThread
    public void notifyIdTokenListeners(@NonNull InternalTokenResult internalTokenResult) {
        Log.d("FirebaseApp", "Notifying auth state listeners.");
        Iterator<IdTokenListener> it2 = this.zzr.iterator();
        int i = 0;
        while (it2.hasNext()) {
            it2.next().onIdTokenChanged(internalTokenResult);
            i++;
        }
        Log.d("FirebaseApp", String.format("Notified %d auth state listeners.", Integer.valueOf(i)));
    }

    public void removeBackgroundStateChangeListener(BackgroundStateChangeListener backgroundStateChangeListener) {
        zzc();
        this.zzs.remove(backgroundStateChangeListener);
    }

    public void removeIdTokenListener(@NonNull IdTokenListener idTokenListener) {
        zzc();
        Preconditions.checkNotNull(idTokenListener);
        this.zzr.remove(idTokenListener);
        this.zzv.onListenerCountChanged(this.zzr.size());
    }

    public void removeLifecycleEventListener(@NonNull com.google.firebase.zza zzaVar) {
        zzc();
        Preconditions.checkNotNull(zzaVar);
        this.zzt.remove(zzaVar);
    }

    public void setAutomaticDataCollectionEnabled(boolean z) {
        zzc();
        if (this.zzq.compareAndSet(!z, z)) {
            this.zzm.edit().putBoolean("firebase_automatic_data_collection_enabled", z).commit();
            this.zzn.publish(new Event<>(AutomaticDataCollectionChange.class, new AutomaticDataCollectionChange(z)));
        }
    }

    public void setAutomaticResourceManagementEnabled(boolean z) {
        zzc();
        if (this.zzo.compareAndSet(!z, z)) {
            boolean zIsInBackground = BackgroundDetector.getInstance().isInBackground();
            if (z && zIsInBackground) {
                zza(true);
            } else {
                if (z || !zIsInBackground) {
                    return;
                }
                zza(false);
            }
        }
    }

    public void setIdTokenListenersCountChangedListener(@NonNull IdTokenListenersCountChangedListener idTokenListenersCountChangedListener) {
        this.zzv = (IdTokenListenersCountChangedListener) Preconditions.checkNotNull(idTokenListenersCountChangedListener);
        this.zzv.onListenerCountChanged(this.zzr.size());
    }

    public void setTokenProvider(@NonNull InternalTokenProvider internalTokenProvider) {
        this.zzu = (InternalTokenProvider) Preconditions.checkNotNull(internalTokenProvider);
    }

    public String toString() {
        return Objects.toStringHelper(this).add("name", this.zzj).add("options", this.zzk).toString();
    }
}
