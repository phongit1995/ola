package com.google.android.gms.internal.firebase_auth;

import java.nio.ByteBuffer;
import java.nio.charset.Charset;

/* JADX INFO: loaded from: classes2.dex */
public final class zzdd {
    public static final byte[] EMPTY_BYTE_ARRAY;
    private static final ByteBuffer zzru;
    private static final zzcd zzrv;
    static final Charset UTF_8 = Charset.forName("UTF-8");
    private static final Charset ISO_8859_1 = Charset.forName("ISO-8859-1");

    static {
        byte[] bArr = new byte[0];
        EMPTY_BYTE_ARRAY = bArr;
        zzru = ByteBuffer.wrap(bArr);
        byte[] bArr2 = EMPTY_BYTE_ARRAY;
        zzrv = zzcd.zza(bArr2, 0, bArr2.length, false);
    }

    static <T> T checkNotNull(T t) {
        if (t == null) {
            throw new NullPointerException();
        }
        return t;
    }

    public static int hashCode(byte[] bArr) {
        int length = bArr.length;
        int iZza = zza(length, bArr, 0, length);
        if (iZza == 0) {
            return 1;
        }
        return iZza;
    }

    static int zza(int i, byte[] bArr, int i2, int i3) {
        int i4 = i;
        for (int i5 = i2; i5 < i2 + i3; i5++) {
            i4 = (i4 * 31) + bArr[i5];
        }
        return i4;
    }

    static Object zza(Object obj, Object obj2) {
        return ((zzeh) obj).zzdz().zza((zzeh) obj2).zzec();
    }

    static <T> T zza(T t, String str) {
        if (t == null) {
            throw new NullPointerException(str);
        }
        return t;
    }

    public static boolean zzd(byte[] bArr) {
        return zzfx.zzd(bArr);
    }

    public static String zze(byte[] bArr) {
        return new String(bArr, UTF_8);
    }

    static boolean zzf(zzeh zzehVar) {
        return false;
    }

    public static int zzh(boolean z) {
        return z ? 1231 : 1237;
    }

    public static int zzk(long j) {
        return (int) (j ^ (j >>> 32));
    }
}
