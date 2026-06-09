package com.google.firebase.auth.api.internal;

import android.app.Activity;
import android.support.annotation.MainThread;
import com.google.android.gms.common.api.Status;
import com.google.android.gms.common.api.internal.LifecycleCallback;
import com.google.android.gms.common.api.internal.LifecycleFragment;
import com.google.android.gms.common.internal.Preconditions;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.firebase.FirebaseApp;
import com.google.firebase.auth.FirebaseUser;
import com.google.firebase.auth.PhoneAuthCredential;
import com.google.firebase.auth.PhoneAuthProvider;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.Executor;

/* JADX INFO: loaded from: classes2.dex */
abstract class zzcy<SuccessT, CallbackT> {
    protected FirebaseApp zzeb;
    protected String zzey;
    protected final int zzia;
    protected FirebaseUser zzic;
    protected zzck zzid;
    protected CallbackT zzie;
    protected com.google.firebase.auth.internal.zzw zzif;
    protected zzcx<SuccessT> zzig;
    private Activity zzii;
    protected Executor zzij;
    protected zzda zzik;
    protected com.google.android.gms.internal.firebase_auth.zzao zzil;
    protected com.google.android.gms.internal.firebase_auth.zzaj zzim;
    protected com.google.android.gms.internal.firebase_auth.zzx zzin;
    protected com.google.android.gms.internal.firebase_auth.zzav zzio;
    protected String zzip;
    protected PhoneAuthCredential zziq;
    private boolean zzir;

    @VisibleForTesting
    boolean zzis;

    @VisibleForTesting
    private SuccessT zzit;

    @VisibleForTesting
    private Status zziu;
    protected final zzdb zzib = new zzdb(this);
    protected final List<PhoneAuthProvider.OnVerificationStateChangedCallbacks> zzih = new ArrayList();

    static class zza extends LifecycleCallback {
        private List<PhoneAuthProvider.OnVerificationStateChangedCallbacks> zziv;

        private zza(LifecycleFragment lifecycleFragment, List<PhoneAuthProvider.OnVerificationStateChangedCallbacks> list) {
            super(lifecycleFragment);
            this.mLifecycleFragment.addCallback("PhoneAuthActivityStopCallback", this);
            this.zziv = list;
        }

        public static void zza(Activity activity, List<PhoneAuthProvider.OnVerificationStateChangedCallbacks> list) {
            LifecycleFragment fragment = getFragment(activity);
            if (((zza) fragment.getCallbackOrNull("PhoneAuthActivityStopCallback", zza.class)) == null) {
                new zza(fragment, list);
            }
        }

        @Override // com.google.android.gms.common.api.internal.LifecycleCallback
        @MainThread
        public void onStop() {
            synchronized (this.zziv) {
                this.zziv.clear();
            }
        }
    }

    public zzcy(int i) {
        this.zzia = i;
    }

    static /* synthetic */ boolean zza(zzcy zzcyVar, boolean z) {
        zzcyVar.zzir = true;
        return true;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public final void zzam() {
        zzab();
        Preconditions.checkState(this.zzir, "no success or failure set on method implementation");
    }

    /* JADX INFO: Access modifiers changed from: private */
    public final void zzd(Status status) {
        if (this.zzif != null) {
            this.zzif.zza(status);
        }
    }

    public final zzcy<SuccessT, CallbackT> zza(FirebaseApp firebaseApp) {
        this.zzeb = (FirebaseApp) Preconditions.checkNotNull(firebaseApp, "firebaseApp cannot be null");
        return this;
    }

    public final zzcy<SuccessT, CallbackT> zza(PhoneAuthProvider.OnVerificationStateChangedCallbacks onVerificationStateChangedCallbacks, Activity activity, Executor executor) {
        synchronized (this.zzih) {
            this.zzih.add((PhoneAuthProvider.OnVerificationStateChangedCallbacks) Preconditions.checkNotNull(onVerificationStateChangedCallbacks));
        }
        this.zzii = activity;
        if (this.zzii != null) {
            zza.zza(activity, this.zzih);
        }
        this.zzij = (Executor) Preconditions.checkNotNull(executor);
        return this;
    }

    public final zzcy<SuccessT, CallbackT> zza(com.google.firebase.auth.internal.zzw zzwVar) {
        this.zzif = (com.google.firebase.auth.internal.zzw) Preconditions.checkNotNull(zzwVar, "external failure callback cannot be null");
        return this;
    }

    public final zzcy<SuccessT, CallbackT> zza(CallbackT callbackt) {
        this.zzie = (CallbackT) Preconditions.checkNotNull(callbackt, "external callback cannot be null");
        return this;
    }

    protected abstract void zzaa();

    public abstract void zzab();

    public final void zzb(SuccessT successt) {
        this.zzir = true;
        this.zzis = true;
        this.zzit = successt;
        this.zzig.zza(successt, null);
    }

    public final void zzc(Status status) {
        this.zzir = true;
        this.zzis = false;
        this.zziu = status;
        this.zzig.zza(null, status);
    }

    public final zzcy<SuccessT, CallbackT> zzf(FirebaseUser firebaseUser) {
        this.zzic = (FirebaseUser) Preconditions.checkNotNull(firebaseUser, "firebaseUser cannot be null");
        return this;
    }
}
