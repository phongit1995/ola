package com.google.android.gms.internal.ads;

/* JADX INFO: loaded from: classes.dex */
public final class zziw extends zzbfc<zziw> {
    private Integer zzapp = null;

    public zziw() {
        this.zzebk = null;
        this.zzebt = -1;
    }

    /* JADX INFO: Access modifiers changed from: private */
    @Override // com.google.android.gms.internal.ads.zzbfi
    /* JADX INFO: renamed from: zzt, reason: merged with bridge method [inline-methods] */
    public final zziw zza(zzbez zzbezVar) throws zzbfh {
        while (true) {
            int iZzabk = zzbezVar.zzabk();
            if (iZzabk == 0) {
                return this;
            }
            if (iZzabk == 8) {
                int position = zzbezVar.getPosition();
                try {
                    int iZzacc = zzbezVar.zzacc();
                    if (iZzacc < 0 || iZzacc > 3) {
                        StringBuilder sb = new StringBuilder(46);
                        sb.append(iZzacc);
                        sb.append(" is not a valid enum VideoErrorCode");
                        throw new IllegalArgumentException(sb.toString());
                    }
                    this.zzapp = Integer.valueOf(iZzacc);
                } catch (IllegalArgumentException unused) {
                    zzbezVar.zzdc(position);
                    zza(zzbezVar, iZzabk);
                }
            } else if (!super.zza(zzbezVar, iZzabk)) {
                return this;
            }
        }
    }

    @Override // com.google.android.gms.internal.ads.zzbfc, com.google.android.gms.internal.ads.zzbfi
    public final void zza(zzbfa zzbfaVar) throws zzbfb {
        if (this.zzapp != null) {
            zzbfaVar.zzm(1, this.zzapp.intValue());
        }
        super.zza(zzbfaVar);
    }

    @Override // com.google.android.gms.internal.ads.zzbfc, com.google.android.gms.internal.ads.zzbfi
    protected final int zzr() {
        int iZzr = super.zzr();
        return this.zzapp != null ? iZzr + zzbfa.zzq(1, this.zzapp.intValue()) : iZzr;
    }
}
