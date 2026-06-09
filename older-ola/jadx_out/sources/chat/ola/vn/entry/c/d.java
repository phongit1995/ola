package chat.ola.vn.entry.c;

import chat.ola.vn.entity.ad;
import chat.ola.vn.entity.t;
import chat.ola.vn.h;
import chat.ola.vn.util.m;
import java.util.List;
import java.util.Random;

/* JADX INFO: loaded from: classes.dex */
public class d extends e {
    private t a;
    private String b;

    public d(t tVar, String str) {
        this.a = tVar;
        this.b = str;
    }

    @Override // chat.ola.vn.entry.c.e
    public short a() {
        return (short) 5;
    }

    @Override // chat.ola.vn.entry.c.e
    public void a(int i, short s, String str, chat.ola.vn.entity.d[] dVarArr) {
        try {
            this.a.a((String) null);
            this.a.b(false);
        } catch (Throwable unused) {
        }
    }

    @Override // chat.ola.vn.entry.c.e
    public void a(Object... objArr) {
        String strO;
        ad adVar;
        try {
            try {
                strO = this.a.o();
                adVar = (ad) objArr[0];
            } catch (Throwable unused) {
                return;
            }
            switch (adVar.m()) {
                case 0:
                case 1:
                case 2:
                    if (objArr.length > 1) {
                        if (objArr[1] != null) {
                            try {
                                List<t> listC = t.c((List<ad>) objArr[1]);
                                if (listC != null && listC.size() > 0) {
                                    if (h.H <= 0 && ((adVar.m() == 2 && chat.ola.vn.util.a.b) || chat.ola.vn.util.a.a)) {
                                        listC.add(new Random().nextInt(listC.size()), new t(""));
                                    }
                                    this.a.a(adVar);
                                    if (this.b == null || !m.a(this.a.o(), strO)) {
                                        this.a.a(System.currentTimeMillis());
                                        this.a.a(listC);
                                    } else {
                                        this.a.b(listC);
                                    }
                                    this.a.a(true);
                                }
                            } catch (Throwable unused2) {
                                this.a.a(false);
                            }
                        }
                        if (objArr[2] != null) {
                            this.a.a((String) objArr[2]);
                            this.a.b(true);
                            return;
                        } else {
                            this.a.a((String) null);
                            this.a.b(false);
                            return;
                        }
                    }
                    return;
                    return;
                default:
                    this.a.a(adVar);
                    this.a.a(true);
                    return;
            }
        } catch (Throwable unused3) {
            this.a.a((String) null);
            this.a.b(false);
            this.a.b(false);
        }
        this.a.a((String) null);
        this.a.b(false);
        this.a.b(false);
    }
}
