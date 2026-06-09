package com.google.android.gms.internal.ads;

import java.security.GeneralSecurityException;

/* JADX INFO: loaded from: classes.dex */
final class zzavm implements zzaua<zzauk> {
    @Override // com.google.android.gms.internal.ads.zzaua
    public final zzaug<zzauk> zzb(String str, String str2, int i) throws GeneralSecurityException {
        String lowerCase = str2.toLowerCase();
        byte b = -1;
        if (((lowerCase.hashCode() == 107855 && lowerCase.equals("mac")) ? (byte) 0 : (byte) -1) != 0) {
            throw new GeneralSecurityException(String.format("No support for primitive '%s'.", str2));
        }
        if (str.hashCode() == 836622442 && str.equals("type.googleapis.com/google.crypto.tink.HmacKey")) {
            b = 0;
        }
        if (b != 0) {
            throw new GeneralSecurityException(String.format("No support for primitive 'Mac' with key type '%s'.", str));
        }
        zzavk zzavkVar = new zzavk();
        if (i > 0) {
            throw new GeneralSecurityException(String.format("No key manager for key type '%s' with version at least %d.", str, Integer.valueOf(i)));
        }
        return zzavkVar;
    }
}
