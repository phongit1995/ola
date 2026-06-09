package com.google.android.gms.ads.internal;

import android.view.MotionEvent;
import android.view.View;

/* JADX INFO: loaded from: classes.dex */
final class zzn implements View.OnTouchListener {
    private final /* synthetic */ zzl zzwp;
    private final /* synthetic */ zzx zzwq;

    zzn(zzl zzlVar, zzx zzxVar) {
        this.zzwp = zzlVar;
        this.zzwq = zzxVar;
    }

    @Override // android.view.View.OnTouchListener
    public final boolean onTouch(View view, MotionEvent motionEvent) {
        this.zzwq.recordClick();
        if (this.zzwp.zzwn == null) {
            return false;
        }
        this.zzwp.zzwn.zzpi();
        return false;
    }
}
