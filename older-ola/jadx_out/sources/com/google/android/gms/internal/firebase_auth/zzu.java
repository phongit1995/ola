package com.google.android.gms.internal.firebase_auth;

import java.util.Arrays;

/* JADX INFO: loaded from: classes2.dex */
public final class zzu extends zzgn<zzu> {
    private static volatile zzu[] zzdl;
    public String zzad = "";
    public String zzah = "";
    public String zzbh = "";
    private String[] zzbj = zzgw.EMPTY_STRING_ARRAY;
    private String zzcl = "";
    public String zzbr = "";
    private String zzcm = "";
    private String zzcn = "";
    private byte[] zzdm = zzgw.zzyk;
    private byte[] zzdn = zzgw.zzyk;
    private int version = 0;
    public boolean zzbk = false;
    private long zzdo = 0;
    public zzt[] zzbx = zzt.zzc();
    private long zzdp = 0;
    private boolean zzbz = false;
    public long zzbv = 0;
    public long zzbw = 0;
    private String zzde = "";
    private boolean zzdq = false;
    public String zzdr = "";
    public String zzbd = "";

    public zzu() {
        this.zzya = -1;
    }

    public static zzu[] zzd() {
        if (zzdl == null) {
            synchronized (zzgr.zzxz) {
                if (zzdl == null) {
                    zzdl = new zzu[0];
                }
            }
        }
        return zzdl;
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgt
    public final /* synthetic */ zzgt zza(zzgk zzgkVar) throws zzgs {
        while (true) {
            int iZzcc = zzgkVar.zzcc();
            switch (iZzcc) {
                case 0:
                    return this;
                case 10:
                    this.zzad = zzgkVar.readString();
                    break;
                case 18:
                    this.zzah = zzgkVar.readString();
                    break;
                case 26:
                    this.zzbh = zzgkVar.readString();
                    break;
                case 34:
                    int iZzb = zzgw.zzb(zzgkVar, 34);
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
                case 42:
                    this.zzcl = zzgkVar.readString();
                    break;
                case 50:
                    this.zzbr = zzgkVar.readString();
                    break;
                case 58:
                    this.zzcm = zzgkVar.readString();
                    break;
                case 66:
                    this.zzcn = zzgkVar.readString();
                    break;
                case 74:
                    this.zzdm = zzgkVar.readBytes();
                    break;
                case 82:
                    this.zzdn = zzgkVar.readBytes();
                    break;
                case 88:
                    this.version = zzgkVar.zzcu();
                    break;
                case 96:
                    this.zzbk = zzgkVar.zzci();
                    break;
                case 104:
                    this.zzdo = zzgkVar.zzcv();
                    break;
                case 114:
                    int iZzb2 = zzgw.zzb(zzgkVar, 114);
                    int length2 = this.zzbx == null ? 0 : this.zzbx.length;
                    zzt[] zztVarArr = new zzt[iZzb2 + length2];
                    if (length2 != 0) {
                        System.arraycopy(this.zzbx, 0, zztVarArr, 0, length2);
                    }
                    while (length2 < zztVarArr.length - 1) {
                        zztVarArr[length2] = new zzt();
                        zzgkVar.zzb(zztVarArr[length2]);
                        zzgkVar.zzcc();
                        length2++;
                    }
                    zztVarArr[length2] = new zzt();
                    zzgkVar.zzb(zztVarArr[length2]);
                    this.zzbx = zztVarArr;
                    break;
                case 120:
                    this.zzdp = zzgkVar.zzcv();
                    break;
                case 128:
                    this.zzbz = zzgkVar.zzci();
                    break;
                case 136:
                    this.zzbv = zzgkVar.zzcv();
                    break;
                case 144:
                    this.zzbw = zzgkVar.zzcv();
                    break;
                case 154:
                    this.zzde = zzgkVar.readString();
                    break;
                case 160:
                    this.zzdq = zzgkVar.zzci();
                    break;
                case 170:
                    this.zzdr = zzgkVar.readString();
                    break;
                case 178:
                    this.zzbd = zzgkVar.readString();
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
        if (this.zzad != null && !this.zzad.equals("")) {
            zzglVar.zza(1, this.zzad);
        }
        if (this.zzah != null && !this.zzah.equals("")) {
            zzglVar.zza(2, this.zzah);
        }
        if (this.zzbh != null && !this.zzbh.equals("")) {
            zzglVar.zza(3, this.zzbh);
        }
        if (this.zzbj != null && this.zzbj.length > 0) {
            for (int i = 0; i < this.zzbj.length; i++) {
                String str = this.zzbj[i];
                if (str != null) {
                    zzglVar.zza(4, str);
                }
            }
        }
        if (this.zzcl != null && !this.zzcl.equals("")) {
            zzglVar.zza(5, this.zzcl);
        }
        if (this.zzbr != null && !this.zzbr.equals("")) {
            zzglVar.zza(6, this.zzbr);
        }
        if (this.zzcm != null && !this.zzcm.equals("")) {
            zzglVar.zza(7, this.zzcm);
        }
        if (this.zzcn != null && !this.zzcn.equals("")) {
            zzglVar.zza(8, this.zzcn);
        }
        if (!Arrays.equals(this.zzdm, zzgw.zzyk)) {
            zzglVar.zza(9, this.zzdm);
        }
        if (!Arrays.equals(this.zzdn, zzgw.zzyk)) {
            zzglVar.zza(10, this.zzdn);
        }
        if (this.version != 0) {
            zzglVar.zzc(11, this.version);
        }
        if (this.zzbk) {
            zzglVar.zzb(12, this.zzbk);
        }
        if (this.zzdo != 0) {
            zzglVar.zzi(13, this.zzdo);
        }
        if (this.zzbx != null && this.zzbx.length > 0) {
            for (int i2 = 0; i2 < this.zzbx.length; i2++) {
                zzt zztVar = this.zzbx[i2];
                if (zztVar != null) {
                    zzglVar.zza(14, zztVar);
                }
            }
        }
        if (this.zzdp != 0) {
            zzglVar.zzi(15, this.zzdp);
        }
        if (this.zzbz) {
            zzglVar.zzb(16, this.zzbz);
        }
        if (this.zzbv != 0) {
            zzglVar.zzi(17, this.zzbv);
        }
        if (this.zzbw != 0) {
            zzglVar.zzi(18, this.zzbw);
        }
        if (this.zzde != null && !this.zzde.equals("")) {
            zzglVar.zza(19, this.zzde);
        }
        if (this.zzdq) {
            zzglVar.zzb(20, this.zzdq);
        }
        if (this.zzdr != null && !this.zzdr.equals("")) {
            zzglVar.zza(21, this.zzdr);
        }
        if (this.zzbd != null && !this.zzbd.equals("")) {
            zzglVar.zza(22, this.zzbd);
        }
        super.zza(zzglVar);
    }

    @Override // com.google.android.gms.internal.firebase_auth.zzgn, com.google.android.gms.internal.firebase_auth.zzgt
    protected final int zzb() {
        int iZzb = super.zzb();
        if (this.zzad != null && !this.zzad.equals("")) {
            iZzb += zzgl.zzb(1, this.zzad);
        }
        if (this.zzah != null && !this.zzah.equals("")) {
            iZzb += zzgl.zzb(2, this.zzah);
        }
        if (this.zzbh != null && !this.zzbh.equals("")) {
            iZzb += zzgl.zzb(3, this.zzbh);
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
        if (this.zzcl != null && !this.zzcl.equals("")) {
            iZzb += zzgl.zzb(5, this.zzcl);
        }
        if (this.zzbr != null && !this.zzbr.equals("")) {
            iZzb += zzgl.zzb(6, this.zzbr);
        }
        if (this.zzcm != null && !this.zzcm.equals("")) {
            iZzb += zzgl.zzb(7, this.zzcm);
        }
        if (this.zzcn != null && !this.zzcn.equals("")) {
            iZzb += zzgl.zzb(8, this.zzcn);
        }
        if (!Arrays.equals(this.zzdm, zzgw.zzyk)) {
            iZzb += zzgl.zzb(9, this.zzdm);
        }
        if (!Arrays.equals(this.zzdn, zzgw.zzyk)) {
            iZzb += zzgl.zzb(10, this.zzdn);
        }
        if (this.version != 0) {
            iZzb += zzgl.zzg(11, this.version);
        }
        if (this.zzbk) {
            iZzb += zzgl.zzaa(12) + 1;
        }
        if (this.zzdo != 0) {
            iZzb += zzgl.zzd(13, this.zzdo);
        }
        if (this.zzbx != null && this.zzbx.length > 0) {
            for (int i3 = 0; i3 < this.zzbx.length; i3++) {
                zzt zztVar = this.zzbx[i3];
                if (zztVar != null) {
                    iZzb += zzgl.zzb(14, zztVar);
                }
            }
        }
        if (this.zzdp != 0) {
            iZzb += zzgl.zzd(15, this.zzdp);
        }
        if (this.zzbz) {
            iZzb += zzgl.zzaa(16) + 1;
        }
        if (this.zzbv != 0) {
            iZzb += zzgl.zzd(17, this.zzbv);
        }
        if (this.zzbw != 0) {
            iZzb += zzgl.zzd(18, this.zzbw);
        }
        if (this.zzde != null && !this.zzde.equals("")) {
            iZzb += zzgl.zzb(19, this.zzde);
        }
        if (this.zzdq) {
            iZzb += zzgl.zzaa(20) + 1;
        }
        if (this.zzdr != null && !this.zzdr.equals("")) {
            iZzb += zzgl.zzb(21, this.zzdr);
        }
        return (this.zzbd == null || this.zzbd.equals("")) ? iZzb : iZzb + zzgl.zzb(22, this.zzbd);
    }
}
