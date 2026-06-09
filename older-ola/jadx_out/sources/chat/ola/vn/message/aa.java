package chat.ola.vn.message;

import android.annotation.SuppressLint;
import android.media.MediaMetadataRetriever;
import android.os.AsyncTask;
import chat.ola.vn.entry.b.ah;
import java.io.File;

/* JADX INFO: loaded from: classes.dex */
public class aa extends d {
    public Long A;
    public Long B;
    public ah C;
    protected boolean D;
    protected boolean E;
    private String F;
    private String G;
    public byte z;

    public aa(d dVar, byte b) {
        super(dVar, b, (byte) 3);
        this.z = (byte) 0;
        this.A = null;
        this.B = null;
        this.D = false;
        this.E = false;
    }

    public String C() {
        return this.G;
    }

    public boolean D() {
        return this.D;
    }

    public boolean E() {
        return this.E;
    }

    /* JADX WARN: Type inference failed for: r2v0, types: [chat.ola.vn.message.aa$1] */
    public void F() {
        try {
            this.E = true;
            new AsyncTask<String, String, String>() { // from class: chat.ola.vn.message.aa.1
                /* JADX INFO: Access modifiers changed from: protected */
                @Override // android.os.AsyncTask
                /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                public String doInBackground(String... strArr) {
                    try {
                        File file = new File(chat.ola.vn.d.l(), ".voice." + aa.this.G + "." + aa.this.l + ".tmp");
                        String absolutePath = file.getAbsolutePath();
                        if (file.exists()) {
                            return absolutePath;
                        }
                        chat.ola.vn.util.o.c(strArr[0], absolutePath);
                        return absolutePath;
                    } catch (Throwable unused) {
                        return null;
                    }
                }

                /* JADX INFO: Access modifiers changed from: protected */
                @Override // android.os.AsyncTask
                /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
                public void onPostExecute(String str) {
                    try {
                        aa.this.E = false;
                        if (str != null) {
                            aa.this.a(aa.this.G, str);
                        } else {
                            aa.this.o(aa.this.G);
                        }
                    } catch (Throwable unused) {
                    }
                }

                @Override // android.os.AsyncTask
                protected void onPreExecute() {
                }
            }.execute(chat.ola.vn.entity.i.l(this.G));
        } catch (Throwable unused) {
        }
    }

    public String a() {
        return this.F;
    }

    @SuppressLint({"NewApi"})
    public void a(String str) {
        this.z = (byte) 0;
        this.F = str;
        try {
            if (com.mg.ola.common.d.g.b()) {
                MediaMetadataRetriever mediaMetadataRetriever = new MediaMetadataRetriever();
                mediaMetadataRetriever.setDataSource(str);
                this.A = Long.valueOf(mediaMetadataRetriever.extractMetadata(9));
            }
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    public void a(String str, int i) {
        try {
            this.D = true;
            this.A = Long.valueOf(i);
            this.C.a(str);
        } catch (Throwable unused) {
        }
    }

    public void a(String str, int i, int i2) {
        try {
            this.D = false;
            this.A = Long.valueOf(i2);
            this.B = Long.valueOf(i);
            this.C.c(str, i, i2);
        } catch (Throwable unused) {
        }
    }

    @SuppressLint({"NewApi"})
    public void a(String str, String str2) {
        try {
            try {
                this.F = str2;
                if (com.mg.ola.common.d.g.b()) {
                    MediaMetadataRetriever mediaMetadataRetriever = new MediaMetadataRetriever();
                    mediaMetadataRetriever.setDataSource(this.F);
                    this.A = Long.valueOf(mediaMetadataRetriever.extractMetadata(9));
                }
            } catch (Throwable th) {
                th.printStackTrace();
            }
            this.C.a(str, str2);
        } catch (Throwable unused) {
        }
    }

    public void b(String str, int i, int i2) {
        try {
            this.A = Long.valueOf(i2);
            this.B = Long.valueOf(i);
            this.D = true;
            this.C.a(str, i, i2);
        } catch (Throwable unused) {
        }
    }

    public void b(String str, String str2) {
        try {
            this.C.b(str, str2);
        } catch (Throwable unused) {
        }
    }

    public void c(String str, int i, int i2) {
        try {
            this.A = Long.valueOf(i2);
            this.B = Long.valueOf(i);
            this.C.b(str, i, i2);
        } catch (Throwable unused) {
        }
    }

    public void d(String str, int i, int i2) {
        try {
            this.C.d(str, i, i2);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.message.d
    protected boolean h() {
        return false;
    }

    public void n(String str) {
        if (chat.ola.vn.util.m.a(this.G, str)) {
            return;
        }
        this.G = str;
        File file = new File(chat.ola.vn.d.l(), ".voice." + str + "." + this.l + ".tmp");
        String absolutePath = file.getAbsolutePath();
        if (file.exists()) {
            a(absolutePath);
        }
    }

    public void o(String str) {
        try {
            this.C.c(str);
        } catch (Throwable unused) {
        }
    }

    public void p(String str) {
        try {
            this.C.d(str);
        } catch (Throwable unused) {
        }
    }

    public void q(String str) {
        try {
            this.C.e(str);
        } catch (Throwable unused) {
        }
    }

    public void r(String str) {
        try {
            this.D = false;
            this.B = 0L;
            this.C.b(str);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.message.d
    public boolean w() {
        return true;
    }
}
