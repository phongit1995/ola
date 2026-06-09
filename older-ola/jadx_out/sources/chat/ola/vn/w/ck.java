package chat.ola.vn.w;

import chat.ola.vn.OlaApplication;
import java.io.File;
import java.io.FileOutputStream;

/* JADX INFO: loaded from: classes.dex */
public class ck implements bb {
    @Override // chat.ola.vn.w.bb
    public void a(bk bkVar, cg cgVar, chat.ola.vn.p.g gVar) {
        cgVar.a((short) 129, bkVar.w);
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
            String strB2 = sVar.b((short) 129);
            byte[] bArrA = sVar.a((short) 209);
            switch (bArrA[0]) {
                case 3:
                    short s = bArrA[1];
                    short s2 = bArrA[2];
                    byte[] bArr2 = new byte[bArrA.length - 3];
                    System.arraycopy(bArrA, 3, bArr2, 0, bArr2.length);
                    short sA3 = sVar.a(sVar.b((short) 45, 0), (short) 0);
                    File fileCreateTempFile = File.createTempFile(".voice.group." + strB2 + "." + System.currentTimeMillis(), ".tmp", OlaApplication.a().getCacheDir());
                    FileOutputStream fileOutputStream2 = new FileOutputStream(fileCreateTempFile);
                    fileOutputStream2.write(bArr2);
                    fileOutputStream2.flush();
                    fileOutputStream2.close();
                    gVar.a(strB, strB2, sA3, fileCreateTempFile.getAbsolutePath(), s2, s);
                    return;
                case 4:
                    byte[] bArr3 = new byte[bArrA.length - 1];
                    System.arraycopy(bArrA, 1, bArr3, 0, bArr3.length);
                    String[] strArrSplit = chat.ola.vn.util.m.a(bArr3).split("x");
                    gVar.a(strB, strB2, sVar.a(sVar.b((short) 45, 0), (short) 0), strArrSplit[0], strArrSplit[1]);
                    return;
                case 5:
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
                            file = new File(chat.ola.vn.d.m(), ".snap.group." + strB + "." + strB2 + "." + System.currentTimeMillis() + ".tmp");
                            fileOutputStream = new FileOutputStream(file);
                            break;
                        } catch (Throwable unused) {
                        }
                        try {
                            fileOutputStream.write(bArr);
                            chat.ola.vn.message.t tVarA = chat.ola.vn.message.e.a(strB, strB2, (short) 2, sA2, (byte) 1);
                            tVarA.a((byte) 2);
                            tVarA.a(file.getAbsolutePath(), sA);
                            gVar.b(tVarA);
                            fileOutputStream.close();
                            return;
                        } catch (Throwable th) {
                            th = th;
                            fileOutputStream3 = fileOutputStream;
                            try {
                                fileOutputStream3.close();
                                break;
                            } catch (Throwable unused2) {
                            }
                            throw th;
                        }
                    }
                    return;
                default:
                    return;
            }
        } catch (Throwable unused3) {
        }
    }
}
