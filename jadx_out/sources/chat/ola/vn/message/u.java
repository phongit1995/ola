package chat.ola.vn.message;

import android.content.Context;

/* JADX INFO: loaded from: classes.dex */
public abstract class u extends f {
    protected String Z;
    protected String aa;
    protected String ab;
    protected String ac;
    protected int ad;

    public u(String str) {
        super(str, (short) 5);
        this.ad = 0;
    }

    public String Y() {
        return this.Z;
    }

    public String Z() {
        return this.aa;
    }

    public boolean a(Context context) {
        return false;
    }

    public String aa() {
        return this.ab;
    }

    public String ab() {
        return this.ac;
    }

    public int ac() {
        return this.ad;
    }
}
