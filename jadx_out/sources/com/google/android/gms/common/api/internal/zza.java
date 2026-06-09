package com.google.android.gms.common.api.internal;

import android.app.Activity;
import android.support.annotation.MainThread;
import android.support.annotation.VisibleForTesting;
import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public final class zza extends ActivityLifecycleObserver {
    private final WeakReference<C0065zza> zzds;

    /* JADX INFO: renamed from: com.google.android.gms.common.api.internal.zza$zza, reason: collision with other inner class name */
    @VisibleForTesting(otherwise = 2)
    static class C0065zza extends LifecycleCallback {
        private List<Runnable> zzdt;

        private C0065zza(LifecycleFragment lifecycleFragment) {
            super(lifecycleFragment);
            this.zzdt = new ArrayList();
            this.mLifecycleFragment.addCallback("LifecycleObserverOnStop", this);
        }

        /* JADX INFO: Access modifiers changed from: private */
        public static C0065zza zza(Activity activity) {
            C0065zza c0065zza;
            synchronized (activity) {
                LifecycleFragment fragment = getFragment(activity);
                c0065zza = (C0065zza) fragment.getCallbackOrNull("LifecycleObserverOnStop", C0065zza.class);
                if (c0065zza == null) {
                    c0065zza = new C0065zza(fragment);
                }
            }
            return c0065zza;
        }

        /* JADX INFO: Access modifiers changed from: private */
        public final synchronized void zza(Runnable runnable) {
            this.zzdt.add(runnable);
        }

        @Override // com.google.android.gms.common.api.internal.LifecycleCallback
        @MainThread
        public void onStop() {
            List<Runnable> list;
            synchronized (this) {
                list = this.zzdt;
                this.zzdt = new ArrayList();
            }
            Iterator<Runnable> it2 = list.iterator();
            while (it2.hasNext()) {
                it2.next().run();
            }
        }
    }

    public zza(Activity activity) {
        this(C0065zza.zza(activity));
    }

    @VisibleForTesting(otherwise = 2)
    private zza(C0065zza c0065zza) {
        this.zzds = new WeakReference<>(c0065zza);
    }

    @Override // com.google.android.gms.common.api.internal.ActivityLifecycleObserver
    public final ActivityLifecycleObserver onStopCallOnce(Runnable runnable) {
        C0065zza c0065zza = this.zzds.get();
        if (c0065zza == null) {
            throw new IllegalStateException("The target activity has already been GC'd");
        }
        c0065zza.zza(runnable);
        return this;
    }
}
