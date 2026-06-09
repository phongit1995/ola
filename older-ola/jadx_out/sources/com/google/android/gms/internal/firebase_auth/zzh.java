package com.google.android.gms.internal.firebase_auth;

/* JADX INFO: loaded from: classes2.dex */
public final class zzh extends zzgn<zzh> {
    public String zzg = "";
    public String zzh = "";
    private String zzi = "";
    private String zzj = "";
    private String zzk = "";
    private String zzl = "";
    private String zzm = "";
    private String zzn = "";
    private String zzo = "";
    private String zzp = "";
    private String zzq = "";
    private String zzr = "";
    private String zzs = "";
    private zzf[] zzt = zzf.zza();
    private String zzu = "";
    private long zzv = 0;

    public zzh() {
        this.zzya = -1;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgt
    public final /* synthetic */ zzgt zza(zzgk zzgkVar) throws zzgs {
        while (true) {
            int iZzcc = zzgkVar.zzcc();
            switch (iZzcc) {
                case 0:
                    return this;
                case 10:
                    this.zzg = zzgkVar.readString();
                    break;
                case 18:
                    this.zzh = zzgkVar.readString();
                    break;
                case 26:
                    this.zzi = zzgkVar.readString();
                    break;
                case 34:
                    this.zzj = zzgkVar.readString();
                    break;
                case 42:
                    this.zzk = zzgkVar.readString();
                    break;
                case 50:
                    this.zzl = zzgkVar.readString();
                    break;
                case 58:
                    this.zzm = zzgkVar.readString();
                    break;
                case 66:
                    this.zzn = zzgkVar.readString();
                    break;
                case 74:
                    this.zzo = zzgkVar.readString();
                    break;
                case 82:
                    this.zzp = zzgkVar.readString();
                    break;
                case 90:
                    this.zzq = zzgkVar.readString();
                    break;
                case 98:
                    this.zzr = zzgkVar.readString();
                    break;
                case 106:
                    this.zzs = zzgkVar.readString();
                    break;
                case 114:
                    int iZzb = zzgw.zzb(zzgkVar, 114);
                    int length = this.zzt == null ? 0 : this.zzt.length;
                    zzf[] zzfVarArr = new zzf[iZzb + length];
                    if (length != 0) {
                        System.arraycopy(this.zzt, 0, zzfVarArr, 0, length);
                    }
                    while (length < zzfVarArr.length - 1) {
                        zzfVarArr[length] = new zzf();
                        zzgkVar.zzb(zzfVarArr[length]);
                        zzgkVar.zzcc();
                        length++;
                    }
                    zzfVarArr[length] = new zzf();
                    zzgkVar.zzb(zzfVarArr[length]);
                    this.zzt = zzfVarArr;
                    break;
                case 122:
                    this.zzu = zzgkVar.readString();
                    break;
                case 128:
                    this.zzv = zzgkVar.zzcv();
                    break;
                default:
                    if (!super.zza(zzgkVar, iZzcc)) {
                        return this;
                    }
                    break;
                    break;
            }
        }
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgn, com.google.android.gms.internal.firebase_auth.zzgt
    public final void zza(zzgl zzglVar) throws zzgm {
        if (this.zzg != null && !this.zzg.equals("")) {
            zzglVar.zza(1, this.zzg);
        }
        if (this.zzh != null && !this.zzh.equals("")) {
            zzglVar.zza(2, this.zzh);
        }
        if (this.zzi != null && !this.zzi.equals("")) {
            zzglVar.zza(3, this.zzi);
        }
        if (this.zzj != null && !this.zzj.equals("")) {
            zzglVar.zza(4, this.zzj);
        }
        if (this.zzk != null && !this.zzk.equals("")) {
            zzglVar.zza(5, this.zzk);
        }
        if (this.zzl != null && !this.zzl.equals("")) {
            zzglVar.zza(6, this.zzl);
        }
        if (this.zzm != null && !this.zzm.equals("")) {
            zzglVar.zza(7, this.zzm);
        }
        if (this.zzn != null && !this.zzn.equals("")) {
            zzglVar.zza(8, this.zzn);
        }
        if (this.zzo != null && !this.zzo.equals("")) {
            zzglVar.zza(9, this.zzo);
        }
        if (this.zzp != null && !this.zzp.equals("")) {
            zzglVar.zza(10, this.zzp);
        }
        if (this.zzq != null && !this.zzq.equals("")) {
            zzglVar.zza(11, this.zzq);
        }
        if (this.zzr != null && !this.zzr.equals("")) {
            zzglVar.zza(12, this.zzr);
        }
        if (this.zzs != null && !this.zzs.equals("")) {
            zzglVar.zza(13, this.zzs);
        }
        if (this.zzt != null && this.zzt.length > 0) {
            for (int i = 0; i < this.zzt.length; i++) {
                zzf zzfVar = this.zzt[i];
                if (zzfVar != null) {
                    zzglVar.zza(14, zzfVar);
                }
            }
        }
        if (this.zzu != null && !this.zzu.equals("")) {
            zzglVar.zza(15, this.zzu);
        }
        if (this.zzv != 0) {
            zzglVar.zza(16, this.zzv);
        }
        super.zza(zzglVar);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgn, com.google.android.gms.internal.firebase_auth.zzgt
    protected final int zzb() {
        int iZzb = super.zzb();
        if (this.zzg != null && !this.zzg.equals("")) {
            iZzb += zzgl.zzb(1, this.zzg);
        }
        if (this.zzh != null && !this.zzh.equals("")) {
            iZzb += zzgl.zzb(2, this.zzh);
        }
        if (this.zzi != null && !this.zzi.equals("")) {
            iZzb += zzgl.zzb(3, this.zzi);
        }
        if (this.zzj != null && !this.zzj.equals("")) {
            iZzb += zzgl.zzb(4, this.zzj);
        }
        if (this.zzk != null && !this.zzk.equals("")) {
            iZzb += zzgl.zzb(5, this.zzk);
        }
        if (this.zzl != null && !this.zzl.equals("")) {
            iZzb += zzgl.zzb(6, this.zzl);
        }
        if (this.zzm != null && !this.zzm.equals("")) {
            iZzb += zzgl.zzb(7, this.zzm);
        }
        if (this.zzn != null && !this.zzn.equals("")) {
            iZzb += zzgl.zzb(8, this.zzn);
        }
        if (this.zzo != null && !this.zzo.equals("")) {
            iZzb += zzgl.zzb(9, this.zzo);
        }
        if (this.zzp != null && !this.zzp.equals("")) {
            iZzb += zzgl.zzb(10, this.zzp);
        }
        if (this.zzq != null && !this.zzq.equals("")) {
            iZzb += zzgl.zzb(11, this.zzq);
        }
        if (this.zzr != null && !this.zzr.equals("")) {
            iZzb += zzgl.zzb(12, this.zzr);
        }
        if (this.zzs != null && !this.zzs.equals("")) {
            iZzb += zzgl.zzb(13, this.zzs);
        }
        if (this.zzt != null && this.zzt.length > 0) {
            for (int i = 0; i < this.zzt.length; i++) {
                zzf zzfVar = this.zzt[i];
                if (zzfVar != null) {
                    iZzb += zzgl.zzb(14, zzfVar);
                }
            }
        }
        if (this.zzu != null && !this.zzu.equals("")) {
            iZzb += zzgl.zzb(15, this.zzu);
        }
        return this.zzv != 0 ? iZzb + zzgl.zze(16, this.zzv) : iZzb;
    }
}
