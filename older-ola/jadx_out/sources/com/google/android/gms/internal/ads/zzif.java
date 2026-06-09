package com.google.android.gms.internal.ads;

/* JADX INFO: loaded from: classes.dex */
public final class zzif extends zzbfc<zzif> {
    private Integer zzamo = null;
    private zzis zzamp = null;
    private zzis zzamq = null;
    private zzis zzamr = null;
    private zzis[] zzams = zzis.zzht();
    private Integer zzamt = null;

    public zzif() {
        this.zzebk = null;
        this.zzebt = -1;
    }

    @Override // com.google.android.gms.internal.ads.zzbfi
    public final /* synthetic */ zzbfi zza(zzbez zzbezVar) throws zzbfh {
        zzbfi zzbfiVar;
        while (true) {
            int iZzabk = zzbezVar.zzabk();
            if (iZzabk == 0) {
                return this;
            }
            if (iZzabk != 8) {
                if (iZzabk == 18) {
                    if (this.zzamp == null) {
                        this.zzamp = new zzis();
                    }
                    zzbfiVar = this.zzamp;
                } else if (iZzabk == 26) {
                    if (this.zzamq == null) {
                        this.zzamq = new zzis();
                    }
                    zzbfiVar = this.zzamq;
                } else if (iZzabk == 34) {
                    if (this.zzamr == null) {
                        this.zzamr = new zzis();
                    }
                    zzbfiVar = this.zzamr;
                } else if (iZzabk == 42) {
                    int iZzb = zzbfl.zzb(zzbezVar, 42);
                    int length = this.zzams == null ? 0 : this.zzams.length;
                    zzis[] zzisVarArr = new zzis[iZzb + length];
                    if (length != 0) {
                        System.arraycopy(this.zzams, 0, zzisVarArr, 0, length);
                    }
                    while (length < zzisVarArr.length - 1) {
                        zzisVarArr[length] = new zzis();
                        zzbezVar.zza(zzisVarArr[length]);
                        zzbezVar.zzabk();
                        length++;
                    }
                    zzisVarArr[length] = new zzis();
                    zzbezVar.zza(zzisVarArr[length]);
                    this.zzams = zzisVarArr;
                } else if (iZzabk == 48) {
                    this.zzamt = Integer.valueOf(zzbezVar.zzacc());
                } else if (!super.zza(zzbezVar, iZzabk)) {
                    return this;
                }
                zzbezVar.zza(zzbfiVar);
            } else {
                this.zzamo = Integer.valueOf(zzbezVar.zzacc());
            }
        }
    }

    @Override // com.google.android.gms.internal.ads.zzbfc, com.google.android.gms.internal.ads.zzbfi
    public final void zza(zzbfa zzbfaVar) throws zzbfb {
        if (this.zzamo != null) {
            zzbfaVar.zzm(1, this.zzamo.intValue());
        }
        if (this.zzamp != null) {
            zzbfaVar.zza(2, this.zzamp);
        }
        if (this.zzamq != null) {
            zzbfaVar.zza(3, this.zzamq);
        }
        if (this.zzamr != null) {
            zzbfaVar.zza(4, this.zzamr);
        }
        if (this.zzams != null && this.zzams.length > 0) {
            for (int i = 0; i < this.zzams.length; i++) {
                zzis zzisVar = this.zzams[i];
                if (zzisVar != null) {
                    zzbfaVar.zza(5, zzisVar);
                }
            }
        }
        if (this.zzamt != null) {
            zzbfaVar.zzm(6, this.zzamt.intValue());
        }
        super.zza(zzbfaVar);
    }

    @Override // com.google.android.gms.internal.ads.zzbfc, com.google.android.gms.internal.ads.zzbfi
    protected final int zzr() {
        int iZzr = super.zzr();
        if (this.zzamo != null) {
            iZzr += zzbfa.zzq(1, this.zzamo.intValue());
        }
        if (this.zzamp != null) {
            iZzr += zzbfa.zzb(2, this.zzamp);
        }
        if (this.zzamq != null) {
            iZzr += zzbfa.zzb(3, this.zzamq);
        }
        if (this.zzamr != null) {
            iZzr += zzbfa.zzb(4, this.zzamr);
        }
        if (this.zzams != null && this.zzams.length > 0) {
            for (int i = 0; i < this.zzams.length; i++) {
                zzis zzisVar = this.zzams[i];
                if (zzisVar != null) {
                    iZzr += zzbfa.zzb(5, zzisVar);
                }
            }
        }
        return this.zzamt != null ? iZzr + zzbfa.zzq(6, this.zzamt.intValue()) : iZzr;
    }
}
