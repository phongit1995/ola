package com.google.android.gms.internal.ads;

/* JADX INFO: loaded from: classes.dex */
public final class zzja extends zzbfc<zzja> {
    private Integer zzanu = null;
    private zziw zzapn = null;
    private Integer zzape = null;
    private Integer zzapf = null;
    private Integer zzapr = null;
    private Long zzaps = null;

    public zzja() {
        this.zzebk = null;
        this.zzebt = -1;
    }

    /* JADX INFO: Access modifiers changed from: private */
    @Override // com.google.android.gms.internal.ads.zzbfi
    /* JADX INFO: renamed from: zzx, reason: merged with bridge method [inline-methods] */
    public final zzja zza(zzbez zzbezVar) throws zzbfh {
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
            } else if (iZzabk == 24) {
                this.zzape = Integer.valueOf(zzbezVar.zzacc());
            } else if (iZzabk == 32) {
                this.zzapf = Integer.valueOf(zzbezVar.zzacc());
            } else if (iZzabk == 40) {
                this.zzapr = Integer.valueOf(zzbezVar.zzacc());
            } else if (iZzabk == 48) {
                this.zzaps = Long.valueOf(zzbezVar.zzacd());
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
        if (this.zzape != null) {
            zzbfaVar.zzm(3, this.zzape.intValue());
        }
        if (this.zzapf != null) {
            zzbfaVar.zzm(4, this.zzapf.intValue());
        }
        if (this.zzapr != null) {
            zzbfaVar.zzm(5, this.zzapr.intValue());
        }
        if (this.zzaps != null) {
            zzbfaVar.zza(6, this.zzaps.longValue());
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
        if (this.zzape != null) {
            iZzr += zzbfa.zzq(3, this.zzape.intValue());
        }
        if (this.zzapf != null) {
            iZzr += zzbfa.zzq(4, this.zzapf.intValue());
        }
        if (this.zzapr != null) {
            iZzr += zzbfa.zzq(5, this.zzapr.intValue());
        }
        return this.zzaps != null ? iZzr + zzbfa.zze(6, this.zzaps.longValue()) : iZzr;
    }
}
