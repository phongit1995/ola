package com.google.firebase.auth.internal;

import android.app.Application;
import android.content.Context;
import android.support.annotation.NonNull;
import com.google.android.gms.common.api.internal.BackgroundDetector;
import com.google.android.gms.common.util.VisibleForTesting;
import com.google.android.gms.internal.firebase_auth.zzao;
import com.google.firebase.FirebaseApp;

/* JADX INFO: loaded from: classes2.dex */
public final class zzab implements FirebaseApp.IdTokenListenersCountChangedListener {
    private volatile int zzlt;
    private volatile int zzlu;
    private final zzs zzlv;
    private volatile boolean zzlw;

    @VisibleForTesting
    private zzab(@NonNull Context context, @NonNull zzs zzsVar) {
        this.zzlw = false;
        this.zzlt = 0;
        this.zzlu = 0;
        this.zzlv = zzsVar;
        BackgroundDetector.initialize((Application) context.getApplicationContext());
        BackgroundDetector.getInstance().addListener(new zzac(this));
    }

    public zzab(@NonNull FirebaseApp firebaseApp) {
        this(firebaseApp.getApplicationContext(), new zzs(firebaseApp));
    }

    /* JADX INFO: Access modifiers changed from: private */
    public final boolean zzbm() {
        return this.zzlt + this.zzlu > 0 && !this.zzlw;
    }

    public final void cancel() {
        this.zzlv.cancel();
    }

    @Override // com.google.firebase.FirebaseApp.IdTokenListenersCountChangedListener
    public final void onListenerCountChanged(int i) {
        if (i > 0 && this.zzlt == 0 && this.zzlu == 0) {
            this.zzlt = i;
            if (zzbm()) {
                this.zzlv.zzbi();
            }
        } else if (i == 0 && this.zzlt != 0 && this.zzlu == 0) {
            this.zzlv.cancel();
        }
        this.zzlt = i;
    }

    public final void zzc(@NonNull zzao zzaoVar) {
        if (zzaoVar == null) {
            return;
        }
        long jZzaq = zzaoVar.zzaq();
        if (jZzaq <= 0) {
            jZzaq = 3600;
        }
        long jZzay = zzaoVar.zzay() + (jZzaq * 1000);
        zzs zzsVar = this.zzlv;
        zzsVar.zzlh = jZzay;
        zzsVar.zzli = -1L;
        if (zzbm()) {
            this.zzlv.zzbi();
        }
    }

    public final void zzf(int i) {
        if (i > 0 && this.zzlu == 0 && this.zzlt == 0) {
            this.zzlu = i;
            if (zzbm()) {
                this.zzlv.zzbi();
            }
        } else if (i == 0 && this.zzlu != 0 && this.zzlt == 0) {
            this.zzlv.cancel();
        }
        this.zzlu = i;
    }
}
