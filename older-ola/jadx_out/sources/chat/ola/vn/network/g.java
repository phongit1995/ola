package chat.ola.vn.network;

import java.io.InputStream;
import java.io.OutputStream;
import java.net.Socket;

/* JADX INFO: loaded from: classes.dex */
public class g {
    InputStream d;
    OutputStream e;
    Socket f;
    String a = null;
    String b = null;
    Long c = null;
    i g = null;

    public i a() {
        return this.g;
    }

    public void a(i iVar) {
        this.g = iVar;
    }

    public void a(Long l) {
        this.c = l;
    }

    public InputStream b() {
        return this.d;
    }

    public OutputStream c() {
        return this.e;
    }

    public String toString() {
        String str = "[IP " + this.b + "/" + this.a + "]";
        if (this.f != null) {
            str = str + " [Has Socket]";
        }
        if (this.d != null) {
            str = str + " [Has Input]";
        }
        if (this.e == null) {
            return str;
        }
        return str + " [Has OutPut]";
    }
}
