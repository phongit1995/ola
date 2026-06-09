package chat.ola.vn.util.b;

import android.os.AsyncTask;
import chat.ola.vn.OlaApplication;
import chat.ola.vn.R;
import chat.ola.vn.d;
import chat.ola.vn.entity.i;
import chat.ola.vn.h;
import chat.ola.vn.util.j;
import chat.ola.vn.util.l;
import chat.ola.vn.util.m;
import com.mg.ola.common.d.e;
import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

/* JADX INFO: loaded from: classes.dex */
public class c extends AsyncTask<String, Long, Void> {
    protected short a = -1;
    protected boolean b = false;
    private a c;

    private void a(final i iVar, boolean z) throws Throwable {
        BufferedInputStream bufferedInputStream;
        HttpURLConnection httpURLConnection;
        HttpURLConnection httpURLConnection2 = null;
        BufferedInputStream bufferedInputStream2 = null;
        httpURLConnection2 = null;
        httpURLConnection2 = null;
        try {
            try {
                try {
                    httpURLConnection = (HttpURLConnection) new URL(i.a(iVar, z)).openConnection();
                    try {
                        httpURLConnection.setInstanceFollowRedirects(false);
                        httpURLConnection.connect();
                        if (httpURLConnection.getResponseCode() != 302) {
                            bufferedInputStream = new BufferedInputStream(httpURLConnection.getInputStream());
                            try {
                                try {
                                    String strD = iVar.d();
                                    final String strI = iVar.i();
                                    if (m.a(strI)) {
                                        switch (iVar.f()) {
                                            case 1:
                                                strI = "jpg";
                                                break;
                                            case 2:
                                                strI = "mp4";
                                                break;
                                            case 3:
                                                strI = "mp3";
                                                break;
                                        }
                                    }
                                    final File fileB = d.b(strD, strI);
                                    int contentLength = httpURLConnection.getContentLength();
                                    long j = contentLength;
                                    if (com.mg.ola.common.d.c.h(fileB) == j && contentLength != 0) {
                                        try {
                                            this.a = (short) 0;
                                            this.c.a(fileB.getName(), strI, fileB.getAbsolutePath());
                                        } catch (Throwable unused) {
                                        }
                                        try {
                                            bufferedInputStream.close();
                                        } catch (Exception unused2) {
                                        }
                                        try {
                                            httpURLConnection.disconnect();
                                        } catch (Throwable unused3) {
                                        }
                                    }
                                    try {
                                        a(fileB, bufferedInputStream, 1024, j, false);
                                        if (iVar.f() == 1) {
                                            d.c(strD, fileB.getAbsolutePath());
                                        }
                                        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.util.b.c.3
                                            @Override // java.lang.Runnable
                                            public void run() {
                                                chat.ola.vn.c cVarC;
                                                Object[] objArr;
                                                switch (c.this.a) {
                                                    case 0:
                                                        c.this.c.a(fileB.getName(), strI, fileB.getAbsolutePath());
                                                        try {
                                                            switch (iVar.f()) {
                                                                case 1:
                                                                    l.a(OlaApplication.a(), fileB.getName(), fileB.getAbsolutePath(), strI);
                                                                    cVarC = chat.ola.vn.c.c();
                                                                    objArr = new Object[]{d.d};
                                                                    break;
                                                                case 2:
                                                                    l.b(OlaApplication.a(), fileB.getName(), fileB.getAbsolutePath(), strI);
                                                                    cVarC = chat.ola.vn.c.c();
                                                                    objArr = new Object[]{d.g};
                                                                    break;
                                                                case 3:
                                                                    l.a(OlaApplication.a(), fileB.getName(), fileB.getAbsolutePath(), strI, iVar.j());
                                                                    cVarC = chat.ola.vn.c.c();
                                                                    objArr = new Object[]{d.e};
                                                                    break;
                                                                default:
                                                                    return;
                                                            }
                                                            j.d(cVarC, R.string.message_download_image_ok, objArr);
                                                            return;
                                                        } catch (Throwable unused4) {
                                                            return;
                                                        }
                                                    case 1:
                                                        c.this.c.a();
                                                        break;
                                                    case 2:
                                                        c.this.c.d();
                                                        break;
                                                    default:
                                                        return;
                                                }
                                                com.mg.ola.common.d.c.c(fileB);
                                            }
                                        });
                                    } catch (Throwable unused4) {
                                    }
                                    bufferedInputStream2 = bufferedInputStream;
                                } catch (Throwable th) {
                                    th = th;
                                    httpURLConnection2 = httpURLConnection;
                                    th.printStackTrace();
                                    try {
                                        this.a = (short) 1;
                                        this.c.a();
                                    } catch (Throwable th2) {
                                        th2.printStackTrace();
                                    }
                                    try {
                                        httpURLConnection2.disconnect();
                                    } catch (Throwable unused5) {
                                    }
                                    bufferedInputStream.close();
                                    return;
                                }
                            } catch (FileNotFoundException unused6) {
                                httpURLConnection2 = httpURLConnection;
                                try {
                                    this.a = (short) 1;
                                    this.c.a();
                                } catch (Throwable th3) {
                                    th3.printStackTrace();
                                }
                                httpURLConnection2.disconnect();
                                bufferedInputStream.close();
                                return;
                            } catch (Throwable th4) {
                                th = th4;
                                try {
                                    httpURLConnection.disconnect();
                                } catch (Throwable unused7) {
                                }
                                try {
                                    bufferedInputStream.close();
                                    throw th;
                                } catch (Throwable unused8) {
                                    throw th;
                                }
                            }
                        } else {
                            OlaApplication.a(new Runnable() { // from class: chat.ola.vn.util.b.c.2
                                @Override // java.lang.Runnable
                                public void run() {
                                    try {
                                        c.this.a = (short) 1;
                                        c.this.c.b();
                                    } catch (Throwable unused9) {
                                    }
                                }
                            });
                        }
                        try {
                            httpURLConnection.disconnect();
                        } catch (Throwable unused9) {
                        }
                        bufferedInputStream2.close();
                    } catch (FileNotFoundException unused10) {
                        bufferedInputStream = null;
                    } catch (Throwable th5) {
                        th = th5;
                        bufferedInputStream = null;
                    }
                } catch (Throwable unused11) {
                }
            } catch (FileNotFoundException unused12) {
                bufferedInputStream = null;
            } catch (Throwable th6) {
                th = th6;
                bufferedInputStream = null;
            }
        } catch (Throwable th7) {
            th = th7;
            httpURLConnection = httpURLConnection2;
            httpURLConnection.disconnect();
            bufferedInputStream.close();
            throw th;
        }
    }

    private void a(File file, InputStream inputStream, int i, long j, boolean z) throws Throwable {
        Throwable th;
        FileOutputStream fileOutputStreamA;
        byte[] bArr;
        FileOutputStream fileOutputStream = null;
        try {
            try {
                fileOutputStreamA = a(file, z);
            } catch (Throwable unused) {
            }
        } catch (Throwable th2) {
            th = th2;
            fileOutputStreamA = fileOutputStream;
        }
        try {
            byte[] bArr2 = new byte[i];
            long j2 = 0;
            if (inputStream != null) {
                while (true) {
                    int i2 = inputStream.read(bArr2);
                    if (i2 <= 0) {
                        e.a((OutputStream) fileOutputStreamA);
                        this.a = (short) 0;
                        break;
                    }
                    if (this.b) {
                        com.mg.ola.common.d.c.c(file);
                        e.a((OutputStream) fileOutputStreamA);
                        this.a = (short) 2;
                        e.a((OutputStream) fileOutputStreamA);
                        return;
                    }
                    if (this.c != null) {
                        long j3 = j2 + ((long) i2);
                        publishProgress(Long.valueOf(j3), Long.valueOf(j));
                        j2 = j3;
                        bArr = bArr2;
                    } else {
                        bArr = bArr2;
                    }
                    fileOutputStreamA.write(bArr, 0, i2);
                    bArr2 = bArr;
                }
            }
            e.a((OutputStream) fileOutputStreamA);
        } catch (Throwable th3) {
            th = th3;
            e.a((OutputStream) fileOutputStreamA);
            throw th;
        }
    }

    public c a(a aVar) {
        this.c = aVar;
        return this;
    }

    public FileOutputStream a(File file, boolean z) throws IOException {
        if (!file.exists()) {
            File parentFile = file.getParentFile();
            if (parentFile != null && !parentFile.mkdirs() && !parentFile.isDirectory()) {
                throw new IOException("Directory '" + parentFile + "' could not be created");
            }
        } else {
            if (file.isDirectory()) {
                throw new IOException("File '" + file + "' exists but is a directory");
            }
            if (!file.canWrite()) {
                throw new IOException("File '" + file + "' cannot be written to");
            }
        }
        return new FileOutputStream(file, z);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // android.os.AsyncTask
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public Void doInBackground(String... strArr) {
        String str = strArr[0];
        try {
            i iVar = new i();
            iVar.a(str);
            String strA = h.a();
            String strJ = iVar.j();
            final String strI = iVar.i();
            if (m.a(strI)) {
                switch (iVar.f()) {
                    case 1:
                        strI = "jpg";
                        break;
                    case 2:
                        strI = "mp4";
                        break;
                    case 3:
                        strI = "mp3";
                        break;
                }
            }
            final File fileB = d.b(str, strI);
            if (fileB.exists()) {
                OlaApplication.a(new Runnable() { // from class: chat.ola.vn.util.b.c.1
                    @Override // java.lang.Runnable
                    public void run() {
                        try {
                            c.this.c.a(fileB.getName(), strI, fileB.getAbsolutePath());
                        } catch (Throwable unused) {
                        }
                    }
                });
                return null;
            }
            if (m.b(strA, strJ)) {
                a(iVar, false);
                return null;
            }
            a(iVar, true);
            return null;
        } catch (Throwable unused) {
            return null;
        }
    }

    public void a() {
        this.b = true;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // android.os.AsyncTask
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public final void onPostExecute(Void r1) {
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // android.os.AsyncTask
    /* JADX INFO: renamed from: a, reason: merged with bridge method [inline-methods] */
    public void onProgressUpdate(Long... lArr) {
        if (this.c != null) {
            this.c.a(lArr[0].longValue(), lArr[1].longValue());
        }
    }

    @Override // android.os.AsyncTask
    public void onPreExecute() {
        try {
            this.c.c();
        } catch (Throwable unused) {
        }
    }
}
