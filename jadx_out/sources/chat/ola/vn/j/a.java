package chat.ola.vn.j;

import chat.ola.vn.util.m;
import java.security.MessageDigest;

/* JADX INFO: loaded from: classes.dex */
public class a {
    private static final char[] a = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'};

    public static String a(String str) {
        try {
            MessageDigest messageDigest = MessageDigest.getInstance("MD5");
            byte[] bytes = str.getBytes();
            messageDigest.update(bytes, 0, bytes.length);
            return a(messageDigest.digest());
        } catch (Throwable unused) {
            return null;
        }
    }

    private static String a(byte[] bArr) {
        char[] cArr = new char[bArr.length * 2];
        int i = 0;
        for (int i2 = 0; i2 < bArr.length; i2++) {
            int i3 = i + 1;
            cArr[i] = a[(bArr[i2] >>> 4) & 15];
            i = i3 + 1;
            cArr[i3] = a[bArr[i2] & 15];
        }
        return new String(cArr);
    }

    public static String a(byte[] bArr, byte[] bArr2) {
        int i;
        if (bArr == null || bArr2 == 0 || bArr.length == 0 || bArr2.length == 0 || (i = bArr2[0]) <= 0) {
            return null;
        }
        byte b = bArr[0];
        byte[] bArr3 = new byte[i];
        int i2 = b;
        while (i2 < bArr3.length + b) {
            try {
                int i3 = i2 + 1;
                bArr3[i2 - b] = (byte) ((i3 < bArr.length ? bArr[i3] : (char) 17) ^ bArr2[i3]);
                i2 = i3;
            } catch (Throwable unused) {
                int i4 = b;
                while (i4 < bArr3.length + b) {
                    try {
                        int i5 = i4 + 1;
                        bArr3[i4 - b] = (byte) ((i5 < bArr.length ? bArr[i5] : (char) 17) ^ bArr2[i5]);
                        i4 = i5;
                    } catch (Throwable unused2) {
                        return new String(bArr3, 0, bArr3.length);
                    }
                }
                return new String(bArr3, 0, bArr3.length);
            }
        }
        return m.a(bArr3);
    }

    public static byte[] a(byte[] bArr, String str) {
        if (bArr == null || bArr.length == 0 || str == null || str.length() == 0) {
            return null;
        }
        try {
            byte[] bytes = str.getBytes("UTF-8");
            String strA = a(str);
            return b(strA.getBytes(), b(bArr, bytes));
        } catch (Throwable unused) {
            return null;
        }
    }

    public static byte[] b(byte[] bArr, String str) {
        int i;
        int i2;
        try {
            try {
                byte b = bArr[0];
                byte[] bytes = str.getBytes();
                byte[] bArr2 = new byte[Math.max(bArr.length - 1, bytes.length + b) + 1];
                bArr2[0] = (byte) bytes.length;
                int i3 = 0;
                while (i3 < bArr2.length - 1) {
                    int i4 = i3 + 1;
                    bArr2[i4] = (byte) (((i3 < b || (i2 = i3 - b) >= bytes.length) ? (byte) 0 : bytes[i2]) ^ (i4 < bArr.length ? bArr[i4] : (byte) 17));
                    i3 = i4;
                }
                return bArr2;
            } catch (Throwable unused) {
                byte b2 = bArr[0];
                byte[] bytes2 = str.getBytes();
                byte[] bArr3 = new byte[Math.max(bArr.length - 1, bytes2.length + b2) + 1];
                bArr3[0] = (byte) bytes2.length;
                int i5 = 0;
                while (i5 < bArr3.length - 1) {
                    int i6 = i5 + 1;
                    bArr3[i6] = (byte) (((i5 < b2 || (i = i5 - b2) >= bytes2.length) ? (byte) 0 : bytes2[i]) ^ (i6 < bArr.length ? bArr[i6] : (byte) 17));
                    i5 = i6;
                }
                return bArr3;
            }
        } catch (Throwable unused2) {
            return null;
        }
    }

    private static byte[] b(byte[] bArr, byte[] bArr2) {
        int i;
        if (bArr == null || bArr.length == 0 || bArr2 == null || bArr2.length == 0) {
            return null;
        }
        byte b = bArr[0];
        byte[] bArr3 = new byte[Math.max(bArr.length - 1, bArr2.length + b) + 1];
        bArr3[0] = (byte) bArr2.length;
        int i2 = 0;
        while (i2 < bArr3.length - 1) {
            int i3 = i2 + 1;
            bArr3[i3] = (byte) (((i2 < b || (i = i2 - b) >= bArr2.length) ? (byte) 0 : bArr2[i]) ^ (i3 < bArr.length ? bArr[i3] : (byte) 17));
            i2 = i3;
        }
        return bArr3;
    }
}
