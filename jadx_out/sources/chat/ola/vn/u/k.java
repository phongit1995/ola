package chat.ola.vn.u;

/* JADX INFO: loaded from: classes.dex */
class k {
    static a[] a = new a[5];

    static {
        a[0] = new f();
        a[1] = new i();
        a[2] = new l();
        a[3] = new c();
        a[4] = new j();
    }

    public static a a(short s) {
        if (s < 0 || s >= a.length) {
            return null;
        }
        return a[s];
    }
}
