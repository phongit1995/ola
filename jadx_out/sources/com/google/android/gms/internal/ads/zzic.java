package com.google.android.gms.internal.ads;

/* JADX INFO: loaded from: classes.dex */
public final class zzic extends zzbfc<zzic> {
    private static volatile zzic[] zzame;
    private Integer zzamf = null;
    private zziq zzamg = null;

    public zzic() {
        this.zzebk = null;
        this.zzebt = -1;
    }

    /* JADX INFO: Access modifiers changed from: private */
    @Override // com.google.android.gms.internal.ads.zzbfi
    /* JADX INFO: renamed from: zzf, reason: merged with bridge method [inline-methods] */
    public final zzic zza(zzbez zzbezVar) throws zzbfh {
        while (true) {
            int iZzabk = zzbezVar.zzabk();
            if (iZzabk == 0) {
                return this;
            }
            if (iZzabk == 8) {
                int position = zzbezVar.getPosition();
                try {
                    int iZzacc = zzbezVar.zzacc();
                    if (iZzacc < 0 || iZzacc > 10) {
                        StringBuilder sb = new StringBuilder(44);
                        sb.append(iZzacc);
                        sb.append(" is not a valid enum AdFormatType");
                        throw new IllegalArgumentException(sb.toString());
                    }
                    this.zzamf = Integer.valueOf(iZzacc);
                } catch (IllegalArgumentException unused) {
                    zzbezVar.zzdc(position);
                    zza(zzbezVar, iZzabk);
                }
            } else if (iZzabk == 18) {
                if (this.zzamg == null) {
                    this.zzamg = new zziq();
                }
                zzbezVar.zza(this.zzamg);
            } else if (!super.zza(zzbezVar, iZzabk)) {
                return this;
            }
        }
    }

    public static zzic[] zzhr() {
        if (zzame == null) {
            synchronized (zzbfg.zzebs) {
                if (zzame == null) {
                    zzame = new zzic[0];
                }
            }
        }
        return zzame;
    }

    @Override // com.google.android.gms.internal.ads.zzbfc, com.google.android.gms.internal.ads.zzbfi
    public final void zza(zzbfa zzbfaVar) throws zzbfb {
        if (this.zzamf != null) {
            zzbfaVar.zzm(1, this.zzamf.intValue());
        }
        if (this.zzamg != null) {
            zzbfaVar.zza(2, this.zzamg);
        }
        super.zza(zzbfaVar);
    }

    @Override // com.google.android.gms.internal.ads.zzbfc, com.google.android.gms.internal.ads.zzbfi
    protected final int zzr() {
        int iZzr = super.zzr();
        if (this.zzamf != null) {
            iZzr += zzbfa.zzq(1, this.zzamf.intValue());
        }
        return this.zzamg != null ? iZzr + zzbfa.zzb(2, this.zzamg) : iZzr;
    }
}
