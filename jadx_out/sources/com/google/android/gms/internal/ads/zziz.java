package com.google.android.gms.internal.ads;

/* JADX INFO: loaded from: classes.dex */
public final class zziz extends zzbfc<zziz> {
    private Integer zzanu = null;
    private zziw zzapn = null;
    private zzis zzapo = null;

    public zziz() {
        this.zzebk = null;
        this.zzebt = -1;
    }

    /* JADX INFO: Access modifiers changed from: private */
    @Override // com.google.android.gms.internal.ads.zzbfi
    /* JADX INFO: renamed from: zzw, reason: merged with bridge method [inline-methods] */
    public final zziz zza(zzbez zzbezVar) throws zzbfh {
        zzbfi zzbfiVar;
        while (true) {
            int iZzabk = zzbezVar.zzabk();
            if (iZzabk == 0) {
                return this;
            }
            if (iZzabk != 8) {
                if (iZzabk == 18) {
                    if (this.zzapn == null) {
                        this.zzapn = new zziw();
                    }
                    zzbfiVar = this.zzapn;
                } else if (iZzabk == 26) {
                    if (this.zzapo == null) {
                        this.zzapo = new zzis();
                    }
                    zzbfiVar = this.zzapo;
                } else if (!super.zza(zzbezVar, iZzabk)) {
                    return this;
                }
                zzbezVar.zza(zzbfiVar);
            } else {
                int position = zzbezVar.getPosition();
                try {
                    this.zzanu = Integer.valueOf(zzia.zzd(zzbezVar.zzacc()));
                } catch (IllegalArgumentException unused) {
                    zzbezVar.zzdc(position);
                    zza(zzbezVar, iZzabk);
                }
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
        if (this.zzapo != null) {
            zzbfaVar.zza(3, this.zzapo);
        }
        super.zza(zzbfaVar);
    }

    @Override // com.google.android.gms.internal.ads.zzbfc, com.google.android.gms.internal.ads.zzbfi
    protected final int zzr() {
        int iZzr = super.zzr();
        if (this.zzanu != null) {
            iZzr += zzbfa.zzq(1, this.zzanu.intValue());
        }
        if (this.zzapn != null) {
            iZzr += zzbfa.zzb(2, this.zzapn);
        }
        return this.zzapo != null ? iZzr + zzbfa.zzb(3, this.zzapo) : iZzr;
    }
}
