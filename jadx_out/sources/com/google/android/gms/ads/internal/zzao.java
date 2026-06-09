package com.google.android.gms.ads.internal;

import com.google.android.gms.ads.internal.overlay.AdOverlayInfoParcel;
import com.google.android.gms.internal.ads.zzadh;
import com.google.android.gms.internal.ads.zzajx;
import com.google.android.gms.internal.ads.zzakk;

/* JADX INFO: loaded from: classes.dex */
@zzadh
final class zzao extends zzajx {
    final /* synthetic */ zzal zzza;
    private final int zzzb;

    public zzao(zzal zzalVar, int i) {
        this.zzza = zzalVar;
        this.zzzb = i;
    }

    @Override // com.google.android.gms.internal.ads.zzajx
    public final void onStop() {
    }

    @Override // com.google.android.gms.internal.ads.zzajx
    public final void zzdn() {
        zzaq zzaqVar = new zzaq(this.zzza.zzvw.zzze, this.zzza.zzdi(), this.zzza.zzys, this.zzza.zzyt, this.zzza.zzvw.zzze ? this.zzzb : -1, this.zzza.zzyu, this.zzza.zzvw.zzacw.zzzl, this.zzza.zzvw.zzacw.zzzm);
        int requestedOrientation = this.zzza.zzvw.zzacw.zzbyo.getRequestedOrientation();
        if (requestedOrientation == -1) {
            requestedOrientation = this.zzza.zzvw.zzacw.orientation;
        }
        zzakk.zzcrm.post(new zzap(this, new AdOverlayInfoParcel(this.zzza, this.zzza, this.zzza, this.zzza.zzvw.zzacw.zzbyo, requestedOrientation, this.zzza.zzvw.zzacr, this.zzza.zzvw.zzacw.zzcev, zzaqVar)));
    }
}
