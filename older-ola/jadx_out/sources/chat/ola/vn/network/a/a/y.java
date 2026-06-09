package chat.ola.vn.network.a.a;

import java.util.List;

/* JADX INFO: loaded from: classes.dex */
public class y extends chat.ola.vn.entity.m<List<chat.ola.vn.entity.p>> {
    private chat.ola.vn.p.q c;
    private String d;
    private String e;
    private boolean f;

    public y(String str, String str2, boolean z, long j) {
        super(j);
        this.d = str2;
        this.e = str;
        this.f = z;
    }

    /* JADX WARN: Removed duplicated region for block: B:24:0x0063  */
    /* JADX WARN: Removed duplicated region for block: B:26:0x006b  */
    @Override // chat.ola.vn.entity.m
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public java.lang.String a() {
        /*
            r4 = this;
            java.util.HashMap r0 = new java.util.HashMap
            r0.<init>()
            java.lang.String r1 = r4.e
            boolean r1 = chat.ola.vn.util.m.a(r1)
            if (r1 != 0) goto L14
            java.lang.String r1 = "packageName"
            java.lang.String r2 = r4.e
            r0.put(r1, r2)
        L14:
            java.util.Locale r1 = java.util.Locale.getDefault()     // Catch: java.lang.Throwable -> L50
            java.lang.String r1 = r1.getLanguage()     // Catch: java.lang.Throwable -> L50
            java.lang.String r2 = chat.ola.vn.c.x.i()     // Catch: java.lang.Throwable -> L50
            java.lang.String r3 = "vi"
            boolean r3 = chat.ola.vn.util.m.b(r2, r3)     // Catch: java.lang.Throwable -> L50
            if (r3 == 0) goto L30
            java.lang.String r1 = "country"
        L2a:
            java.lang.String r2 = "vn"
        L2c:
            r0.put(r1, r2)     // Catch: java.lang.Throwable -> L50
            goto L5f
        L30:
            java.lang.String r3 = "default"
            boolean r2 = chat.ola.vn.util.m.b(r2, r3)     // Catch: java.lang.Throwable -> L50
            if (r2 == 0) goto L43
            java.lang.String r2 = "vi"
            boolean r1 = chat.ola.vn.util.m.b(r1, r2)     // Catch: java.lang.Throwable -> L50
            if (r1 == 0) goto L43
            java.lang.String r1 = "country"
            goto L2a
        L43:
            java.lang.String r1 = r4.d     // Catch: java.lang.Throwable -> L50
            boolean r1 = chat.ola.vn.util.m.a(r1)     // Catch: java.lang.Throwable -> L50
            if (r1 != 0) goto L5f
            java.lang.String r1 = "country"
            java.lang.String r2 = r4.d     // Catch: java.lang.Throwable -> L50
            goto L2c
        L50:
            java.lang.String r1 = r4.d
            boolean r1 = chat.ola.vn.util.m.a(r1)
            if (r1 != 0) goto L5f
            java.lang.String r1 = "country"
            java.lang.String r2 = r4.d
            r0.put(r1, r2)
        L5f:
            boolean r1 = r4.f
            if (r1 == 0) goto L6b
            java.lang.String r1 = "simAvailable"
            java.lang.String r2 = "true"
        L67:
            r0.put(r1, r2)
            goto L70
        L6b:
            java.lang.String r1 = "simAvailable"
            java.lang.String r2 = "false"
            goto L67
        L70:
            java.lang.String r1 = chat.ola.vn.h.f()
            java.lang.String r2 = "pay/ginapp/request"
            r3 = 1
            java.lang.String r0 = chat.ola.vn.util.http.a.a(r1, r2, r0, r3)
            return r0
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.network.a.a.y.a():java.lang.String");
    }

    public void a(chat.ola.vn.p.q qVar) {
        this.c = qVar;
    }

    @Override // chat.ola.vn.entity.m
    public void a(List<chat.ola.vn.entity.p> list) {
        if (list == null) {
            b((String) null);
        } else {
            try {
                this.c.a(list);
            } catch (Throwable unused) {
            }
        }
    }

    /* JADX WARN: Removed duplicated region for block: B:23:0x009b  */
    /* JADX WARN: Removed duplicated region for block: B:26:0x00a4 A[Catch: Throwable -> 0x0160, TryCatch #0 {Throwable -> 0x0160, blocks: (B:19:0x0057, B:21:0x008f, B:22:0x0095, B:24:0x009c, B:26:0x00a4, B:28:0x00b2, B:30:0x00ba, B:32:0x00c2, B:34:0x00cf, B:36:0x00f7, B:37:0x00fd, B:38:0x0103, B:40:0x010b, B:42:0x0119, B:43:0x011f, B:45:0x0127, B:47:0x0133, B:49:0x0154, B:50:0x015a), top: B:58:0x0057 }] */
    /* JADX WARN: Removed duplicated region for block: B:40:0x010b A[Catch: Throwable -> 0x0160, TryCatch #0 {Throwable -> 0x0160, blocks: (B:19:0x0057, B:21:0x008f, B:22:0x0095, B:24:0x009c, B:26:0x00a4, B:28:0x00b2, B:30:0x00ba, B:32:0x00c2, B:34:0x00cf, B:36:0x00f7, B:37:0x00fd, B:38:0x0103, B:40:0x010b, B:42:0x0119, B:43:0x011f, B:45:0x0127, B:47:0x0133, B:49:0x0154, B:50:0x015a), top: B:58:0x0057 }] */
    @Override // chat.ola.vn.entity.m
    /* JADX INFO: renamed from: b, reason: merged with bridge method [inline-methods] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public java.util.List<chat.ola.vn.entity.p> a(byte[] r11) {
        /*
            Method dump skipped, instruction units count: 386
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.network.a.a.y.a(byte[]):java.util.List");
    }

    @Override // chat.ola.vn.entity.m
    public void b(String str) {
        try {
            this.c.a();
        } catch (Throwable unused) {
        }
    }
}
