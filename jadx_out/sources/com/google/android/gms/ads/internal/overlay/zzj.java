package com.google.android.gms.ads.internal.overlay;

import android.graphics.Bitmap;
import com.google.android.gms.ads.internal.zzbv;
import com.google.android.gms.internal.ads.zzadh;
import com.google.android.gms.internal.ads.zzajx;
import com.google.android.gms.internal.ads.zzakk;

/* JADX INFO: loaded from: classes.dex */
@zzadh
final class zzj extends zzajx {
    final /* synthetic */ zzd zzbyg;

    private zzj(zzd zzdVar) {
        this.zzbyg = zzdVar;
    }

    /* synthetic */ zzj(zzd zzdVar, zzf zzfVar) {
        this(zzdVar);
    }

    @Override // com.google.android.gms.internal.ads.zzajx
    public final void onStop() {
    }

    @Override // com.google.android.gms.internal.ads.zzajx
    public final void zzdn() {
        Bitmap bitmapZza = zzbv.zzfe().zza(Integer.valueOf(this.zzbyg.zzbxn.zzbyw.zzzj));
        if (bitmapZza != null) {
            zzakk.zzcrm.post(new zzk(this, zzbv.zzem().zza(this.zzbyg.mActivity, bitmapZza, this.zzbyg.zzbxn.zzbyw.zzzh, this.zzbyg.zzbxn.zzbyw.zzzi)));
        }
    }
}
