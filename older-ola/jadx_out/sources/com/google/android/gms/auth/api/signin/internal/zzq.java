package com.google.android.gms.auth.api.signin.internal;

import android.content.Context;
import android.support.annotation.NonNull;
import com.google.android.gms.auth.api.signin.GoogleSignInAccount;
import com.google.android.gms.auth.api.signin.GoogleSignInOptions;
import com.google.android.gms.common.util.VisibleForTesting;

/* JADX INFO: loaded from: classes.dex */
public final class zzq {
    private static zzq zzfa;

    @VisibleForTesting
    private Storage zzfb;

    @VisibleForTesting
    private GoogleSignInAccount zzfc;

    @VisibleForTesting
    private GoogleSignInOptions zzfd;

    private zzq(Context context) {
        this.zzfb = Storage.getInstance(context);
        this.zzfc = this.zzfb.getSavedDefaultGoogleSignInAccount();
        this.zzfd = this.zzfb.getSavedDefaultGoogleSignInOptions();
    }

    public static synchronized zzq zze(@NonNull Context context) {
        return zzf(context.getApplicationContext());
    }

    private static synchronized zzq zzf(Context context) {
        if (zzfa == null) {
            zzfa = new zzq(context);
        }
        return zzfa;
    }

    public final synchronized void clear() {
        this.zzfb.clear();
        this.zzfc = null;
        this.zzfd = null;
    }

    public final synchronized void zzd(GoogleSignInOptions googleSignInOptions, GoogleSignInAccount googleSignInAccount) {
        this.zzfb.saveDefaultGoogleSignInAccount(googleSignInAccount, googleSignInOptions);
        this.zzfc = googleSignInAccount;
        this.zzfd = googleSignInOptions;
    }

    public final synchronized GoogleSignInAccount zzo() {
        return this.zzfc;
    }

    public final synchronized GoogleSignInOptions zzp() {
        return this.zzfd;
    }
}
