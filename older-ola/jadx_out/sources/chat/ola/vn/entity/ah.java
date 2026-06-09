package chat.ola.vn.entity;

import java.util.ArrayList;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class ah {
    private static byte[] a = {-119, 80, 78, 71, 13, 10, 26, 10};
    private byte[] b;
    private String c;
    private String d;
    private int e;
    private boolean f;
    private boolean g;

    public ah(int i) {
        this(i, null);
    }

    public ah(int i, byte[] bArr) {
        this.b = null;
        this.g = false;
        this.e = i;
        this.b = bArr;
    }

    public static List<ah> b(byte[] bArr) {
        String strA;
        char c = 1;
        int iA = chat.ola.vn.util.e.a(bArr[0], bArr[1]);
        if (iA <= 0) {
            return null;
        }
        ArrayList arrayList = new ArrayList(iA);
        char c2 = 2;
        int i = 0;
        int i2 = 2;
        while (i < iA) {
            int i3 = i2 + 1;
            int i4 = i3 + 1;
            short sA = (short) chat.ola.vn.util.e.a(bArr[i2], bArr[i3]);
            int i5 = i4 + 1;
            int i6 = i5 + 1;
            int i7 = i6 + 1;
            int i8 = i7 + 1;
            int iA2 = chat.ola.vn.util.e.a(bArr[i4], bArr[i5], bArr[i6], bArr[i7]);
            if (iA2 > 0) {
                strA = chat.ola.vn.util.o.a(bArr, i8, iA2);
                i8 += iA2;
            } else {
                strA = null;
            }
            ah ahVar = new ah(sA);
            ahVar.a(strA);
            int i9 = i8 + 1;
            int i10 = i9 + 1;
            int i11 = i10 + 1;
            int i12 = i11 + 1;
            int iA3 = chat.ola.vn.util.e.a(bArr[i8], bArr[i9], bArr[i10], bArr[i11]);
            if (iA3 > 0) {
                int i13 = i12 - 1;
                byte b = bArr[i13];
                int i14 = i12 - 2;
                byte b2 = bArr[i14];
                int i15 = i12 - 3;
                byte b3 = bArr[i15];
                int i16 = i12 - 4;
                byte b4 = bArr[i16];
                int i17 = i12 - 5;
                byte b5 = bArr[i17];
                int i18 = i12 - 6;
                byte b6 = bArr[i18];
                int i19 = i12 - 7;
                byte b7 = bArr[i19];
                int i20 = i12 - 8;
                byte b8 = bArr[i20];
                byte[] bArr2 = new byte[a.length + iA3];
                bArr[i13] = a[7];
                bArr[i14] = a[6];
                bArr[i15] = a[5];
                bArr[i16] = a[4];
                bArr[i17] = a[3];
                bArr[i18] = a[c2];
                bArr[i19] = a[c];
                bArr[i20] = a[0];
                System.arraycopy(bArr, i12 - a.length, bArr2, 0, a.length + iA3);
                bArr[i13] = b;
                bArr[i14] = b2;
                bArr[i15] = b3;
                bArr[i16] = b4;
                bArr[i17] = b5;
                bArr[i18] = b6;
                bArr[i19] = b7;
                bArr[i20] = b8;
                i12 += iA3;
                ahVar.a(bArr2);
            }
            i2 = i12;
            arrayList.add(ahVar);
            i++;
            c = 1;
            c2 = 2;
        }
        return arrayList;
    }

    public void a(String str) {
        this.c = str;
    }

    public void a(boolean z) {
        this.f = z;
    }

    public void a(byte[] bArr) {
        this.b = bArr;
    }

    public int b() {
        return this.e;
    }

    public void b(String str) {
        this.d = str;
    }

    public void b(boolean z) {
        this.g = z;
    }

    public byte[] c() {
        return this.b;
    }

    public String d() {
        return this.c;
    }

    public String e() {
        return this.d;
    }

    public boolean f() {
        return this.f;
    }

    public boolean g() {
        return this.g;
    }
}
