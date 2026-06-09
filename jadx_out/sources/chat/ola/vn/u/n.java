package chat.ola.vn.u;

import chat.ola.vn.w.cg;
import java.io.OutputStream;

/* JADX INFO: loaded from: classes.dex */
class n implements chat.ola.vn.f.d {
    private OutputStream e;

    public n(OutputStream outputStream) {
        this.e = outputStream;
    }

    public void a() {
        try {
            this.e.close();
        } catch (Throwable th) {
            this.e = null;
            throw th;
        }
        this.e = null;
    }

    synchronized void a(cg cgVar) {
        byte[] bArrA = cgVar.a();
        if (bArrA != null) {
            byte[] bArr = new byte[bArrA.length + 10];
            byte[] bArrA2 = chat.ola.vn.util.e.a(bArr.length - 4);
            bArr[0] = bArrA2[0];
            bArr[1] = bArrA2[1];
            bArr[2] = bArrA2[2];
            bArr[3] = bArrA2[3];
            bArr[4] = 6;
            bArr[5] = 5;
            bArr[6] = 10;
            bArr[7] = 19;
            bArr[8] = 4;
            bArr[9] = (byte) cgVar.b();
            System.arraycopy(bArrA, 0, bArr, 10, bArrA.length);
            this.e.write(bArr, 0, bArr.length);
        } else {
            byte[] bArrA3 = chat.ola.vn.util.e.a(bArr.length - 4);
            byte[] bArr2 = {bArrA3[0], bArrA3[1], bArrA3[2], bArrA3[3], 6, 5, 10, 19, 4, (byte) cgVar.b()};
            this.e.write(bArr2, 0, bArr2.length);
        }
        this.e.flush();
    }
}
