package com.google.android.gms.internal.ads;

/* JADX INFO: loaded from: classes.dex */
public final class zzil extends zzbfc<zzil> {
    private zzij zzanv = null;
    private zzir[] zzanw = zzir.zzhs();
    private Integer zzanu = null;
    private zzis zzant = null;

    public zzil() {
        this.zzebk = null;
        this.zzebt = -1;
    }

    /* JADX INFO: Access modifiers changed from: private */
    @Override // com.google.android.gms.internal.ads.zzbfi
    /* JADX INFO: renamed from: zzn, reason: merged with bridge method [inline-methods] */
    public final zzil zza(zzbez zzbezVar) throws zzbfh {
        zzbfi zzbfiVar;
        while (true) {
            int iZzabk = zzbezVar.zzabk();
            if (iZzabk == 0) {
                return this;
            }
            if (iZzabk == 10) {
                if (this.zzanv == null) {
                    this.zzanv = new zzij();
                }
                zzbfiVar = this.zzanv;
            } else if (iZzabk == 18) {
                int iZzb = zzbfl.zzb(zzbezVar, 18);
                int length = this.zzanw == null ? 0 : this.zzanw.length;
                zzir[] zzirVarArr = new zzir[iZzb + length];
                if (length != 0) {
                    System.arraycopy(this.zzanw, 0, zzirVarArr, 0, length);
                }
                while (length < zzirVarArr.length - 1) {
                    zzirVarArr[length] = new zzir();
                    zzbezVar.zza(zzirVarArr[length]);
                    zzbezVar.zzabk();
                    length++;
                }
                zzirVarArr[length] = new zzir();
                zzbezVar.zza(zzirVarArr[length]);
                this.zzanw = zzirVarArr;
            } else if (iZzabk == 24) {
                int position = zzbezVar.getPosition();
                try {
                    this.zzanu = Integer.valueOf(zzia.zzd(zzbezVar.zzacc()));
                } catch (IllegalArgumentException unused) {
                    zzbezVar.zzdc(position);
                    zza(zzbezVar, iZzabk);
                }
            } else if (iZzabk == 34) {
                if (this.zzant == null) {
                    this.zzant = new zzis();
                }
                zzbfiVar = this.zzant;
            } else if (!super.zza(zzbezVar, iZzabk)) {
                return this;
            }
            zzbezVar.zza(zzbfiVar);
        }
    }

    @Override // com.google.android.gms.internal.ads.zzbfc, com.google.android.gms.internal.ads.zzbfi
    public final void zza(zzbfa zzbfaVar) throws zzbfb {
        if (this.zzanv != null) {
            zzbfaVar.zza(1, this.zzanv);
        }
        if (this.zzanw != null && this.zzanw.length > 0) {
            for (int i = 0; i < this.zzanw.length; i++) {
                zzir zzirVar = this.zzanw[i];
                if (zzirVar != null) {
                    zzbfaVar.zza(2, zzirVar);
                }
            }
        }
        if (this.zzanu != null) {
            zzbfaVar.zzm(3, this.zzanu.intValue());
        }
        if (this.zzant != null) {
            zzbfaVar.zza(4, this.zzant);
        }
        super.zza(zzbfaVar);
    }

    @Override // com.google.android.gms.internal.ads.zzbfc, com.google.android.gms.internal.ads.zzbfi
    protected final int zzr() {
        int iZzr = super.zzr();
        if (this.zzanv != null) {
            iZzr += zzbfa.zzb(1, this.zzanv);
        }
        if (this.zzanw != null && this.zzanw.length > 0) {
            for (int i = 0; i < this.zzanw.length; i++) {
                zzir zzirVar = this.zzanw[i];
                if (zzirVar != null) {
                    iZzr += zzbfa.zzb(2, zzirVar);
                }
            }
        }
        if (this.zzanu != null) {
            iZzr += zzbfa.zzq(3, this.zzanu.intValue());
        }
        return this.zzant != null ? iZzr + zzbfa.zzb(4, this.zzant) : iZzr;
    }
}
