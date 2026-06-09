package com.mg.ola.common.d;

import java.io.ByteArrayOutputStream;
import java.io.Closeable;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.Reader;
import java.io.StringWriter;
import java.io.Writer;
import java.nio.charset.Charset;

/* JADX INFO: loaded from: classes2.dex */
public class e {
    public static final char a = File.separatorChar;

    public static int a(InputStream inputStream, OutputStream outputStream) {
        long jB = b(inputStream, outputStream);
        if (jB > 2147483647L) {
            return -1;
        }
        return (int) jB;
    }

    public static int a(Reader reader, Writer writer) {
        long jB = b(reader, writer);
        if (jB > 2147483647L) {
            return -1;
        }
        return (int) jB;
    }

    public static long a(InputStream inputStream, OutputStream outputStream, byte[] bArr) throws IOException {
        long j = 0;
        while (true) {
            int i = inputStream.read(bArr);
            if (-1 == i) {
                return j;
            }
            outputStream.write(bArr, 0, i);
            j += (long) i;
        }
    }

    public static long a(Reader reader, Writer writer, char[] cArr) throws IOException {
        long j = 0;
        while (true) {
            int i = reader.read(cArr);
            if (-1 == i) {
                return j;
            }
            writer.write(cArr, 0, i);
            j += (long) i;
        }
    }

    public static String a(InputStream inputStream, Charset charset) {
        StringWriter stringWriter = new StringWriter();
        a(inputStream, stringWriter, charset);
        return stringWriter.toString();
    }

    public static void a(Closeable closeable) {
        if (closeable != null) {
            try {
                closeable.close();
            } catch (IOException unused) {
            }
        }
    }

    public static void a(InputStream inputStream) {
        a((Closeable) inputStream);
    }

    public static void a(InputStream inputStream, Writer writer, Charset charset) {
        a(new InputStreamReader(inputStream, a.a(charset)), writer);
    }

    public static void a(OutputStream outputStream) {
        a((Closeable) outputStream);
    }

    public static byte[] a(InputStream inputStream, int i) throws IOException {
        if (i < 0) {
            throw new IllegalArgumentException("Size must be equal or greater than zero: " + i);
        }
        int i2 = 0;
        if (i == 0) {
            return new byte[0];
        }
        byte[] bArr = new byte[i];
        while (i2 < i) {
            int i3 = inputStream.read(bArr, i2, i - i2);
            if (i3 == -1) {
                break;
            }
            i2 += i3;
        }
        if (i2 == i) {
            return bArr;
        }
        throw new IOException("Unexpected readed size. current: " + i2 + ", excepted: " + i);
    }

    public static byte[] a(InputStream inputStream, long j) {
        if (j <= 2147483647L) {
            return a(inputStream, (int) j);
        }
        throw new IllegalArgumentException("Size cannot be greater than Integer max value: " + j);
    }

    public static long b(InputStream inputStream, OutputStream outputStream) {
        return a(inputStream, outputStream, new byte[4096]);
    }

    public static long b(Reader reader, Writer writer) {
        return a(reader, writer, new char[4096]);
    }

    public static byte[] b(InputStream inputStream) {
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        a(inputStream, byteArrayOutputStream);
        return byteArrayOutputStream.toByteArray();
    }
}
