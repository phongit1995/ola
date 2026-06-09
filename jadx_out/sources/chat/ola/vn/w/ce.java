package chat.ola.vn.w;

import java.io.IOException;
import java.io.InputStream;

/* JADX INFO: loaded from: classes.dex */
public class ce {
    public InputStream a;
    private chat.ola.vn.p.g b;

    public ce(InputStream inputStream) {
        this.a = inputStream;
    }

    private int a(byte[] bArr) throws IOException {
        int i = 0;
        while (i < bArr.length) {
            int i2 = this.a.read(bArr, i, bArr.length - i);
            if (i2 < 0) {
                return -1;
            }
            i += i2;
        }
        return i;
    }

    public s a() {
        s sVar = new s();
        byte[] bArr = new byte[7];
        if (a(bArr) <= 0) {
            return null;
        }
        int iA = chat.ola.vn.util.e.a(bArr[0], bArr[1]);
        int iA2 = chat.ola.vn.util.e.a(bArr[2], bArr[3], bArr[4], bArr[5]);
        sVar.a = iA2;
        sVar.b = chat.ola.vn.util.e.a(bArr[6]);
        if (iA2 > 0) {
            bq[] bqVarArr = new bq[iA];
            for (int i = 0; i < bqVarArr.length; i++) {
                byte[] bArr2 = new byte[5];
                if (a(bArr2) < 0) {
                    return null;
                }
                short sA = (short) chat.ola.vn.util.e.a(bArr2[0]);
                int iA3 = chat.ola.vn.util.e.a(bArr2[1], bArr2[2], bArr2[3], bArr2[4]);
                if (iA3 < 0 || iA3 > 1024000) {
                    return null;
                }
                byte[] bArr3 = new byte[iA3];
                if (a(bArr3) < 0) {
                    return null;
                }
                bqVarArr[i] = new bq();
                bqVarArr[i].a = sA;
                bqVarArr[i].b = bArr3;
            }
            sVar.c = bqVarArr;
        }
        return sVar;
    }

    public void a(chat.ola.vn.p.g gVar) {
        this.b = gVar;
    }

    public void b() {
        try {
            this.a.close();
        } catch (Throwable unused) {
        }
    }
}
