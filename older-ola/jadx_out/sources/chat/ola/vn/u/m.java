package chat.ola.vn.u;

import chat.ola.vn.OlaApplication;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.List;

/* JADX INFO: loaded from: classes.dex */
class m implements g {
    String b;
    String c;
    p d;
    d a = null;
    String e = null;
    String f = null;
    int g = 20480;
    int h = 0;
    int i = 0;
    InputStream j = null;
    boolean k = false;

    m() {
    }

    private void a(final int i, final int i2) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.u.m.8
            @Override // java.lang.Runnable
            public void run() {
                try {
                    if (i2 > 0) {
                        m.this.d.c().a(i, i2);
                    }
                } catch (Throwable unused) {
                }
            }
        });
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX WARN: Removed duplicated region for block: B:44:0x013d A[Catch: Throwable -> 0x0196, TryCatch #1 {Throwable -> 0x0196, blocks: (B:42:0x012e, B:44:0x013d, B:45:0x0141, B:47:0x014d, B:49:0x0159, B:50:0x015b, B:52:0x0161, B:53:0x0165, B:55:0x016b, B:57:0x0183, B:59:0x018c, B:58:0x0188, B:46:0x0144, B:40:0x012b), top: B:66:0x012b }] */
    /* JADX WARN: Removed duplicated region for block: B:46:0x0144 A[Catch: Throwable -> 0x0196, TryCatch #1 {Throwable -> 0x0196, blocks: (B:42:0x012e, B:44:0x013d, B:45:0x0141, B:47:0x014d, B:49:0x0159, B:50:0x015b, B:52:0x0161, B:53:0x0165, B:55:0x016b, B:57:0x0183, B:59:0x018c, B:58:0x0188, B:46:0x0144, B:40:0x012b), top: B:66:0x012b }] */
    /* JADX WARN: Removed duplicated region for block: B:49:0x0159 A[Catch: Throwable -> 0x0196, TryCatch #1 {Throwable -> 0x0196, blocks: (B:42:0x012e, B:44:0x013d, B:45:0x0141, B:47:0x014d, B:49:0x0159, B:50:0x015b, B:52:0x0161, B:53:0x0165, B:55:0x016b, B:57:0x0183, B:59:0x018c, B:58:0x0188, B:46:0x0144, B:40:0x012b), top: B:66:0x012b }] */
    /* JADX WARN: Removed duplicated region for block: B:52:0x0161 A[Catch: Throwable -> 0x0196, TryCatch #1 {Throwable -> 0x0196, blocks: (B:42:0x012e, B:44:0x013d, B:45:0x0141, B:47:0x014d, B:49:0x0159, B:50:0x015b, B:52:0x0161, B:53:0x0165, B:55:0x016b, B:57:0x0183, B:59:0x018c, B:58:0x0188, B:46:0x0144, B:40:0x012b), top: B:66:0x012b }] */
    /* JADX WARN: Removed duplicated region for block: B:55:0x016b A[Catch: Throwable -> 0x0196, TryCatch #1 {Throwable -> 0x0196, blocks: (B:42:0x012e, B:44:0x013d, B:45:0x0141, B:47:0x014d, B:49:0x0159, B:50:0x015b, B:52:0x0161, B:53:0x0165, B:55:0x016b, B:57:0x0183, B:59:0x018c, B:58:0x0188, B:46:0x0144, B:40:0x012b), top: B:66:0x012b }] */
    /* JADX WARN: Removed duplicated region for block: B:57:0x0183 A[Catch: Throwable -> 0x0196, TryCatch #1 {Throwable -> 0x0196, blocks: (B:42:0x012e, B:44:0x013d, B:45:0x0141, B:47:0x014d, B:49:0x0159, B:50:0x015b, B:52:0x0161, B:53:0x0165, B:55:0x016b, B:57:0x0183, B:59:0x018c, B:58:0x0188, B:46:0x0144, B:40:0x012b), top: B:66:0x012b }] */
    /* JADX WARN: Removed duplicated region for block: B:58:0x0188 A[Catch: Throwable -> 0x0196, TryCatch #1 {Throwable -> 0x0196, blocks: (B:42:0x012e, B:44:0x013d, B:45:0x0141, B:47:0x014d, B:49:0x0159, B:50:0x015b, B:52:0x0161, B:53:0x0165, B:55:0x016b, B:57:0x0183, B:59:0x018c, B:58:0x0188, B:46:0x0144, B:40:0x012b), top: B:66:0x012b }] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public void a(int r18, java.lang.String r19, int r20, java.lang.String r21, java.lang.String r22, boolean r23, java.lang.String r24) {
        /*
            Method dump skipped, instruction units count: 410
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: chat.ola.vn.u.m.a(int, java.lang.String, int, java.lang.String, java.lang.String, boolean, java.lang.String):void");
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void a(String str, int i, byte[] bArr) {
        e eVar = new e((short) 2);
        eVar.c = str;
        eVar.i = i;
        eVar.l = bArr;
        this.a.a(eVar);
    }

    private void a(final List<Integer> list, final Integer num) {
        try {
            chat.ola.vn.h.e().execute(new Runnable() { // from class: chat.ola.vn.u.m.6
                @Override // java.lang.Runnable
                public void run() {
                    m mVar;
                    InputStream byteArrayInputStream;
                    try {
                        try {
                            try {
                                try {
                                    if (m.this.j == null) {
                                        if (m.this.d.a() != null) {
                                            if (chat.ola.vn.util.m.a(m.this.f)) {
                                                mVar = m.this;
                                                byteArrayInputStream = new FileInputStream(new File(m.this.e));
                                            } else {
                                                mVar = m.this;
                                                byteArrayInputStream = new FileInputStream(new File(m.this.f));
                                            }
                                        } else if (m.this.d.b() != null) {
                                            mVar = m.this;
                                            byteArrayInputStream = new ByteArrayInputStream(m.this.d.b());
                                        }
                                        mVar.j = byteArrayInputStream;
                                    }
                                    List list2 = list;
                                    Integer num2 = num;
                                    Integer numValueOf = 0;
                                    boolean z = false;
                                    Integer numValueOf2 = null;
                                    while (!m.this.k) {
                                        if (list2 != null && !list2.isEmpty()) {
                                            numValueOf2 = (Integer) list2.remove(0);
                                            if (list2.isEmpty()) {
                                                list2 = null;
                                            }
                                        } else if (num2 == null) {
                                            if (numValueOf2 == null || !z) {
                                                break;
                                            } else {
                                                numValueOf2 = Integer.valueOf(numValueOf2.intValue() + 1);
                                            }
                                        } else {
                                            numValueOf2 = num2;
                                            z = true;
                                            num2 = null;
                                        }
                                        byte[] bArr = new byte[m.this.g];
                                        int iIntValue = m.this.g * (numValueOf2.intValue() - numValueOf.intValue());
                                        if (iIntValue > 0) {
                                            m.this.j.skip(iIntValue);
                                        }
                                        int i = m.this.j.read(bArr, 0, m.this.g);
                                        if (i < 0) {
                                            break;
                                        }
                                        if (i > 0) {
                                            numValueOf = Integer.valueOf(numValueOf2.intValue() + 1);
                                            ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
                                            byteArrayOutputStream.write(bArr, 0, i);
                                            m.this.a(m.this.b, numValueOf2.intValue(), byteArrayOutputStream.toByteArray());
                                        }
                                    }
                                    m.this.j.close();
                                } catch (Throwable unused) {
                                    m.this.j.close();
                                    m.this.j = null;
                                }
                            } catch (Throwable th) {
                                try {
                                    m.this.j.close();
                                    m.this.j = null;
                                } catch (Throwable unused2) {
                                }
                                throw th;
                            }
                        } catch (Throwable unused3) {
                            m.this.e();
                            m.this.j.close();
                            m.this.j = null;
                        }
                        m.this.j = null;
                    } catch (Throwable unused4) {
                    }
                }
            });
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    private void b(final String str) {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.u.m.10
            @Override // java.lang.Runnable
            public void run() {
                try {
                    m.this.d.c().a(m.this.e, str);
                } catch (Throwable unused) {
                }
            }
        });
    }

    private void d() {
        try {
            chat.ola.vn.h.e().execute(new Runnable() { // from class: chat.ola.vn.u.m.5
                @Override // java.lang.Runnable
                public void run() {
                    byte[] bArr;
                    int i;
                    m mVar;
                    InputStream byteArrayInputStream;
                    try {
                        try {
                            try {
                                try {
                                    if (m.this.j == null) {
                                        if (m.this.d.a() != null) {
                                            if (chat.ola.vn.util.m.a(m.this.f)) {
                                                mVar = m.this;
                                                byteArrayInputStream = new FileInputStream(new File(m.this.e));
                                            } else {
                                                mVar = m.this;
                                                byteArrayInputStream = new FileInputStream(new File(m.this.f));
                                            }
                                        } else if (m.this.d.b() != null) {
                                            mVar = m.this;
                                            byteArrayInputStream = new ByteArrayInputStream(m.this.d.b());
                                        }
                                        mVar.j = byteArrayInputStream;
                                    }
                                    int i2 = 0;
                                    while (!m.this.k && (i = m.this.j.read((bArr = new byte[m.this.g]), 0, m.this.g)) >= 0) {
                                        if (i > 0) {
                                            ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
                                            byteArrayOutputStream.write(bArr, 0, i);
                                            m.this.a(m.this.b, i2, byteArrayOutputStream.toByteArray());
                                            i2++;
                                        }
                                    }
                                    m.this.j.close();
                                } catch (Throwable unused) {
                                    m.this.e();
                                    m.this.j.close();
                                    m.this.j = null;
                                }
                            } catch (Throwable unused2) {
                                m.this.j.close();
                                m.this.j = null;
                            }
                            m.this.j = null;
                        } catch (Throwable th) {
                            try {
                                m.this.j.close();
                                m.this.j = null;
                            } catch (Throwable unused3) {
                            }
                            throw th;
                        }
                    } catch (Throwable unused4) {
                    }
                }
            });
        } catch (Throwable th) {
            th.printStackTrace();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void e() {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.u.m.7
            @Override // java.lang.Runnable
            public void run() {
                try {
                    m.this.d.c().a(m.this.e);
                } catch (Throwable unused) {
                }
            }
        });
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void f() {
        OlaApplication.a(new Runnable() { // from class: chat.ola.vn.u.m.9
            @Override // java.lang.Runnable
            public void run() {
                try {
                    m.this.d.c().b(m.this.e, null);
                } catch (Throwable unused) {
                }
            }
        });
    }

    private void g() {
        this.a.a(this.c);
    }

    @Override // chat.ola.vn.u.g
    public void a() {
        try {
            f();
        } catch (Throwable unused) {
        }
        try {
            g();
        } catch (Throwable unused2) {
        }
    }

    public void a(final int i) {
        try {
            OlaApplication.a(new Runnable() { // from class: chat.ola.vn.u.m.3
                @Override // java.lang.Runnable
                public void run() {
                    try {
                        m.this.d.c().a(m.this.e, i);
                    } catch (Throwable unused) {
                    }
                }
            });
        } catch (Throwable unused) {
        }
        try {
            g();
        } catch (Throwable unused2) {
        }
    }

    public void a(p pVar) {
        this.d = pVar;
        pVar.a = this;
        this.c = "" + System.nanoTime();
        this.g = chat.ola.vn.h.I ? 20480 : chat.ola.vn.h.J ? 10240 : 3072;
        this.e = null;
        if (this.d.a() != null) {
            this.e = this.d.a();
            this.h = (int) com.mg.ola.common.d.c.h(new File(this.e));
        } else if (this.d.b() != null) {
            this.h = this.d.b().length;
            this.e = null;
        }
        if (chat.ola.vn.util.m.a(this.d.d())) {
            b((String) null);
            return;
        }
        a(0, this.h);
        try {
            chat.ola.vn.h.e().execute(new Runnable() { // from class: chat.ola.vn.u.m.1
                @Override // java.lang.Runnable
                public void run() {
                    try {
                        m.this.a = d.d();
                        m.this.a.a(m.this);
                        m.this.a(m.this.h, m.this.e, m.this.g, m.this.d.d(), m.this.c, m.this.d.b, m.this.d.e());
                    } catch (Throwable th) {
                        th.printStackTrace();
                        m.this.f();
                    }
                }
            });
        } catch (Throwable th) {
            th.printStackTrace();
            f();
        }
    }

    @Override // chat.ola.vn.u.g
    public void a(String str) {
        if (chat.ola.vn.util.m.b(str, this.b)) {
            try {
                this.i += this.g;
                a(this.i, this.h);
            } catch (Throwable unused) {
            }
        }
    }

    @Override // chat.ola.vn.u.g
    public void a(String str, final int i, final String str2) {
        try {
            if (chat.ola.vn.util.m.b(str, this.c)) {
                try {
                    OlaApplication.a(new Runnable() { // from class: chat.ola.vn.u.m.4
                        @Override // java.lang.Runnable
                        public void run() {
                            try {
                                m.this.d.c().a(m.this.e, i, str2);
                            } catch (Throwable unused) {
                            }
                        }
                    });
                } catch (Throwable unused) {
                }
                g();
            }
        } catch (Throwable unused2) {
        }
    }

    @Override // chat.ola.vn.u.g
    public void a(String str, String str2) {
        try {
            if (chat.ola.vn.util.m.b(str, this.b)) {
                final chat.ola.vn.entity.i iVar = new chat.ola.vn.entity.i();
                iVar.a(str2);
                chat.ola.vn.d.c(str2, this.e);
                try {
                    final o oVarC = this.d.c();
                    this.d.a(null);
                    this.d = null;
                    OlaApplication.a(new Runnable() { // from class: chat.ola.vn.u.m.11
                        @Override // java.lang.Runnable
                        public void run() {
                            try {
                                oVarC.a(iVar);
                            } catch (Throwable unused) {
                            }
                        }
                    });
                } catch (Throwable unused) {
                }
                g();
            }
        } catch (Throwable unused2) {
        }
    }

    @Override // chat.ola.vn.u.g
    public void a(String str, String str2, int i, int i2, List<Integer> list, Integer num) {
        if (chat.ola.vn.util.m.b(str, this.c)) {
            this.b = str2;
            this.g = i;
            this.i = i * i2;
            a(this.i, this.h);
            a(list, num);
        }
    }

    public void a(boolean z) {
        this.k = z;
        if (z) {
            this.i = 0;
        }
    }

    @Override // chat.ola.vn.u.g
    public String b() {
        return this.c;
    }

    @Override // chat.ola.vn.u.g
    public void b(String str, String str2) {
        if (chat.ola.vn.util.m.b(str, this.c)) {
            this.b = str2;
            d();
        }
    }

    @Override // chat.ola.vn.u.g
    public String c() {
        return this.b;
    }

    @Override // chat.ola.vn.u.g
    public void c(String str, final String str2) {
        try {
            if (chat.ola.vn.util.m.b(str, this.b)) {
                try {
                    OlaApplication.a(new Runnable() { // from class: chat.ola.vn.u.m.12
                        @Override // java.lang.Runnable
                        public void run() {
                            try {
                                m.this.d.c().b(m.this.e, str2);
                            } catch (Throwable unused) {
                            }
                        }
                    });
                } catch (Throwable unused) {
                }
                g();
            }
        } catch (Throwable unused2) {
        }
    }

    @Override // chat.ola.vn.u.g
    public void d(String str, String str2) {
        try {
            if (chat.ola.vn.util.m.b(str, this.c)) {
                b(str2);
                g();
            }
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.u.g
    public void e(String str, final String str2) {
        try {
            if (chat.ola.vn.util.m.b(str, this.c)) {
                try {
                    OlaApplication.a(new Runnable() { // from class: chat.ola.vn.u.m.2
                        @Override // java.lang.Runnable
                        public void run() {
                            try {
                                m.this.d.c().b(m.this.e, str2);
                            } catch (Throwable unused) {
                            }
                        }
                    });
                } catch (Throwable unused) {
                }
                g();
            }
        } catch (Throwable unused2) {
        }
    }
}
