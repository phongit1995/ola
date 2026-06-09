package chat.ola.vn.message;

import android.location.Address;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class k extends d {
    private String A;
    private List<Address> B;
    private String z;

    public k(d dVar, byte b) {
        super(dVar, b, (byte) 5);
        this.B = null;
    }

    public String C() {
        return this.A;
    }

    public List<Address> D() {
        return this.B;
    }

    public String a() {
        return this.z;
    }

    public void a(String str) {
        this.z = str;
    }

    public void b(List<Address> list) {
        this.B = list;
    }

    @Override // chat.ola.vn.message.d
    public boolean b() {
        return false;
    }

    public void n(String str) {
        this.A = str;
    }
}
