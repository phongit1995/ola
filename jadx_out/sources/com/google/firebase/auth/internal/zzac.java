package com.google.firebase.auth.internal;

import com.google.android.gms.common.api.internal.BackgroundDetector;

/* JADX INFO: loaded from: classes2.dex */
final class zzac implements BackgroundDetector.BackgroundStateChangeListener {
    private final /* synthetic */ zzab zzlx;

    zzac(zzab zzabVar) {
        this.zzlx = zzabVar;
    }

    @Override // com.google.android.gms.common.api.internal.BackgroundDetector.BackgroundStateChangeListener
    public final void onBackgroundStateChanged(boolean z) {
        if (z) {
            this.zzlx.zzlw = true;
            this.zzlx.cancel();
        } else {
            this.zzlx.zzlw = false;
            if (this.zzlx.zzbm()) {
                this.zzlx.zzlv.zzbi();
            }
        }
    }
}
