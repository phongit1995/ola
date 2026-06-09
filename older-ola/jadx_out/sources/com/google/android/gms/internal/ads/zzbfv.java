package com.google.android.gms.internal.ads;

/* JADX INFO: loaded from: classes.dex */
public final class zzbfv extends zzbfc<zzbfv> {
    public String zzedv = null;
    public Long zzedw = null;
    public Boolean zzedx = null;

    public zzbfv() {
        this.zzebk = null;
        this.zzebt = -1;
    }

    @Override // com.google.android.gms.internal.ads.zzbfi
    public final /* synthetic */ zzbfi zza(zzbez zzbezVar) throws zzbfh {
        while (true) {
            int iZzabk = zzbezVar.zzabk();
            if (iZzabk == 0) {
                return this;
            }
            if (iZzabk == 10) {
                this.zzedv = zzbezVar.readString();
            } else if (iZzabk == 16) {
                this.zzedw = Long.valueOf(zzbezVar.zzabm());
            } else if (iZzabk == 24) {
                this.zzedx = Boolean.valueOf(zzbezVar.zzabq());
            } else if (!super.zza(zzbezVar, iZzabk)) {
                return this;
            }
        }
    }

    @Override // com.google.android.gms.internal.ads.zzbfc, com.google.android.gms.internal.ads.zzbfi
    public final void zza(zzbfa zzbfaVar) throws zzbfb {
        if (this.zzedv != null) {
            zzbfaVar.zzf(1, this.zzedv);
        }
        if (this.zzedw != null) {
            zzbfaVar.zzi(2, this.zzedw.longValue());
        }
        if (this.zzedx != null) {
            zzbfaVar.zzf(3, this.zzedx.booleanValue());
        }
        super.zza(zzbfaVar);
    }

    @Override // com.google.android.gms.internal.ads.zzbfc, com.google.android.gms.internal.ads.zzbfi
    protected final int zzr() {
        int iZzr = super.zzr();
        if (this.zzedv != null) {
            iZzr += zzbfa.zzg(1, this.zzedv);
        }
        if (this.zzedw != null) {
            iZzr += zzbfa.zzd(2, this.zzedw.longValue());
        }
        if (this.zzedx == null) {
            return iZzr;
        }
        this.zzedx.booleanValue();
        return iZzr + zzbfa.zzcd(3) + 1;
    }
}
