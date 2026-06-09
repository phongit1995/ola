package chat.ola.vn.util;

/* JADX INFO: loaded from: classes.dex */
public class e {
    public static int a(byte b) {
        return b & 255;
    }

    public static int a(byte b, byte b2) {
        return ((b & 255) << 8) + (b2 & 255);
    }

    public static int a(byte b, byte b2, byte b3) {
        return ((b & 255) << 16) + ((b2 & 255) << 8) + (b3 & 255);
    }

    public static int a(byte b, byte b2, byte b3, byte b4) {
        return ((b & 255) << 24) + ((b2 & 255) << 16) + ((b3 & 255) << 8) + (b4 & 255);
    }

    public static int a(byte[] bArr) {
        if (bArr == null || bArr.length < 2) {
            return 0;
        }
        return a(bArr[0], bArr[1]);
    }

    public static long a(byte b, byte b2, byte b3, byte b4, byte b5, byte b6, byte b7, byte b8) {
        return (((long) b) << 56) + (((long) (b2 & 255)) << 48) + (((long) (b3 & 255)) << 40) + (((long) (b4 & 255)) << 32) + (((long) (b5 & 255)) << 24) + ((long) ((b6 & 255) << 16)) + ((long) ((b7 & 255) << 8)) + ((long) ((b8 & 255) << 0));
    }

    public static byte[] a(int i) {
        return new byte[]{(byte) ((i >>> 24) & 255), (byte) ((i >>> 16) & 255), (byte) ((i >>> 8) & 255), (byte) ((i >>> 0) & 255)};
    }

    public static byte[] a(long j) {
        return new byte[]{(byte) (j >>> 56), (byte) (j >>> 48), (byte) (j >>> 40), (byte) (j >>> 32), (byte) (j >>> 24), (byte) (j >>> 16), (byte) (j >>> 8), (byte) (j >>> 0)};
    }

    public static byte[] a(short s) {
        return new byte[]{(byte) ((s >>> 8) & 255), (byte) ((s >>> 0) & 255)};
    }

    public static int b(byte[] bArr) {
        if (bArr == null || bArr.length < 3) {
            return 0;
        }
        return a(bArr[0], bArr[1], bArr[2]);
    }

    public static int c(byte[] bArr) {
        if (bArr == null || bArr.length < 4) {
            return 0;
        }
        return a(bArr[0], bArr[1], bArr[2], bArr[3]);
    }

    public static long d(byte[] bArr) {
        if (bArr.length >= 8) {
            if (bArr.length <= 8) {
                return a(bArr[0], bArr[1], bArr[2], bArr[3], bArr[4], bArr[5], bArr[6], bArr[7]);
            }
            int i = 0;
            int i2 = 24;
            for (int i3 = 0; i3 < 8; i3++) {
                i += (bArr[i3] & 255) << i2;
                i2 -= 8;
            }
            return i;
        }
        int i4 = 0;
        int i5 = 0;
        int i6 = 56;
        while (i4 < bArr.length) {
            i5 += (bArr[i4] & 255) << i6;
            i6 -= 8;
            i4++;
        }
        while (i4 < 8) {
            i5 += 0 << i6;
            i6 -= 8;
            i4++;
        }
        return i5;
    }
}
