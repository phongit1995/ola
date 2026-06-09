package chat.ola.vn.w;

import java.io.File;
import java.io.FileOutputStream;

/* JADX INFO: loaded from: classes.dex */
public class cl implements bb {
    private void b(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        String strB = sVar.b((short) 7);
        byte[] bArrA = sVar.a((short) 209);
        int iA = chat.ola.vn.util.e.a(bArrA[0]);
        int[] iArr = new int[2];
        switch (chat.ola.vn.util.e.a(bArrA[1])) {
            case 1:
                gVar.a(strB, iA);
                break;
            case 2:
                gVar.b(strB, iA);
                break;
            case 3:
                gVar.c(strB, iA);
                break;
            case 4:
                gVar.d(strB, iA);
                break;
            case 5:
                gVar.e(strB, iA);
                break;
            case 6:
                gVar.f(strB, iA);
                break;
            case 7:
                gVar.g(strB, iA);
                break;
            case 8:
                gVar.a(strB, iA, new int[]{chat.ola.vn.util.e.a(bArrA[2], bArrA[3]), chat.ola.vn.util.e.a(bArrA[4], bArrA[5])}, new int[]{chat.ola.vn.util.e.a(bArrA[6], bArrA[7]), chat.ola.vn.util.e.a(bArrA[8], bArrA[9])});
                break;
            case 9:
                gVar.a(strB, iA, (int[]) null, new int[]{chat.ola.vn.util.e.a(bArrA[2], bArrA[3]), chat.ola.vn.util.e.a(bArrA[4], bArrA[5])});
                break;
        }
    }

    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        cgVar.a((short) 7, bkVar.p);
        cgVar.a((short) 209, bkVar.ap);
    }

    @Override // chat.ola.vn.w.bb
    public void a(s sVar, chat.ola.vn.p.g gVar, ci ciVar) {
        short sA;
        byte[] bArr;
        short sA2;
        File file;
        FileOutputStream fileOutputStream;
        try {
            String strB = sVar.b((short) 7);
            byte[] bArrA = sVar.a((short) 209);
            switch (bArrA[0]) {
                case 1:
                case 2:
                    b(sVar, gVar, ciVar);
                    return;
                case 3:
                    short s = bArrA[1];
                    short s2 = bArrA[2];
                    byte[] bArr2 = new byte[bArrA.length - 3];
                    System.arraycopy(bArrA, 3, bArr2, 0, bArr2.length);
                    short sA3 = sVar.a(sVar.b((short) 45, 0), (short) 0);
                    File file2 = new File(chat.ola.vn.d.l(), ".voice." + strB + "." + System.currentTimeMillis() + ".tmp");
                    FileOutputStream fileOutputStream2 = new FileOutputStream(file2);
                    fileOutputStream2.write(bArr2);
                    fileOutputStream2.flush();
                    fileOutputStream2.close();
                    gVar.a(strB, sA3, file2.getAbsolutePath(), s2, s);
                    return;
                case 4:
                    byte[] bArr3 = new byte[bArrA.length - 1];
                    System.arraycopy(bArrA, 1, bArr3, 0, bArr3.length);
                    String[] strArrSplit = chat.ola.vn.util.m.a(bArr3).split("x");
                    gVar.a(strB, sVar.a(sVar.b((short) 45, 0), (short) 0), strArrSplit[0], strArrSplit[1]);
                    return;
                case 5:
                    byte[] bArr4 = new byte[bArrA.length - 1];
                    System.arraycopy(bArrA, 1, bArr4, 0, bArr4.length);
                    gVar.j(strB, chat.ola.vn.util.m.a(bArr4));
                    return;
                case 6:
                    return;
                case 7:
                    if (bArrA[1] == 0) {
                        FileOutputStream fileOutputStream3 = null;
                        try {
                            sA = (short) chat.ola.vn.util.e.a(bArrA[2], bArrA[3]);
                            bArr = new byte[bArrA.length - 4];
                            System.arraycopy(bArrA, 4, bArr, 0, bArr.length);
                            sA2 = sVar.a(sVar.b((short) 45, 0), (short) 0);
                            file = new File(chat.ola.vn.d.m(), ".snap." + strB + "." + System.currentTimeMillis() + ".tmp");
                            fileOutputStream = new FileOutputStream(file);
                            break;
                        } catch (Throwable th) {
                            th = th;
                        }
                        try {
                            fileOutputStream.write(bArr);
                            chat.ola.vn.message.t tVarA = chat.ola.vn.message.e.a(strB, ciVar.f, (short) 0, sA2, (byte) 1);
                            tVarA.a((byte) 2);
                            tVarA.a(file.getAbsolutePath(), sA);
                            gVar.a(tVarA);
                            fileOutputStream.close();
                            return;
                        } catch (Throwable unused) {
                            fileOutputStream3 = fileOutputStream;
                            fileOutputStream3.close();
                            return;
                        }
                    }
                    return;
                default:
                    return;
            }
        } catch (Throwable unused2) {
        }
    }
}
