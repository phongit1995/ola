package com.google.android.gms.internal.firebase_auth;

/* JADX INFO: loaded from: classes2.dex */
public final class zzo extends zzgn<zzo> {
    private zzfm zzbo;
    public String zzaf = "";
    private String zzad = "";
    public String zzbh = "";
    public String zzah = "";
    public String zzbi = "";
    private String[] zzbj = zzgw.EMPTY_STRING_ARRAY;
    public String zzag = "";
    private boolean zzbk = false;
    private boolean zzbl = false;
    private String zzbm = "";
    private String zzbn = "";
    private boolean zzbp = false;
    private String zzbq = "";
    private long zzae = 0;
    public String zzbr = "";
    public int[] zzbs = zzgw.zzti;
    public boolean zzbt = false;
    public String[] zzbu = zzgw.EMPTY_STRING_ARRAY;
    private long zzbv = 0;
    private long zzbw = 0;

    public zzo() {
        this.zzya = -1;
    }

    /* JADX INFO: Access modifiers changed from: private */
    @Override // com.google.android.gms.internal.firebase_auth.zzgt
    /* JADX INFO: renamed from: zzd, reason: merged with bridge method [inline-methods] */
    public final zzo zza(zzgk zzgkVar) throws zzgs {
        while (true) {
            int iZzcc = zzgkVar.zzcc();
            switch (iZzcc) {
                case 0:
                    return this;
                case 18:
                    this.zzaf = zzgkVar.readString();
                    break;
                case 26:
                    this.zzad = zzgkVar.readString();
                    break;
                case 34:
                    this.zzbh = zzgkVar.readString();
                    break;
                case 42:
                    this.zzah = zzgkVar.readString();
                    break;
                case 50:
                    this.zzbi = zzgkVar.readString();
                    break;
                case 58:
                    int iZzb = zzgw.zzb(zzgkVar, 58);
                    int length = this.zzbj == null ? 0 : this.zzbj.length;
                    String[] strArr = new String[iZzb + length];
                    if (length != 0) {
                        System.arraycopy(this.zzbj, 0, strArr, 0, length);
                    }
                    while (length < strArr.length - 1) {
                        strArr[length] = zzgkVar.readString();
                        zzgkVar.zzcc();
                        length++;
                    }
                    strArr[length] = zzgkVar.readString();
                    this.zzbj = strArr;
                    break;
                case 66:
                    this.zzag = zzgkVar.readString();
                    break;
                case 72:
                    this.zzbk = zzgkVar.zzci();
                    break;
                case 80:
                    this.zzbl = zzgkVar.zzci();
                    break;
                case 90:
                    this.zzbm = zzgkVar.readString();
                    break;
                case 98:
                    this.zzbn = zzgkVar.readString();
                    break;
                case 106:
                    this.zzbo = (zzfm) zzgkVar.zza(zzfm.zzfw());
                    break;
                case 112:
                    this.zzbp = zzgkVar.zzci();
                    break;
                case 122:
                    this.zzbq = zzgkVar.readString();
                    break;
                case 128:
                    this.zzae = zzgkVar.zzcv();
                    break;
                case 138:
                    this.zzbr = zzgkVar.readString();
                    break;
                case 144:
                    int iZzb2 = zzgw.zzb(zzgkVar, 144);
                    int[] iArr = new int[iZzb2];
                    int i = 0;
                    for (int i2 = 0; i2 < iZzb2; i2++) {
                        if (i2 != 0) {
                            zzgkVar.zzcc();
                        }
                        int position = zzgkVar.getPosition();
                        try {
                            iArr[i] = zze.zza(zzgkVar.zzcu());
                            i++;
                        } catch (IllegalArgumentException unused) {
                            zzgkVar.zzay(position);
                            zza(zzgkVar, iZzcc);
                        }
                    }
                    if (i != 0) {
                        int length2 = this.zzbs == null ? 0 : this.zzbs.length;
                        if (length2 == 0 && i == iArr.length) {
                            this.zzbs = iArr;
                        } else {
                            int[] iArr2 = new int[length2 + i];
                            if (length2 != 0) {
                                System.arraycopy(this.zzbs, 0, iArr2, 0, length2);
                            }
                            System.arraycopy(iArr, 0, iArr2, length2, i);
                            this.zzbs = iArr2;
                        }
                    }
                    break;
                case 146:
                    int iZzp = zzgkVar.zzp(zzgkVar.zzcu());
                    int position2 = zzgkVar.getPosition();
                    int i3 = 0;
                    while (zzgkVar.zzgl() > 0) {
                        try {
                            zze.zza(zzgkVar.zzcu());
                            i3++;
                        } catch (IllegalArgumentException unused2) {
                        }
                    }
                    if (i3 != 0) {
                        zzgkVar.zzay(position2);
                        int length3 = this.zzbs == null ? 0 : this.zzbs.length;
                        int[] iArr3 = new int[i3 + length3];
                        if (length3 != 0) {
                            System.arraycopy(this.zzbs, 0, iArr3, 0, length3);
                        }
                        while (zzgkVar.zzgl() > 0) {
                            int position3 = zzgkVar.getPosition();
                            try {
                                iArr3[length3] = zze.zza(zzgkVar.zzcu());
                                length3++;
                            } catch (IllegalArgumentException unused3) {
                                zzgkVar.zzay(position3);
                                zza(zzgkVar, 144);
                            }
                        }
                        this.zzbs = iArr3;
                    }
                    zzgkVar.zzq(iZzp);
                    break;
                case 152:
                    this.zzbt = zzgkVar.zzci();
                    break;
                case 162:
                    int iZzb3 = zzgw.zzb(zzgkVar, 162);
                    int length4 = this.zzbu == null ? 0 : this.zzbu.length;
                    String[] strArr2 = new String[iZzb3 + length4];
                    if (length4 != 0) {
                        System.arraycopy(this.zzbu, 0, strArr2, 0, length4);
                    }
                    while (length4 < strArr2.length - 1) {
                        strArr2[length4] = zzgkVar.readString();
                        zzgkVar.zzcc();
                        length4++;
                    }
                    strArr2[length4] = zzgkVar.readString();
                    this.zzbu = strArr2;
                    break;
                case 168:
                    this.zzbv = zzgkVar.zzcv();
                    break;
                case 176:
                    this.zzbw = zzgkVar.zzcv();
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
        if (this.zzaf != null && !this.zzaf.equals("")) {
            zzglVar.zza(2, this.zzaf);
        }
        if (this.zzad != null && !this.zzad.equals("")) {
            zzglVar.zza(3, this.zzad);
        }
        if (this.zzbh != null && !this.zzbh.equals("")) {
            zzglVar.zza(4, this.zzbh);
        }
        if (this.zzah != null && !this.zzah.equals("")) {
            zzglVar.zza(5, this.zzah);
        }
        if (this.zzbi != null && !this.zzbi.equals("")) {
            zzglVar.zza(6, this.zzbi);
        }
        if (this.zzbj != null && this.zzbj.length > 0) {
            for (int i = 0; i < this.zzbj.length; i++) {
                String str = this.zzbj[i];
                if (str != null) {
                    zzglVar.zza(7, str);
                }
            }
        }
        if (this.zzag != null && !this.zzag.equals("")) {
            zzglVar.zza(8, this.zzag);
        }
        if (this.zzbk) {
            zzglVar.zzb(9, this.zzbk);
        }
        if (this.zzbl) {
            zzglVar.zzb(10, this.zzbl);
        }
        if (this.zzbm != null && !this.zzbm.equals("")) {
            zzglVar.zza(11, this.zzbm);
        }
        if (this.zzbn != null && !this.zzbn.equals("")) {
            zzglVar.zza(12, this.zzbn);
        }
        if (this.zzbo != null) {
            zzglVar.zze(13, this.zzbo);
        }
        if (this.zzbp) {
            zzglVar.zzb(14, this.zzbp);
        }
        if (this.zzbq != null && !this.zzbq.equals("")) {
            zzglVar.zza(15, this.zzbq);
        }
        if (this.zzae != 0) {
            zzglVar.zzi(16, this.zzae);
        }
        if (this.zzbr != null && !this.zzbr.equals("")) {
            zzglVar.zza(17, this.zzbr);
        }
        if (this.zzbs != null && this.zzbs.length > 0) {
            for (int i2 = 0; i2 < this.zzbs.length; i2++) {
                zzglVar.zzc(18, this.zzbs[i2]);
            }
        }
        if (this.zzbt) {
            zzglVar.zzb(19, this.zzbt);
        }
        if (this.zzbu != null && this.zzbu.length > 0) {
            for (int i3 = 0; i3 < this.zzbu.length; i3++) {
                String str2 = this.zzbu[i3];
                if (str2 != null) {
                    zzglVar.zza(20, str2);
                }
            }
        }
        if (this.zzbv != 0) {
            zzglVar.zzi(21, this.zzbv);
        }
        if (this.zzbw != 0) {
            zzglVar.zzi(22, this.zzbw);
        }
        super.zza(zzglVar);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgn, com.google.android.gms.internal.firebase_auth.zzgt
    protected final int zzb() {
        int iZzb = super.zzb();
        if (this.zzaf != null && !this.zzaf.equals("")) {
            iZzb += zzgl.zzb(2, this.zzaf);
        }
        if (this.zzad != null && !this.zzad.equals("")) {
            iZzb += zzgl.zzb(3, this.zzad);
        }
        if (this.zzbh != null && !this.zzbh.equals("")) {
            iZzb += zzgl.zzb(4, this.zzbh);
        }
        if (this.zzah != null && !this.zzah.equals("")) {
            iZzb += zzgl.zzb(5, this.zzah);
        }
        if (this.zzbi != null && !this.zzbi.equals("")) {
            iZzb += zzgl.zzb(6, this.zzbi);
        }
        if (this.zzbj != null && this.zzbj.length > 0) {
            int iZzam = 0;
            int i = 0;
            for (int i2 = 0; i2 < this.zzbj.length; i2++) {
                String str = this.zzbj[i2];
                if (str != null) {
                    i++;
                    iZzam += zzgl.zzam(str);
                }
            }
            iZzb = iZzb + iZzam + (i * 1);
        }
        if (this.zzag != null && !this.zzag.equals("")) {
            iZzb += zzgl.zzb(8, this.zzag);
        }
        if (this.zzbk) {
            iZzb += zzgl.zzaa(9) + 1;
        }
        if (this.zzbl) {
            iZzb += zzgl.zzaa(10) + 1;
        }
        if (this.zzbm != null && !this.zzbm.equals("")) {
            iZzb += zzgl.zzb(11, this.zzbm);
        }
        if (this.zzbn != null && !this.zzbn.equals("")) {
            iZzb += zzgl.zzb(12, this.zzbn);
        }
        if (this.zzbo != null) {
            iZzb += zzci.zzc(13, this.zzbo);
        }
        if (this.zzbp) {
            iZzb += zzgl.zzaa(14) + 1;
        }
        if (this.zzbq != null && !this.zzbq.equals("")) {
            iZzb += zzgl.zzb(15, this.zzbq);
        }
        if (this.zzae != 0) {
            iZzb += zzgl.zzd(16, this.zzae);
        }
        if (this.zzbr != null && !this.zzbr.equals("")) {
            iZzb += zzgl.zzb(17, this.zzbr);
        }
        if (this.zzbs != null && this.zzbs.length > 0) {
            int iZzab = 0;
            for (int i3 = 0; i3 < this.zzbs.length; i3++) {
                iZzab += zzgl.zzab(this.zzbs[i3]);
            }
            iZzb = iZzb + iZzab + (this.zzbs.length * 2);
        }
        if (this.zzbt) {
            iZzb += zzgl.zzaa(19) + 1;
        }
        if (this.zzbu != null && this.zzbu.length > 0) {
            int iZzam2 = 0;
            int i4 = 0;
            for (int i5 = 0; i5 < this.zzbu.length; i5++) {
                String str2 = this.zzbu[i5];
                if (str2 != null) {
                    i4++;
                    iZzam2 += zzgl.zzam(str2);
                }
            }
            iZzb = iZzb + iZzam2 + (i4 * 2);
        }
        if (this.zzbv != 0) {
            iZzb += zzgl.zzd(21, this.zzbv);
        }
        return this.zzbw != 0 ? iZzb + zzgl.zzd(22, this.zzbw) : iZzb;
    }
}
