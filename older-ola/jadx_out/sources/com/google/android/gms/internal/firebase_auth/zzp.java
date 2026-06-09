package com.google.android.gms.internal.firebase_auth;

/* JADX INFO: loaded from: classes2.dex */
public final class zzp extends zzgn<zzp> {
    public String zzah = "";
    public String zzbi = "";
    public String zzbh = "";
    private String zzbm = "";
    private String zzbn = "";
    private String zzbq = "";
    private String zzaf = "";
    private boolean zzbk = false;
    private String zzbr = "";
    private boolean zzbz = false;
    private String zzu = "";
    private long zzv = 0;

    public zzp() {
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
                    this.zzbh = zzgkVar.readString();
                    break;
                case 34:
                    this.zzbm = zzgkVar.readString();
                    break;
                case 42:
                    this.zzbn = zzgkVar.readString();
                    break;
                case 50:
                    this.zzbq = zzgkVar.readString();
                    break;
                case 58:
                    this.zzaf = zzgkVar.readString();
                    break;
                case 64:
                    this.zzbk = zzgkVar.zzci();
                    break;
                case 74:
                    this.zzbr = zzgkVar.readString();
                    break;
                case 80:
                    this.zzbz = zzgkVar.zzci();
                    break;
                case 106:
                    this.zzu = zzgkVar.readString();
                    break;
                case 112:
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
        if (this.zzbh != null && !this.zzbh.equals("")) {
            zzglVar.zza(3, this.zzbh);
        }
        if (this.zzbm != null && !this.zzbm.equals("")) {
            zzglVar.zza(4, this.zzbm);
        }
        if (this.zzbn != null && !this.zzbn.equals("")) {
            zzglVar.zza(5, this.zzbn);
        }
        if (this.zzbq != null && !this.zzbq.equals("")) {
            zzglVar.zza(6, this.zzbq);
        }
        if (this.zzaf != null && !this.zzaf.equals("")) {
            zzglVar.zza(7, this.zzaf);
        }
        if (this.zzbk) {
            zzglVar.zzb(8, this.zzbk);
        }
        if (this.zzbr != null && !this.zzbr.equals("")) {
            zzglVar.zza(9, this.zzbr);
        }
        if (this.zzbz) {
            zzglVar.zzb(10, this.zzbz);
        }
        if (this.zzu != null && !this.zzu.equals("")) {
            zzglVar.zza(13, this.zzu);
        }
        if (this.zzv != 0) {
            zzglVar.zza(14, this.zzv);
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
        if (this.zzbh != null && !this.zzbh.equals("")) {
            iZzb += zzgl.zzb(3, this.zzbh);
        }
        if (this.zzbm != null && !this.zzbm.equals("")) {
            iZzb += zzgl.zzb(4, this.zzbm);
        }
        if (this.zzbn != null && !this.zzbn.equals("")) {
            iZzb += zzgl.zzb(5, this.zzbn);
        }
        if (this.zzbq != null && !this.zzbq.equals("")) {
            iZzb += zzgl.zzb(6, this.zzbq);
        }
        if (this.zzaf != null && !this.zzaf.equals("")) {
            iZzb += zzgl.zzb(7, this.zzaf);
        }
        if (this.zzbk) {
            iZzb += zzgl.zzaa(8) + 1;
        }
        if (this.zzbr != null && !this.zzbr.equals("")) {
            iZzb += zzgl.zzb(9, this.zzbr);
        }
        if (this.zzbz) {
            iZzb += zzgl.zzaa(10) + 1;
        }
        if (this.zzu != null && !this.zzu.equals("")) {
            iZzb += zzgl.zzb(13, this.zzu);
        }
        return this.zzv != 0 ? iZzb + zzgl.zze(14, this.zzv) : iZzb;
    }
}
