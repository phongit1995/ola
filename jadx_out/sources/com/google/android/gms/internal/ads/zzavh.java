package com.google.android.gms.internal.ads;

import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;

/* JADX INFO: loaded from: classes.dex */
final class zzavh {
    public static zzayv zza(zzawy zzawyVar) throws GeneralSecurityException {
        switch (zzavi.zzdia[zzawyVar.ordinal()]) {
            case 1:
                return zzayv.NIST_P256;
            case 2:
                return zzayv.NIST_P384;
            case 3:
                return zzayv.NIST_P521;
            default:
                String strValueOf = String.valueOf(zzawyVar);
                StringBuilder sb = new StringBuilder(String.valueOf(strValueOf).length() + 20);
                sb.append("unknown curve type: ");
                sb.append(strValueOf);
                throw new GeneralSecurityException(sb.toString());
        }
    }

    public static zzayw zza(zzawk zzawkVar) throws GeneralSecurityException {
        switch (zzavi.zzdib[zzawkVar.ordinal()]) {
            case 1:
                return zzayw.UNCOMPRESSED;
            case 2:
                return zzayw.COMPRESSED;
            default:
                String strValueOf = String.valueOf(zzawkVar);
                StringBuilder sb = new StringBuilder(String.valueOf(strValueOf).length() + 22);
                sb.append("unknown point format: ");
                sb.append(strValueOf);
                throw new GeneralSecurityException(sb.toString());
        }
    }

    public static String zza(zzaxa zzaxaVar) throws NoSuchAlgorithmException {
        switch (zzavi.zzdhz[zzaxaVar.ordinal()]) {
            case 1:
                return "HmacSha1";
            case 2:
                return "HmacSha256";
            case 3:
                return "HmacSha512";
            default:
                String strValueOf = String.valueOf(zzaxaVar);
                StringBuilder sb = new StringBuilder(String.valueOf(strValueOf).length() + 27);
                sb.append("hash unsupported for HMAC: ");
                sb.append(strValueOf);
                throw new NoSuchAlgorithmException(sb.toString());
        }
    }

    public static void zza(zzawq zzawqVar) throws GeneralSecurityException {
        zzayt.zza(zza(zzawqVar.zzxu().zzyh()));
        zza(zzawqVar.zzxu().zzyi());
        if (zzawqVar.zzxw() == zzawk.UNKNOWN_FORMAT) {
            throw new GeneralSecurityException("unknown EC point format");
        }
        zzauo.zza(zzawqVar.zzxv().zzxp());
    }
}
