package com.google.android.gms.ads.internal;

import android.view.MotionEvent;
import android.view.View;

/* JADX INFO: loaded from: classes.dex */
final class zzbr implements View.OnTouchListener {
    private final /* synthetic */ zzbp zzaba;

    zzbr(zzbp zzbpVar) {
        this.zzaba = zzbpVar;
    }

    @Override // android.view.View.OnTouchListener
    public final boolean onTouch(View view, MotionEvent motionEvent) {
        if (this.zzaba.zzaay == null) {
            return false;
        }
        this.zzaba.zzaay.zza(motionEvent);
        return false;
    }
}
