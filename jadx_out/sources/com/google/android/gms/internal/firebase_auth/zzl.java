package com.google.android.gms.internal.firebase_auth;

/* JADX INFO: loaded from: classes2.dex */
public final class zzl extends zzgn<zzl> {
    public int zzao = 0;
    public String zzah = "";
    private String zzap = "";
    private String zzaq = "";
    private String zzar = "";
    private String zzas = "";
    public String zzaf = "";
    public String zzat = "";
    public String zzau = "";
    public String zzav = "";
    public String zzaw = "";
    public boolean zzax = false;
    public String zzay = "";
    public boolean zzaz = false;

    public zzl() {
        this.zzya = -1;
    }

    /* JADX INFO: Access modifiers changed from: private */
    @Override // com.google.android.gms.internal.firebase_auth.zzgt
    /* JADX INFO: renamed from: zzb, reason: merged with bridge method [inline-methods] */
    public final zzl zza(zzgk zzgkVar) throws zzgs {
        while (true) {
            int iZzcc = zzgkVar.zzcc();
            switch (iZzcc) {
                case 0:
                    return this;
                case 8:
                    int position = zzgkVar.getPosition();
                    try {
                        this.zzao = zzgx.zzbe(zzgkVar.zzcu());
                    } catch (IllegalArgumentException unused) {
                        zzgkVar.zzay(position);
                        zza(zzgkVar, iZzcc);
                    }
                    break;
                case 18:
                    this.zzah = zzgkVar.readString();
                    break;
                case 26:
                    this.zzap = zzgkVar.readString();
                    break;
                case 34:
                    this.zzaq = zzgkVar.readString();
                    break;
                case 42:
                    this.zzar = zzgkVar.readString();
                    break;
                case 50:
                    this.zzas = zzgkVar.readString();
                    break;
                case 58:
                    this.zzaf = zzgkVar.readString();
                    break;
                case 66:
                    this.zzat = zzgkVar.readString();
                    break;
                case 74:
                    this.zzau = zzgkVar.readString();
                    break;
                case 82:
                    this.zzav = zzgkVar.readString();
                    break;
                case 90:
                    this.zzaw = zzgkVar.readString();
                    break;
                case 96:
                    this.zzax = zzgkVar.zzci();
                    break;
                case 106:
                    this.zzay = zzgkVar.readString();
                    break;
                case 112:
                    this.zzaz = zzgkVar.zzci();
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
        if (this.zzao != 0) {
            zzglVar.zzc(1, this.zzao);
        }
        if (this.zzah != null && !this.zzah.equals("")) {
            zzglVar.zza(2, this.zzah);
        }
        if (this.zzap != null && !this.zzap.equals("")) {
            zzglVar.zza(3, this.zzap);
        }
        if (this.zzaq != null && !this.zzaq.equals("")) {
            zzglVar.zza(4, this.zzaq);
        }
        if (this.zzar != null && !this.zzar.equals("")) {
            zzglVar.zza(5, this.zzar);
        }
        if (this.zzas != null && !this.zzas.equals("")) {
            zzglVar.zza(6, this.zzas);
        }
        if (this.zzaf != null && !this.zzaf.equals("")) {
            zzglVar.zza(7, this.zzaf);
        }
        if (this.zzat != null && !this.zzat.equals("")) {
            zzglVar.zza(8, this.zzat);
        }
        if (this.zzau != null && !this.zzau.equals("")) {
            zzglVar.zza(9, this.zzau);
        }
        if (this.zzav != null && !this.zzav.equals("")) {
            zzglVar.zza(10, this.zzav);
        }
        if (this.zzaw != null && !this.zzaw.equals("")) {
            zzglVar.zza(11, this.zzaw);
        }
        if (this.zzax) {
            zzglVar.zzb(12, this.zzax);
        }
        if (this.zzay != null && !this.zzay.equals("")) {
            zzglVar.zza(13, this.zzay);
        }
        if (this.zzaz) {
            zzglVar.zzb(14, this.zzaz);
        }
        super.zza(zzglVar);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgn, com.google.android.gms.internal.firebase_auth.zzgt
    protected final int zzb() {
        int iZzb = super.zzb();
        if (this.zzao != 0) {
            iZzb += zzgl.zzg(1, this.zzao);
        }
        if (this.zzah != null && !this.zzah.equals("")) {
            iZzb += zzgl.zzb(2, this.zzah);
        }
        if (this.zzap != null && !this.zzap.equals("")) {
            iZzb += zzgl.zzb(3, this.zzap);
        }
        if (this.zzaq != null && !this.zzaq.equals("")) {
            iZzb += zzgl.zzb(4, this.zzaq);
        }
        if (this.zzar != null && !this.zzar.equals("")) {
            iZzb += zzgl.zzb(5, this.zzar);
        }
        if (this.zzas != null && !this.zzas.equals("")) {
            iZzb += zzgl.zzb(6, this.zzas);
        }
        if (this.zzaf != null && !this.zzaf.equals("")) {
            iZzb += zzgl.zzb(7, this.zzaf);
        }
        if (this.zzat != null && !this.zzat.equals("")) {
            iZzb += zzgl.zzb(8, this.zzat);
        }
        if (this.zzau != null && !this.zzau.equals("")) {
            iZzb += zzgl.zzb(9, this.zzau);
        }
        if (this.zzav != null && !this.zzav.equals("")) {
            iZzb += zzgl.zzb(10, this.zzav);
        }
        if (this.zzaw != null && !this.zzaw.equals("")) {
            iZzb += zzgl.zzb(11, this.zzaw);
        }
        if (this.zzax) {
            iZzb += zzgl.zzaa(12) + 1;
        }
        if (this.zzay != null && !this.zzay.equals("")) {
            iZzb += zzgl.zzb(13, this.zzay);
        }
        return this.zzaz ? iZzb + zzgl.zzaa(14) + 1 : iZzb;
    }
}
