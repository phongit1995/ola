package com.mg.ola.common.d;

import android.content.Context;
import android.graphics.Bitmap;
import android.net.Uri;
import java.io.Closeable;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.channels.FileChannel;

/* JADX INFO: loaded from: classes2.dex */
public class c {
    public static File a(Context context, Uri uri, String str) {
        try {
            InputStream inputStreamOpenInputStream = context.getContentResolver().openInputStream(uri);
            File file = new File(str);
            if (!file.exists()) {
                file.createNewFile();
            }
            FileOutputStream fileOutputStream = new FileOutputStream(file);
            try {
                byte[] bArr = new byte[2048];
                while (true) {
                    int i = inputStreamOpenInputStream.read(bArr);
                    if (i == -1) {
                        break;
                    }
                    fileOutputStream.write(bArr, 0, i);
                }
            } catch (Throwable unused) {
            }
            inputStreamOpenInputStream.close();
            fileOutputStream.close();
            return file;
        } catch (Throwable unused2) {
            return null;
        }
    }

    public static FileOutputStream a(File file, boolean z) throws IOException {
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

    public static void a(Bitmap bitmap, File file) throws IOException {
        a(bitmap, file, Bitmap.CompressFormat.JPEG, 100);
    }

    public static void a(Bitmap bitmap, File file, Bitmap.CompressFormat compressFormat, int i) throws IOException {
        if (!file.exists()) {
            file.createNewFile();
        }
        FileOutputStream fileOutputStream = new FileOutputStream(file);
        bitmap.compress(compressFormat, i, fileOutputStream);
        fileOutputStream.flush();
        fileOutputStream.close();
    }

    public static void a(File file, File file2) throws Throwable {
        a(file, file2, true);
    }

    public static void a(File file, File file2, boolean z) throws Throwable {
        if (file == null) {
            throw new NullPointerException("Source must not be null");
        }
        if (file2 == null) {
            throw new NullPointerException("Destination must not be null");
        }
        if (!file.exists()) {
            throw new FileNotFoundException("Source '" + file + "' does not exist");
        }
        if (file.isDirectory()) {
            throw new IOException("Source '" + file + "' exists but is a directory");
        }
        if (file.getCanonicalPath().equals(file2.getCanonicalPath())) {
            throw new IOException("Source '" + file + "' and destination '" + file2 + "' are the same");
        }
        File parentFile = file2.getParentFile();
        if (parentFile != null && !parentFile.mkdirs() && !parentFile.isDirectory()) {
            throw new IOException("Destination '" + parentFile + "' directory cannot be created");
        }
        if (!file2.exists() || file2.canWrite()) {
            b(file, file2, z);
            return;
        }
        throw new IOException("Destination '" + file2 + "' exists but is read-only");
    }

    public static void a(File file, byte[] bArr) throws Throwable {
        a(file, bArr, false);
    }

    public static void a(File file, byte[] bArr, boolean z) throws Throwable {
        FileOutputStream fileOutputStreamA;
        try {
            fileOutputStreamA = a(file, z);
        } catch (Throwable th) {
            th = th;
            fileOutputStreamA = null;
        }
        try {
            fileOutputStreamA.write(bArr);
            fileOutputStreamA.close();
            e.a((OutputStream) fileOutputStreamA);
        } catch (Throwable th2) {
            th = th2;
            e.a((OutputStream) fileOutputStreamA);
            throw th;
        }
    }

    public static boolean a(String str) {
        try {
            return new File(str).exists();
        } catch (Throwable unused) {
            return false;
        }
    }

    public static byte[] a(File file) throws Throwable {
        FileInputStream fileInputStreamB;
        try {
            fileInputStreamB = b(file);
            try {
                byte[] bArrA = e.a(fileInputStreamB, file.length());
                e.a((InputStream) fileInputStreamB);
                return bArrA;
            } catch (Throwable th) {
                th = th;
                e.a((InputStream) fileInputStreamB);
                throw th;
            }
        } catch (Throwable th2) {
            th = th2;
            fileInputStreamB = null;
        }
    }

    public static FileInputStream b(File file) throws IOException {
        if (!file.exists()) {
            throw new FileNotFoundException("File '" + file + "' does not exist");
        }
        if (file.isDirectory()) {
            throw new IOException("File '" + file + "' exists but is a directory");
        }
        if (file.canRead()) {
            return new FileInputStream(file);
        }
        throw new IOException("File '" + file + "' cannot be read");
    }

    public static void b(Bitmap bitmap, File file) throws IOException {
        a(bitmap, file, Bitmap.CompressFormat.PNG, 100);
    }

    private static void b(File file, File file2, boolean z) throws Throwable {
        Throwable th;
        FileInputStream fileInputStream;
        FileOutputStream fileOutputStream;
        Closeable closeable;
        if (file2.exists() && file2.isDirectory()) {
            throw new IOException("Destination '" + file2 + "' exists but is a directory");
        }
        FileChannel fileChannel = null;
        fileChannel = null;
        fileChannel = null;
        try {
            fileInputStream = new FileInputStream(file);
            try {
                fileOutputStream = new FileOutputStream(file2);
                try {
                    FileChannel channel = fileInputStream.getChannel();
                    try {
                        FileChannel channel2 = fileOutputStream.getChannel();
                        try {
                            long size = channel.size();
                            long jTransferFrom = 0;
                            while (jTransferFrom < size) {
                                long j = size - jTransferFrom;
                                jTransferFrom += channel2.transferFrom(channel, jTransferFrom, j > 31457280 ? 31457280L : j);
                            }
                            e.a(channel2);
                            e.a((OutputStream) fileOutputStream);
                            e.a(channel);
                            e.a((InputStream) fileInputStream);
                            if (file.length() == file2.length()) {
                                if (z) {
                                    file2.setLastModified(file.lastModified());
                                }
                            } else {
                                throw new IOException("Failed to copy full contents from '" + file + "' to '" + file2 + "'");
                            }
                        } catch (Throwable th2) {
                            th = th2;
                            fileChannel = channel2;
                            closeable = channel;
                            e.a(fileChannel);
                            e.a((OutputStream) fileOutputStream);
                            e.a(closeable);
                            e.a((InputStream) fileInputStream);
                            throw th;
                        }
                    } catch (Throwable th3) {
                        th = th3;
                        closeable = channel;
                    }
                } catch (Throwable th4) {
                    th = th4;
                    closeable = null;
                }
            } catch (Throwable th5) {
                th = th5;
                fileOutputStream = null;
                closeable = fileOutputStream;
                e.a(fileChannel);
                e.a((OutputStream) fileOutputStream);
                e.a(closeable);
                e.a((InputStream) fileInputStream);
                throw th;
            }
        } catch (Throwable th6) {
            th = th6;
            fileInputStream = null;
            fileOutputStream = null;
        }
    }

    public static boolean b(String str) {
        try {
            File file = new File(str);
            if (file.isDirectory()) {
                return !file.isHidden();
            }
            return false;
        } catch (Throwable unused) {
            return false;
        }
    }

    public static boolean c(File file) {
        if (file == null) {
            return false;
        }
        try {
            if (file.isDirectory()) {
                d(file);
            }
            return file.delete();
        } catch (Throwable unused) {
            return false;
        }
    }

    public static File[] c(String str) {
        try {
            File file = new File(str);
            if (file.isDirectory()) {
                return file.listFiles();
            }
            return null;
        } catch (Throwable unused) {
            return null;
        }
    }

    public static void d(File file) throws IOException {
        if (!file.exists()) {
            throw new IllegalArgumentException(file + " does not exist");
        }
        if (!file.isDirectory()) {
            throw new IllegalArgumentException(file + " is not a directory");
        }
        File[] fileArrListFiles = file.listFiles();
        if (fileArrListFiles == null) {
            throw new IOException("Failed to list contents of " + file);
        }
        IOException e = null;
        for (File file2 : fileArrListFiles) {
            try {
                e(file2);
            } catch (IOException e2) {
                e = e2;
            }
        }
        if (e != null) {
            throw e;
        }
    }

    public static void e(File file) throws IOException {
        if (file.isDirectory()) {
            f(file);
            return;
        }
        boolean zExists = file.exists();
        if (file.delete()) {
            return;
        }
        if (zExists) {
            throw new IOException("Unable to delete file: " + file);
        }
        throw new FileNotFoundException("File does not exist: " + file);
    }

    public static void f(File file) throws IOException {
        if (file.exists()) {
            if (!g(file)) {
                d(file);
            }
            if (file.delete()) {
                return;
            }
            throw new IOException("Unable to delete directory " + file + ".");
        }
    }

    public static boolean g(File file) {
        if (file == null) {
            throw new NullPointerException("File must not be null");
        }
        if (d.a()) {
            return false;
        }
        if (file.getParent() != null) {
            file = new File(file.getParentFile().getCanonicalFile(), file.getName());
        }
        return !file.getCanonicalFile().equals(file.getAbsoluteFile());
    }

    public static long h(File file) {
        try {
            if (file.exists()) {
                return file.isDirectory() ? i(file) : file.length();
            }
            return 0L;
        } catch (Throwable unused) {
            return 0L;
        }
    }

    public static long i(File file) {
        j(file);
        File[] fileArrListFiles = file.listFiles();
        if (fileArrListFiles == null) {
            return 0L;
        }
        long j = 0;
        for (File file2 : fileArrListFiles) {
            try {
                if (g(file2)) {
                    continue;
                } else {
                    long jH = j + h(file2);
                    if (jH < 0) {
                        return jH;
                    }
                    j = jH;
                }
            } catch (IOException unused) {
            }
        }
        return j;
    }

    private static void j(File file) {
        if (!file.exists()) {
            throw new IllegalArgumentException(file + " does not exist");
        }
        if (file.isDirectory()) {
            return;
        }
        throw new IllegalArgumentException(file + " is not a directory");
    }
}
