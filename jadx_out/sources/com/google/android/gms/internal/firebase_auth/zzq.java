package com.google.android.gms.internal.firebase_auth;

/* JADX INFO: loaded from: classes2.dex */
public final class zzq extends zzgn<zzq> {
    public String zzca = "";
    public String zzcb = "";
    private String zzcc = "";
    private boolean zzcd = false;
    public String zzr = "";
    private String zzbq = "";
    private long zzae = 0;
    public String zzaf = "";
    public boolean zzbt = false;
    private boolean zzce = false;
    public boolean zzcf = true;
    private String zzu = "";
    private long zzv = 0;

    public zzq() {
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
                    this.zzca = zzgkVar.readString();
                    break;
                case 18:
                    this.zzcb = zzgkVar.readString();
                    break;
                case 26:
                    this.zzcc = zzgkVar.readString();
                    break;
                case 32:
                    this.zzcd = zzgkVar.zzci();
                    break;
                case 42:
                    this.zzr = zzgkVar.readString();
                    break;
                case 50:
                    this.zzbq = zzgkVar.readString();
                    break;
                case 56:
                    this.zzae = zzgkVar.zzcv();
                    break;
                case 66:
                    this.zzaf = zzgkVar.readString();
                    break;
                case 72:
                    this.zzbt = zzgkVar.zzci();
                    break;
                case 80:
                    this.zzce = zzgkVar.zzci();
                    break;
                case 88:
                    this.zzcf = zzgkVar.zzci();
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
        if (this.zzca != null && !this.zzca.equals("")) {
            zzglVar.zza(1, this.zzca);
        }
        if (this.zzcb != null && !this.zzcb.equals("")) {
            zzglVar.zza(2, this.zzcb);
        }
        if (this.zzcc != null && !this.zzcc.equals("")) {
            zzglVar.zza(3, this.zzcc);
        }
        if (this.zzcd) {
            zzglVar.zzb(4, this.zzcd);
        }
        if (this.zzr != null && !this.zzr.equals("")) {
            zzglVar.zza(5, this.zzr);
        }
        if (this.zzbq != null && !this.zzbq.equals("")) {
            zzglVar.zza(6, this.zzbq);
        }
        if (this.zzae != 0) {
            zzglVar.zzi(7, this.zzae);
        }
        if (this.zzaf != null && !this.zzaf.equals("")) {
            zzglVar.zza(8, this.zzaf);
        }
        if (this.zzbt) {
            zzglVar.zzb(9, this.zzbt);
        }
        if (this.zzce) {
            zzglVar.zzb(10, this.zzce);
        }
        if (!this.zzcf) {
            zzglVar.zzb(11, this.zzcf);
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
        if (this.zzca != null && !this.zzca.equals("")) {
            iZzb += zzgl.zzb(1, this.zzca);
        }
        if (this.zzcb != null && !this.zzcb.equals("")) {
            iZzb += zzgl.zzb(2, this.zzcb);
        }
        if (this.zzcc != null && !this.zzcc.equals("")) {
            iZzb += zzgl.zzb(3, this.zzcc);
        }
        if (this.zzcd) {
            iZzb += zzgl.zzaa(4) + 1;
        }
        if (this.zzr != null && !this.zzr.equals("")) {
            iZzb += zzgl.zzb(5, this.zzr);
        }
        if (this.zzbq != null && !this.zzbq.equals("")) {
            iZzb += zzgl.zzb(6, this.zzbq);
        }
        if (this.zzae != 0) {
            iZzb += zzgl.zzd(7, this.zzae);
        }
        if (this.zzaf != null && !this.zzaf.equals("")) {
            iZzb += zzgl.zzb(8, this.zzaf);
        }
        if (this.zzbt) {
            iZzb += zzgl.zzaa(9) + 1;
        }
        if (this.zzce) {
            iZzb += zzgl.zzaa(10) + 1;
        }
        if (!this.zzcf) {
            iZzb += zzgl.zzaa(11) + 1;
        }
        if (this.zzu != null && !this.zzu.equals("")) {
            iZzb += zzgl.zzb(13, this.zzu);
        }
        return this.zzv != 0 ? iZzb + zzgl.zze(14, this.zzv) : iZzb;
    }
}
