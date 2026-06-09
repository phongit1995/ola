package chat.ola.vn.c;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.AsyncTask;
import java.io.File;

/* JADX INFO: loaded from: classes.dex */
public abstract class b {
    protected File a;

    public abstract a a(String str);

    public abstract a a(String str, a aVar);

    public abstract void a();

    /* JADX WARN: Type inference failed for: r0v0, types: [chat.ola.vn.c.b$1] */
    protected final void a(final a aVar) {
        try {
            new AsyncTask<Void, Void, Void>() { // from class: chat.ola.vn.c.b.1
                /* JADX INFO: Access modifiers changed from: protected */
                @Override // android.os.AsyncTask
                /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                public Void doInBackground(Void... voidArr) {
                    if (b.this.a == null) {
                        return null;
                    }
                    try {
                        if (!aVar.d) {
                            com.mg.ola.common.d.c.b(aVar.a, new File(b.this.a.getAbsoluteFile(), aVar.b));
                            return null;
                        }
                        File file = new File(b.this.a.getAbsoluteFile(), ".best");
                        if (!file.exists()) {
                            file.mkdir();
                        }
                        com.mg.ola.common.d.c.b(aVar.a, new File(file.getAbsoluteFile(), aVar.b));
                        return null;
                    } catch (Throwable unused) {
                        return null;
                    }
                }
            }.execute(new Void[0]);
        } catch (Throwable unused) {
        }
    }

    public abstract a b(String str);

    protected final void b(a aVar) {
        try {
            if (!aVar.d) {
                File file = new File(this.a.getAbsoluteFile(), aVar.b);
                if (file.exists()) {
                    file.delete();
                    return;
                }
                return;
            }
            File file2 = new File(this.a.getAbsoluteFile(), ".best");
            if (file2.exists()) {
                File file3 = new File(file2.getAbsoluteFile(), aVar.b);
                if (file3.exists()) {
                    file3.delete();
                }
            }
        } catch (Throwable unused) {
        }
    }

    protected final a c(String str) {
        Bitmap bitmapDecodeFile;
        try {
            File file = new File(this.a.getAbsoluteFile(), ".best");
            if (file.exists()) {
                File file2 = new File(file.getAbsoluteFile(), str);
                if (file2.exists()) {
                    try {
                        Bitmap bitmapDecodeFile2 = BitmapFactory.decodeFile(file2.getAbsolutePath());
                        if (bitmapDecodeFile2 != null) {
                            a aVar = new a();
                            aVar.c = System.currentTimeMillis();
                            aVar.a = bitmapDecodeFile2;
                            aVar.b = str;
                            aVar.d = true;
                            aVar.e = true;
                            a(str, aVar);
                            return aVar;
                        }
                    } catch (Throwable unused) {
                    }
                }
            }
            File file3 = new File(this.a.getAbsoluteFile(), str);
            if (!file3.exists() || (bitmapDecodeFile = BitmapFactory.decodeFile(file3.getAbsolutePath())) == null) {
                return null;
            }
            a aVar2 = new a();
            aVar2.c = System.currentTimeMillis();
            aVar2.a = bitmapDecodeFile;
            aVar2.b = str;
            aVar2.d = false;
            aVar2.e = true;
            a(str, aVar2);
            return aVar2;
        } catch (Throwable unused2) {
            return null;
        }
    }
}
