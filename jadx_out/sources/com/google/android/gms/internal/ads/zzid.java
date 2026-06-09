package com.google.android.gms.internal.ads;

/* JADX INFO: loaded from: classes.dex */
public final class zzid extends zzbfc<zzid> {
    private String zzacp = null;
    private zzic[] zzamh = zzic.zzhr();
    private Integer zzami = null;

    public zzid() {
        this.zzebk = null;
        this.zzebt = -1;
    }

    /* JADX INFO: Access modifiers changed from: private */
    @Override // com.google.android.gms.internal.ads.zzbfi
    /* JADX INFO: renamed from: zzg, reason: merged with bridge method [inline-methods] */
    public final zzid zza(zzbez zzbezVar) throws zzbfh {
        while (true) {
            int iZzabk = zzbezVar.zzabk();
            if (iZzabk == 0) {
                return this;
            }
            if (iZzabk == 10) {
                this.zzacp = zzbezVar.readString();
            } else if (iZzabk == 18) {
                int iZzb = zzbfl.zzb(zzbezVar, 18);
                int length = this.zzamh == null ? 0 : this.zzamh.length;
                zzic[] zzicVarArr = new zzic[iZzb + length];
                if (length != 0) {
                    System.arraycopy(this.zzamh, 0, zzicVarArr, 0, length);
                }
                while (length < zzicVarArr.length - 1) {
                    zzicVarArr[length] = new zzic();
                    zzbezVar.zza(zzicVarArr[length]);
                    zzbezVar.zzabk();
                    length++;
                }
                zzicVarArr[length] = new zzic();
                zzbezVar.zza(zzicVarArr[length]);
                this.zzamh = zzicVarArr;
            } else if (iZzabk == 24) {
                int position = zzbezVar.getPosition();
                try {
                    this.zzami = Integer.valueOf(zzia.zzd(zzbezVar.zzacc()));
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
        if (this.zzacp != null) {
            zzbfaVar.zzf(1, this.zzacp);
        }
        if (this.zzamh != null && this.zzamh.length > 0) {
            for (int i = 0; i < this.zzamh.length; i++) {
                zzic zzicVar = this.zzamh[i];
                if (zzicVar != null) {
                    zzbfaVar.zza(2, zzicVar);
                }
            }
        }
        if (this.zzami != null) {
            zzbfaVar.zzm(3, this.zzami.intValue());
        }
        super.zza(zzbfaVar);
    }

    @Override // com.google.android.gms.internal.ads.zzbfc, com.google.android.gms.internal.ads.zzbfi
    protected final int zzr() {
        int iZzr = super.zzr();
        if (this.zzacp != null) {
            iZzr += zzbfa.zzg(1, this.zzacp);
        }
        if (this.zzamh != null && this.zzamh.length > 0) {
            for (int i = 0; i < this.zzamh.length; i++) {
                zzic zzicVar = this.zzamh[i];
                if (zzicVar != null) {
                    iZzr += zzbfa.zzb(2, zzicVar);
                }
            }
        }
        return this.zzami != null ? iZzr + zzbfa.zzq(3, this.zzami.intValue()) : iZzr;
    }
}
