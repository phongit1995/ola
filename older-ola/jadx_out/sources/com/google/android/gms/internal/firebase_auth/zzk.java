package com.google.android.gms.internal.firebase_auth;

/* JADX INFO: loaded from: classes2.dex */
public final class zzk extends zzgn<zzk> {
    public String zzaf = "";
    private String[] zzal = zzgw.EMPTY_STRING_ARRAY;
    private String[] zzam = zzgw.EMPTY_STRING_ARRAY;
    private long zzae = 0;

    public zzk() {
        this.zzya = -1;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgt
    public final /* synthetic */ zzgt zza(zzgk zzgkVar) throws zzgs {
        while (true) {
            int iZzcc = zzgkVar.zzcc();
            if (iZzcc == 0) {
                return this;
            }
            if (iZzcc == 10) {
                this.zzaf = zzgkVar.readString();
            } else if (iZzcc == 18) {
                int iZzb = zzgw.zzb(zzgkVar, 18);
                int length = this.zzal == null ? 0 : this.zzal.length;
                String[] strArr = new String[iZzb + length];
                if (length != 0) {
                    System.arraycopy(this.zzal, 0, strArr, 0, length);
                }
                while (length < strArr.length - 1) {
                    strArr[length] = zzgkVar.readString();
                    zzgkVar.zzcc();
                    length++;
                }
                strArr[length] = zzgkVar.readString();
                this.zzal = strArr;
            } else if (iZzcc == 26) {
                int iZzb2 = zzgw.zzb(zzgkVar, 26);
                int length2 = this.zzam == null ? 0 : this.zzam.length;
                String[] strArr2 = new String[iZzb2 + length2];
                if (length2 != 0) {
                    System.arraycopy(this.zzam, 0, strArr2, 0, length2);
                }
                while (length2 < strArr2.length - 1) {
                    strArr2[length2] = zzgkVar.readString();
                    zzgkVar.zzcc();
                    length2++;
                }
                strArr2[length2] = zzgkVar.readString();
                this.zzam = strArr2;
            } else if (iZzcc == 32) {
                this.zzae = zzgkVar.zzcv();
            } else if (!super.zza(zzgkVar, iZzcc)) {
                return this;
            }
        }
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgn, com.google.android.gms.internal.firebase_auth.zzgt
    public final void zza(zzgl zzglVar) throws zzgm {
        if (this.zzaf != null && !this.zzaf.equals("")) {
            zzglVar.zza(1, this.zzaf);
        }
        if (this.zzal != null && this.zzal.length > 0) {
            for (int i = 0; i < this.zzal.length; i++) {
                String str = this.zzal[i];
                if (str != null) {
                    zzglVar.zza(2, str);
                }
            }
        }
        if (this.zzam != null && this.zzam.length > 0) {
            for (int i2 = 0; i2 < this.zzam.length; i2++) {
                String str2 = this.zzam[i2];
                if (str2 != null) {
                    zzglVar.zza(3, str2);
                }
            }
        }
        if (this.zzae != 0) {
            zzglVar.zzi(4, this.zzae);
        }
        super.zza(zzglVar);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgn, com.google.android.gms.internal.firebase_auth.zzgt
    protected final int zzb() {
        int iZzb = super.zzb();
        if (this.zzaf != null && !this.zzaf.equals("")) {
            iZzb += zzgl.zzb(1, this.zzaf);
        }
        if (this.zzal != null && this.zzal.length > 0) {
            int iZzam = 0;
            int i = 0;
            for (int i2 = 0; i2 < this.zzal.length; i2++) {
                String str = this.zzal[i2];
                if (str != null) {
                    i++;
                    iZzam += zzgl.zzam(str);
                }
            }
            iZzb = iZzb + iZzam + (i * 1);
        }
        if (this.zzam != null && this.zzam.length > 0) {
            int iZzam2 = 0;
            int i3 = 0;
            for (int i4 = 0; i4 < this.zzam.length; i4++) {
                String str2 = this.zzam[i4];
                if (str2 != null) {
                    i3++;
                    iZzam2 += zzgl.zzam(str2);
                }
            }
            iZzb = iZzb + iZzam2 + (i3 * 1);
        }
        return this.zzae != 0 ? iZzb + zzgl.zzd(4, this.zzae) : iZzb;
    }
}
