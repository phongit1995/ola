package com.google.android.gms.internal.ads;

/* JADX INFO: loaded from: classes.dex */
final class zzbad {
    static int zza(int i, byte[] bArr, int i2, int i3, zzbae zzbaeVar) {
        if ((i >>> 3) == 0) {
            throw zzbbu.zzado();
        }
        int i4 = i & 7;
        if (i4 == 5) {
            return i2 + 4;
        }
        switch (i4) {
            case 0:
                return zzb(bArr, i2, zzbaeVar);
            case 1:
                return i2 + 8;
            case 2:
                return zza(bArr, i2, zzbaeVar) + zzbaeVar.zzdpl;
            case 3:
                int i5 = (i & (-8)) | 4;
                int i6 = 0;
                while (i2 < i3) {
                    i2 = zza(bArr, i2, zzbaeVar);
                    i6 = zzbaeVar.zzdpl;
                    if (i6 == i5) {
                        if (i2 <= i3 || i6 != i5) {
                            throw zzbbu.zzadr();
                        }
                        return i2;
                    }
                    i2 = zza(i6, bArr, i2, i3, zzbaeVar);
                }
                if (i2 <= i3) {
                }
                throw zzbbu.zzadr();
            default:
                throw zzbbu.zzado();
        }
    }

    static int zza(int i, byte[] bArr, int i2, int i3, zzbbt<?> zzbbtVar, zzbae zzbaeVar) {
        zzbbp zzbbpVar = (zzbbp) zzbbtVar;
        int iZza = zza(bArr, i2, zzbaeVar);
        while (true) {
            zzbbpVar.zzco(zzbaeVar.zzdpl);
            if (iZza >= i3) {
                break;
            }
            int iZza2 = zza(bArr, iZza, zzbaeVar);
            if (i != zzbaeVar.zzdpl) {
                break;
            }
            iZza = zza(bArr, iZza2, zzbaeVar);
        }
        return iZza;
    }

    static int zza(int i, byte[] bArr, int i2, int i3, zzbef zzbefVar, zzbae zzbaeVar) throws zzbbu {
        if ((i >>> 3) == 0) {
            throw zzbbu.zzado();
        }
        int i4 = i & 7;
        if (i4 == 5) {
            zzbefVar.zzb(i, Integer.valueOf(zze(bArr, i2)));
            return i2 + 4;
        }
        switch (i4) {
            case 0:
                int iZzb = zzb(bArr, i2, zzbaeVar);
                zzbefVar.zzb(i, Long.valueOf(zzbaeVar.zzdpm));
                return iZzb;
            case 1:
                zzbefVar.zzb(i, Long.valueOf(zzf(bArr, i2)));
                return i2 + 8;
            case 2:
                int iZza = zza(bArr, i2, zzbaeVar);
                int i5 = zzbaeVar.zzdpl;
                zzbefVar.zzb(i, i5 == 0 ? zzbah.zzdpq : zzbah.zzc(bArr, iZza, i5));
                return iZza + i5;
            case 3:
                zzbef zzbefVarZzagd = zzbef.zzagd();
                int i6 = (i & (-8)) | 4;
                int i7 = 0;
                while (true) {
                    if (i2 < i3) {
                        int iZza2 = zza(bArr, i2, zzbaeVar);
                        int i8 = zzbaeVar.zzdpl;
                        if (i8 != i6) {
                            i7 = i8;
                            i2 = zza(i8, bArr, iZza2, i3, zzbefVarZzagd, zzbaeVar);
                        } else {
                            i7 = i8;
                            i2 = iZza2;
                        }
                    }
                }
                if (i2 > i3 || i7 != i6) {
                    throw zzbbu.zzadr();
                }
                zzbefVar.zzb(i, zzbefVarZzagd);
                return i2;
            default:
                throw zzbbu.zzado();
        }
    }

    static int zza(int i, byte[] bArr, int i2, zzbae zzbaeVar) {
        int i3;
        int i4;
        int i5 = i & 127;
        int i6 = i2 + 1;
        byte b = bArr[i2];
        if (b < 0) {
            int i7 = i5 | ((b & 127) << 7);
            int i8 = i6 + 1;
            byte b2 = bArr[i6];
            if (b2 >= 0) {
                i3 = b2 << 14;
            } else {
                i5 = i7 | ((b2 & 127) << 14);
                i6 = i8 + 1;
                byte b3 = bArr[i8];
                if (b3 >= 0) {
                    i4 = b3 << 21;
                } else {
                    i7 = i5 | ((b3 & 127) << 21);
                    i8 = i6 + 1;
                    byte b4 = bArr[i6];
                    if (b4 >= 0) {
                        i3 = b4 << 28;
                    } else {
                        int i9 = i7 | ((b4 & 127) << 28);
                        while (true) {
                            int i10 = i8 + 1;
                            if (bArr[i8] >= 0) {
                                zzbaeVar.zzdpl = i9;
                                return i10;
                            }
                            i8 = i10;
                        }
                    }
                }
            }
            zzbaeVar.zzdpl = i7 | i3;
            return i8;
        }
        i4 = b << 7;
        zzbaeVar.zzdpl = i5 | i4;
        return i6;
    }

    static int zza(byte[] bArr, int i, zzbae zzbaeVar) {
        int i2 = i + 1;
        byte b = bArr[i];
        if (b < 0) {
            return zza(b, bArr, i2, zzbaeVar);
        }
        zzbaeVar.zzdpl = b;
        return i2;
    }

    static int zza(byte[] bArr, int i, zzbbt<?> zzbbtVar, zzbae zzbaeVar) {
        zzbbp zzbbpVar = (zzbbp) zzbbtVar;
        int iZza = zza(bArr, i, zzbaeVar);
        int i2 = zzbaeVar.zzdpl + iZza;
        while (iZza < i2) {
            iZza = zza(bArr, iZza, zzbaeVar);
            zzbbpVar.zzco(zzbaeVar.zzdpl);
        }
        if (iZza != i2) {
            throw zzbbu.zzadl();
        }
        return iZza;
    }

    static int zzb(byte[] bArr, int i, zzbae zzbaeVar) {
        int i2 = i + 1;
        long j = bArr[i];
        if (j >= 0) {
            zzbaeVar.zzdpm = j;
            return i2;
        }
        int i3 = i2 + 1;
        byte b = bArr[i2];
        long j2 = (j & 127) | (((long) (b & 127)) << 7);
        int i4 = 7;
        while (b < 0) {
            int i5 = i3 + 1;
            byte b2 = bArr[i3];
            i4 += 7;
            j2 |= ((long) (b2 & 127)) << i4;
            b = b2;
            i3 = i5;
        }
        zzbaeVar.zzdpm = j2;
        return i3;
    }

    static int zzc(byte[] bArr, int i, zzbae zzbaeVar) {
        int iZza = zza(bArr, i, zzbaeVar);
        int i2 = zzbaeVar.zzdpl;
        if (i2 == 0) {
            zzbaeVar.zzdpn = "";
            return iZza;
        }
        zzbaeVar.zzdpn = new String(bArr, iZza, i2, zzbbq.UTF_8);
        return iZza + i2;
    }

    static int zzd(byte[] bArr, int i, zzbae zzbaeVar) throws zzbbu {
        int iZza = zza(bArr, i, zzbaeVar);
        int i2 = zzbaeVar.zzdpl;
        if (i2 == 0) {
            zzbaeVar.zzdpn = "";
            return iZza;
        }
        int i3 = iZza + i2;
        if (!zzbem.zzf(bArr, iZza, i3)) {
            throw zzbbu.zzads();
        }
        zzbaeVar.zzdpn = new String(bArr, iZza, i2, zzbbq.UTF_8);
        return i3;
    }

    static int zze(byte[] bArr, int i) {
        return ((bArr[i + 3] & 255) << 24) | (bArr[i] & 255) | ((bArr[i + 1] & 255) << 8) | ((bArr[i + 2] & 255) << 16);
    }

    static int zze(byte[] bArr, int i, zzbae zzbaeVar) {
        int iZza = zza(bArr, i, zzbaeVar);
        int i2 = zzbaeVar.zzdpl;
        if (i2 == 0) {
            zzbaeVar.zzdpn = zzbah.zzdpq;
            return iZza;
        }
        zzbaeVar.zzdpn = zzbah.zzc(bArr, iZza, i2);
        return iZza + i2;
    }

    static long zzf(byte[] bArr, int i) {
        return (((long) bArr[i]) & 255) | ((((long) bArr[i + 1]) & 255) << 8) | ((((long) bArr[i + 2]) & 255) << 16) | ((((long) bArr[i + 3]) & 255) << 24) | ((((long) bArr[i + 4]) & 255) << 32) | ((((long) bArr[i + 5]) & 255) << 40) | ((((long) bArr[i + 6]) & 255) << 48) | ((((long) bArr[i + 7]) & 255) << 56);
    }

    static double zzg(byte[] bArr, int i) {
        return Double.longBitsToDouble(zzf(bArr, i));
    }

    static float zzh(byte[] bArr, int i) {
        return Float.intBitsToFloat(zze(bArr, i));
    }
}
