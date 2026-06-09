package chat.ola.vn.w;

import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;

/* JADX INFO: loaded from: classes.dex */
public class cg {
    public boolean a;
    private short c;
    private ByteArrayOutputStream d = new ByteArrayOutputStream(10260);
    private DataOutputStream b = new DataOutputStream(this.d);

    public cg(short s) {
        this.a = false;
        this.c = s;
        this.a = false;
    }

    private void a(String str) {
        try {
            byte[] bytes = str.getBytes();
            if (bytes == null || bytes.length == 0) {
                bytes = str.getBytes();
            }
            this.b.writeInt(bytes.length);
            this.b.write(bytes);
        } catch (Throwable unused) {
            byte[] bytes2 = str.getBytes();
            try {
                this.b.writeInt(bytes2.length);
                this.b.write(bytes2);
            } catch (Throwable unused2) {
            }
        }
    }

    private void a(byte[] bArr) {
        try {
            this.b.writeInt(bArr.length);
            this.b.write(bArr);
        } catch (Throwable unused) {
        }
    }

    public void a(short s, byte b) {
        a(s, new byte[]{b});
    }

    public void a(short s, int i) {
        a(s, chat.ola.vn.util.e.a(i));
    }

    public void a(short s, long j) {
        a(s, chat.ola.vn.util.e.a(j));
    }

    public void a(short s, String str) {
        if (chat.ola.vn.util.m.c(str)) {
            return;
        }
        try {
            this.b.write(s);
            a(str);
        } catch (Throwable unused) {
        }
    }

    public void a(short s, short s2) {
        a(s, chat.ola.vn.util.e.a(s2));
    }

    public void a(short s, byte[] bArr) {
        if (bArr != null) {
            try {
                if (bArr.length > 0) {
                    this.b.write(s);
                    a(bArr);
                }
            } catch (Throwable unused) {
            }
        }
    }

    public byte[] a() {
        try {
            try {
                this.b.flush();
            } finally {
                try {
                    this.d.close();
                    this.b.close();
                } catch (Throwable unused) {
                }
            }
        } catch (Throwable unused2) {
        }
        try {
            try {
                return this.d.toByteArray();
            } catch (Throwable unused3) {
                return null;
            }
        } catch (Throwable unused4) {
            this.d.close();
            this.b.close();
            return null;
        }
    }

    public short b() {
        return this.c;
    }
}
