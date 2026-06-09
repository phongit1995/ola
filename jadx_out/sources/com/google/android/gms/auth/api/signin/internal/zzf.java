package com.google.android.gms.auth.api.signin.internal;

import android.content.Context;
import android.support.v4.content.AsyncTaskLoader;
import android.util.Log;
import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.common.api.internal.SignInConnectionListener;
import java.util.Iterator;
import java.util.Set;
import java.util.concurrent.Semaphore;
import java.util.concurrent.TimeUnit;

/* JADX INFO: loaded from: classes.dex */
public final class zzf extends AsyncTaskLoader<Void> implements SignInConnectionListener {
    private Semaphore zzet;
    private Set<GoogleApiClient> zzeu;

    public zzf(Context context, Set<GoogleApiClient> set) {
        super(context);
        this.zzet = new Semaphore(0);
        this.zzeu = set;
    }

    /* JADX INFO: Access modifiers changed from: private */
    @Override // android.support.v4.content.AsyncTaskLoader
    /* JADX INFO: renamed from: zzm, reason: merged with bridge method [inline-methods] */
    public final Void loadInBackground() {
        Iterator<GoogleApiClient> it2 = this.zzeu.iterator();
        int i = 0;
        while (it2.hasNext()) {
            if (it2.next().maybeSignIn(this)) {
                i++;
            }
        }
        try {
            this.zzet.tryAcquire(i, 5L, TimeUnit.SECONDS);
            return null;
        } catch (InterruptedException e) {
            Log.i("GACSignInLoader", "Unexpected InterruptedException", e);
            Thread.currentThread().interrupt();
            return null;
        }
    }

    @Override // com.google.android.gms.common.api.internal.SignInConnectionListener
    public final void onComplete() {
        this.zzet.release();
    }

    @Override // android.support.v4.content.Loader
    protected final void onStartLoading() {
        this.zzet.drainPermits();
        forceLoad();
    }
}
