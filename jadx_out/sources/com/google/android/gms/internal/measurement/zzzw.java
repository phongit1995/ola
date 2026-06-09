package com.google.android.gms.internal.measurement;

import java.nio.ByteBuffer;
import java.nio.charset.Charset;

/* JADX INFO: loaded from: classes2.dex */
public final class zzzw {
    public static final byte[] zzbux;
    private static final ByteBuffer zzbuy;
    private static final zzzj zzbuz;
    static final Charset UTF_8 = Charset.forName("UTF-8");
    private static final Charset ISO_8859_1 = Charset.forName("ISO-8859-1");

    static {
        byte[] bArr = new byte[0];
        zzbux = bArr;
        zzbuy = ByteBuffer.wrap(bArr);
        byte[] bArr2 = zzbux;
        zzbuz = zzzj.zza(bArr2, 0, bArr2.length, false);
    }

    static <T> T checkNotNull(T t) {
        if (t == null) {
            throw new NullPointerException();
        }
        return t;
    }

    static int zza(int i, byte[] bArr, int i2, int i3) {
        int i4 = i;
        for (int i5 = i2; i5 < i2 + i3; i5++) {
            i4 = (i4 * 31) + bArr[i5];
        }
        return i4;
    }

    static <T> T zza(T t, String str) {
        if (t == null) {
            throw new NullPointerException(str);
        }
        return t;
    }
}
