package com.google.android.gms.internal.ads;

/* JADX INFO: loaded from: classes.dex */
public final class zzir extends zzbfc<zzir> {
    private static volatile zzir[] zzaop;
    private String zzanq = null;
    private Integer zzanr = null;
    private zzis zzant = null;

    public zzir() {
        this.zzebk = null;
        this.zzebt = -1;
    }

    public static zzir[] zzhs() {
        if (zzaop == null) {
            synchronized (zzbfg.zzebs) {
                if (zzaop == null) {
                    zzaop = new zzir[0];
                }
            }
        }
        return zzaop;
    }

    /* JADX INFO: Access modifiers changed from: private */
    @Override // com.google.android.gms.internal.ads.zzbfi
    /* JADX INFO: renamed from: zzr, reason: merged with bridge method [inline-methods] */
    public final zzir zza(zzbez zzbezVar) throws zzbfh {
        while (true) {
            int iZzabk = zzbezVar.zzabk();
            if (iZzabk == 0) {
                return this;
            }
            if (iZzabk == 10) {
                this.zzanq = zzbezVar.readString();
            } else if (iZzabk == 16) {
                int position = zzbezVar.getPosition();
                try {
                    this.zzanr = Integer.valueOf(zzia.zzd(zzbezVar.zzacc()));
                } catch (IllegalArgumentException unused) {
                    zzbezVar.zzdc(position);
                    zza(zzbezVar, iZzabk);
                }
            } else if (iZzabk == 26) {
                if (this.zzant == null) {
                    this.zzant = new zzis();
                }
                zzbezVar.zza(this.zzant);
            } else if (!super.zza(zzbezVar, iZzabk)) {
                return this;
            }
        }
    }

    @Override // com.google.android.gms.internal.ads.zzbfc, com.google.android.gms.internal.ads.zzbfi
    public final void zza(zzbfa zzbfaVar) throws zzbfb {
        if (this.zzanq != null) {
            zzbfaVar.zzf(1, this.zzanq);
        }
        if (this.zzanr != null) {
            zzbfaVar.zzm(2, this.zzanr.intValue());
        }
        if (this.zzant != null) {
            zzbfaVar.zza(3, this.zzant);
        }
        super.zza(zzbfaVar);
    }

    @Override // com.google.android.gms.internal.ads.zzbfc, com.google.android.gms.internal.ads.zzbfi
    protected final int zzr() {
        int iZzr = super.zzr();
        if (this.zzanq != null) {
            iZzr += zzbfa.zzg(1, this.zzanq);
        }
        if (this.zzanr != null) {
            iZzr += zzbfa.zzq(2, this.zzanr.intValue());
        }
        return this.zzant != null ? iZzr + zzbfa.zzb(3, this.zzant) : iZzr;
    }
}
