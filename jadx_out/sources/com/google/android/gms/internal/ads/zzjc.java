package com.google.android.gms.internal.ads;

/* JADX INFO: loaded from: classes.dex */
public final class zzjc extends zzbfc<zzjc> {
    private Integer zzanu = null;
    private zziw zzapn = null;

    public zzjc() {
        this.zzebk = null;
        this.zzebt = -1;
    }

    /* JADX INFO: Access modifiers changed from: private */
    @Override // com.google.android.gms.internal.ads.zzbfi
    /* JADX INFO: renamed from: zzz, reason: merged with bridge method [inline-methods] */
    public final zzjc zza(zzbez zzbezVar) throws zzbfh {
        while (true) {
            int iZzabk = zzbezVar.zzabk();
            if (iZzabk == 0) {
                return this;
            }
            if (iZzabk == 8) {
                int position = zzbezVar.getPosition();
                try {
                    this.zzanu = Integer.valueOf(zzia.zzd(zzbezVar.zzacc()));
                } catch (IllegalArgumentException unused) {
                    zzbezVar.zzdc(position);
                    zza(zzbezVar, iZzabk);
                }
            } else if (iZzabk == 18) {
                if (this.zzapn == null) {
                    this.zzapn = new zziw();
                }
                zzbezVar.zza(this.zzapn);
            } else if (!super.zza(zzbezVar, iZzabk)) {
                return this;
            }
        }
    }

    @Override // com.google.android.gms.internal.ads.zzbfc, com.google.android.gms.internal.ads.zzbfi
    public final void zza(zzbfa zzbfaVar) throws zzbfb {
        if (this.zzanu != null) {
            zzbfaVar.zzm(1, this.zzanu.intValue());
        }
        if (this.zzapn != null) {
            zzbfaVar.zza(2, this.zzapn);
        }
        super.zza(zzbfaVar);
    }

    @Override // com.google.android.gms.internal.ads.zzbfc, com.google.android.gms.internal.ads.zzbfi
    protected final int zzr() {
        int iZzr = super.zzr();
        if (this.zzanu != null) {
            iZzr += zzbfa.zzq(1, this.zzanu.intValue());
        }
        return this.zzapn != null ? iZzr + zzbfa.zzb(2, this.zzapn) : iZzr;
    }
}
