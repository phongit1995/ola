package com.google.android.gms.internal.ads;

import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.security.MessageDigest;

/* JADX INFO: loaded from: classes.dex */
@zzadh
public final class zzgv extends zzgq {
    private MessageDigest zzaje;

    @Override // com.google.android.gms.internal.ads.zzgq
    public final byte[] zzx(String str) {
        byte[] bArrArray;
        String[] strArrSplit = str.split(" ");
        int length = 4;
        if (strArrSplit.length == 1) {
            int iZzz = zzgu.zzz(strArrSplit[0]);
            ByteBuffer byteBufferAllocate = ByteBuffer.allocate(4);
            byteBufferAllocate.order(ByteOrder.LITTLE_ENDIAN);
            byteBufferAllocate.putInt(iZzz);
            bArrArray = byteBufferAllocate.array();
        } else if (strArrSplit.length < 5) {
            bArrArray = new byte[strArrSplit.length << 1];
            for (int i = 0; i < strArrSplit.length; i++) {
                int iZzz2 = zzgu.zzz(strArrSplit[i]);
                int i2 = (iZzz2 >> 16) ^ (65535 & iZzz2);
                byte[] bArr = {(byte) i2, (byte) (i2 >> 8)};
                int i3 = i << 1;
                bArrArray[i3] = bArr[0];
                bArrArray[i3 + 1] = bArr[1];
            }
        } else {
            bArrArray = new byte[strArrSplit.length];
            for (int i4 = 0; i4 < strArrSplit.length; i4++) {
                int iZzz3 = zzgu.zzz(strArrSplit[i4]);
                bArrArray[i4] = (byte) ((iZzz3 >> 24) ^ (((iZzz3 & 255) ^ ((iZzz3 >> 8) & 255)) ^ ((iZzz3 >> 16) & 255)));
            }
        }
        this.zzaje = zzhg();
        synchronized (this.mLock) {
            if (this.zzaje == null) {
                return new byte[0];
            }
            this.zzaje.reset();
            this.zzaje.update(bArrArray);
            byte[] bArrDigest = this.zzaje.digest();
            if (bArrDigest.length <= 4) {
                length = bArrDigest.length;
            }
            byte[] bArr2 = new byte[length];
            System.arraycopy(bArrDigest, 0, bArr2, 0, bArr2.length);
            return bArr2;
        }
    }
}
