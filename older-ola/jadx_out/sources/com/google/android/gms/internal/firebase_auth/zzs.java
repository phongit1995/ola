package com.google.android.gms.internal.firebase_auth;

/* JADX INFO: loaded from: classes2.dex */
public final class zzs extends zzgn<zzs> {
    public String zzah = "";
    public String zzbi = "";
    private String zzcc = "";
    private String zzbm = "";
    private String zzbn = "";
    private String zzdi = "";
    private String zzbq = "";
    private long zzae = 0;
    private String zzaf = "";
    public boolean zzbt = false;
    private String zzu = "";
    private long zzv = 0;

    public zzs() {
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
                    this.zzah = zzgkVar.readString();
                    break;
                case 18:
                    this.zzbi = zzgkVar.readString();
                    break;
                case 26:
                    this.zzcc = zzgkVar.readString();
                    break;
                case 34:
                    this.zzbm = zzgkVar.readString();
                    break;
                case 42:
                    this.zzbn = zzgkVar.readString();
                    break;
                case 50:
                    this.zzdi = zzgkVar.readString();
                    break;
                case 58:
                    this.zzbq = zzgkVar.readString();
                    break;
                case 64:
                    this.zzae = zzgkVar.zzcv();
                    break;
                case 74:
                    this.zzaf = zzgkVar.readString();
                    break;
                case 80:
                    this.zzbt = zzgkVar.zzci();
                    break;
                case 90:
                    this.zzu = zzgkVar.readString();
                    break;
                case 96:
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
        if (this.zzah != null && !this.zzah.equals("")) {
            zzglVar.zza(1, this.zzah);
        }
        if (this.zzbi != null && !this.zzbi.equals("")) {
            zzglVar.zza(2, this.zzbi);
        }
        if (this.zzcc != null && !this.zzcc.equals("")) {
            zzglVar.zza(3, this.zzcc);
        }
        if (this.zzbm != null && !this.zzbm.equals("")) {
            zzglVar.zza(4, this.zzbm);
        }
        if (this.zzbn != null && !this.zzbn.equals("")) {
            zzglVar.zza(5, this.zzbn);
        }
        if (this.zzdi != null && !this.zzdi.equals("")) {
            zzglVar.zza(6, this.zzdi);
        }
        if (this.zzbq != null && !this.zzbq.equals("")) {
            zzglVar.zza(7, this.zzbq);
        }
        if (this.zzae != 0) {
            zzglVar.zzi(8, this.zzae);
        }
        if (this.zzaf != null && !this.zzaf.equals("")) {
            zzglVar.zza(9, this.zzaf);
        }
        if (this.zzbt) {
            zzglVar.zzb(10, this.zzbt);
        }
        if (this.zzu != null && !this.zzu.equals("")) {
            zzglVar.zza(11, this.zzu);
        }
        if (this.zzv != 0) {
            zzglVar.zza(12, this.zzv);
        }
        super.zza(zzglVar);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgn, com.google.android.gms.internal.firebase_auth.zzgt
    protected final int zzb() {
        int iZzb = super.zzb();
        if (this.zzah != null && !this.zzah.equals("")) {
            iZzb += zzgl.zzb(1, this.zzah);
        }
        if (this.zzbi != null && !this.zzbi.equals("")) {
            iZzb += zzgl.zzb(2, this.zzbi);
        }
        if (this.zzcc != null && !this.zzcc.equals("")) {
            iZzb += zzgl.zzb(3, this.zzcc);
        }
        if (this.zzbm != null && !this.zzbm.equals("")) {
            iZzb += zzgl.zzb(4, this.zzbm);
        }
        if (this.zzbn != null && !this.zzbn.equals("")) {
            iZzb += zzgl.zzb(5, this.zzbn);
        }
        if (this.zzdi != null && !this.zzdi.equals("")) {
            iZzb += zzgl.zzb(6, this.zzdi);
        }
        if (this.zzbq != null && !this.zzbq.equals("")) {
            iZzb += zzgl.zzb(7, this.zzbq);
        }
        if (this.zzae != 0) {
            iZzb += zzgl.zzd(8, this.zzae);
        }
        if (this.zzaf != null && !this.zzaf.equals("")) {
            iZzb += zzgl.zzb(9, this.zzaf);
        }
        if (this.zzbt) {
            iZzb += zzgl.zzaa(10) + 1;
        }
        if (this.zzu != null && !this.zzu.equals("")) {
            iZzb += zzgl.zzb(11, this.zzu);
        }
        return this.zzv != 0 ? iZzb + zzgl.zze(12, this.zzv) : iZzb;
    }
}
